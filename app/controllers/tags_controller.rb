class TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to groups_path, notice: "タグを作成しました。"
    else
      @groups = Group.all
      @group = Group.find_by(id: params[:group_id])
      @posts = Post.where(group_id: Group.find_by(id: params[:group_id]))
      # render "create", notice: "もう一回チャレンジしてみてください！！"
      flash.now[:notice] = "もう一回チャレンジしてみてください！！"
      render 'groups/index'#, notice: "もう一回チャレンジしてみてください！！"

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
