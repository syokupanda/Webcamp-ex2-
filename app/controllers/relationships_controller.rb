class RelationshipsController < ApplicationController

  def follow
    current_user.follow(params[:id])
    redirect_to users_path
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to users_path
  end

  def follower_index
    @user = User.find(params[:id])
    @users = @user.follower_user
  end

  def followed_index
     @users = User.all
  end

end
