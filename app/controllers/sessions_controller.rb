class SessionsController < ApplicationController

  def new
    redirect_to users_path if logged_in?
  end


  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password])
  #     session[:user_id] = user.id
  #     flash[:notice] = "ログインしました"
  #     redirect_to user_path(user.id)
  #   else
  #     flash.now[:danger] = "ログイン失敗"
  #     render "new"
  #   end
  # end

  def create
    # @user = User.find_by(email: params[:session][:email].downcase)
    # @user = User.find_by(email: params[:session][:email].downcase)
    @user = User.find_by(params.require(:session).permit(:email, :password))
    # Blog.create(params.require(:blog).permit(:title, :content))
    @user&.email = @user&.email&.downcase
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to user_path(@user.id)
    else
      # flash.now[:danger] = "ログイン失敗"
      render "new"
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end

  private

  def session_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :password, :password_confirmation)
  end
end
