class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = @current_user.follow(@user)
    if following.save
      flash[:notice] = "ユーザーをフォローしました"
      redirect_back(fallback_location: users_index_path) 
    else
      flash.now[:notice] = "ユーザーのフォローに失敗しました"
      redirect_back(fallback_location: users_index_path)
    end
  end

  def destroy
    following = @current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = "ユーザーのフォローを解除しました"
      redirect_back(fallback_location: users_index_path)
    else
      flash.now[:notice] = "ユーザーのフォロー解除に失敗しました"
      redirect_back(fallback_location: users_index_path)
    end
  end

  private
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end