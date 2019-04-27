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
      else
        format.html { redirect_to post_path(@post), notice: '投稿できませんでした...' }
      end
    end
  end

  # def edit
  #   @group = Group.find(params[:group_id])
  #   # @post = Post.find(params[:post_id])
  #   @comment = Comment.build
  #   @comment.user_id = current_user.id
  #   format.js { render :edit }
  # end

  # def edit
  #   @comment = Comment.find(params[:id])
  #   format.js { render :edit }
  # end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @id_comment = Comment.find(params[:id]).id
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment: params[:comment][:comment])
      @id_comment = @comment.id
    else
      @status = 'fail'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :content)
  end

end
