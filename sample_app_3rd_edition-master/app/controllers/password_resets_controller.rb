class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new # 関数定義
  end

  def create # 関数定義
    @person = User.find_by(email: params[:password_reset][:email].downcase)
    if @person
      @person.create_reset_digest
      @person.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit # 関数定義
  end

  def update # 関数定義
    if params[:user][:password].empty?
      @person.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @person.update_attributes(user_params)
      log_in @person
      flash[:success] = "Password has been reset."
      redirect_to @person
    else
      render 'edit'
    end
  end

  private

    def user_params # 関数定義
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Before filters

    def get_user # 関数定義
      @person = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user # 関数定義
      unless (@person && @person.activated? &&
              @person.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    def check_expiration # 関数定義
      if @person.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
