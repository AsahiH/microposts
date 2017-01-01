class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Simple App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
   def followings
      @user  = User.find(params[:id])
      @users = @user.following_users
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follower'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to(root_url) if @user != current_user
  end
end 