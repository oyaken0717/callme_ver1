class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to group_posts_path, notice: "お気に入り登録しました"
  end

  def index
    @favorites = Favorite.all
    @group = Group.find(params[:group_id])
  end

  def destroy
    if favorite = current_user.favorites.find_by(id: params[:id]).destroy
      redirect_to group_posts_path, notice: "お気に入り解除しました"
    else
      redirect_to group_posts_path
    end
  end
end
