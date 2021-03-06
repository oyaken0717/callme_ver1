class TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to group_posts_path, notice: "タグを作成しました。"
    else
      @groups = Group.all
      # @group = Group.find_by(id:[:group_id])
      @group = Group.find(params[:group_id])

      # @group = Group.find_by(id: params[:group_id])
      # @posts = Post.where(group_id: Group.find_by(id: params[:group_id]))
      # flash.now[:notice] = "もう一度チャレンジしてみてください！！"
      # render 'groups/index'
      # render group_posts_path(@group)
      redirect_to group_posts_path, notice: "もう一度チャレンジしてみてください！！"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_users_path, notice: "タグを削除しました。"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
