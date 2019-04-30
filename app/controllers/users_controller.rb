class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login
    else
      render "new"
    end
  end

  def index
    @users = User.all
    if params[:user].present?
      @users = User.search_name(params[:user][:name])
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  private

  def login
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "ログイン失敗"
      render "new"
    end
  end

  def set_user
    user_optional = User.find_by(id:params[:id])
    if user_optional
      @user = user_optional
    else
      redirect_to users_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :password, :password_confirmation)
  end
end
