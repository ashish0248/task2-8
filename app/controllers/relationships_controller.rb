class RelationshipsController < ApplicationController
    before_action :set_user, only:[:create, :destroy]
    # フォロー一覧
    def index
      @user = User.find(params[:id])
      @users = @user.followings
    end

  # フォロワー一覧
    def new
      @user = User.find(params[:id])
      @users = @user.followers
    end


  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] =  'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

    private

    def set_user
    @user = User.find(params[:follow_id])
    end
end


