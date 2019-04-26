class CommentsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    # 上の@comment２つを１つにするほうほう。@comment = current_user.post.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
        # format.html { redirect_to post_path(@post), notice: '投稿できませんでした...' }
# binding.pry
      else
        format.html { redirect_to post_path(@post), notice: '投稿できませんでした...' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
    # .merge(user_id:current_user.id)
  end

end
