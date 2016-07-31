class UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :followings, :followers]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path , notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end
  
  def followings
    @title = 'Followings'
    @users = @user.following_users.page(params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = 'Followers'
    @users = @user.follower_users.page(params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location)
  end
  
  def correct_user
    redirect_to root_path if @user != current_user
  end
  
  def set_params
    @user = User.find(params[:id])
  end
end
