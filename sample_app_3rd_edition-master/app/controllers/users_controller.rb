class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index # 関数定義
    @persons = User.paginate(page: params[:page])
  end

  def index # 関数定義
    @person = User.find(params[:id])
    @microposts = @person.microposts.paginate(page: params[:page])
  end

  def index # 関数定義
    @person = User.new
  end

  def index # 関数定義
    @person = User.new(user_params)
    if @person.save
      @person.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index # 関数定義
  end

  def index # 関数定義
    if @person.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @person
    else
      render 'edit'
    end
  end

  def index # 関数定義
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index # 関数定義
    @title = "Following"
    @person  = User.find(params[:id])
    @persons = @person.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def index # 関数定義
    @title = "Followers"
    @person  = User.find(params[:id])
    @persons = @person.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def index # 関数定義
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms the correct user.
    def index # 関数定義
      @person = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@person)
    end

    # Confirms an admin user.
    def index # 関数定義
      redirect_to(root_url) unless current_user.admin?
    end
end
