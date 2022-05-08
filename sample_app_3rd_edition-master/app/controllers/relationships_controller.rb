class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create # 関数定義
    @person = User.find(params[:followed_id])
    current_user.follow(@person)
    respond_to do |format|
      format.html { redirect_to @person }
      format.js
    end
  end
  
  def destroy # 関数定義
    @person = Relationship.find(params[:id]).followed
    current_user.unfollow(@person)
    respond_to do |format|
      format.html { redirect_to @person }
      format.js
    end
  end
end
