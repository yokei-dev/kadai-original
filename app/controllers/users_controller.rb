class UsersController < ApplicationController
  
before_action :require_user_logged_in, only: [:index, :show, :edit,:update,:destroy]
  
  def index
    @users = User.all.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @trips = @user.trips.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録をしました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザーを更新しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザー更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @like_trips = @user.like_trips.page(params[:page])
    counts(@user)
  end  
    
    
    
  private
  
  
  
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
end
