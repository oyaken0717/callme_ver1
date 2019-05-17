class PostsController < ApplicationController
  before_action :post_access
  # before_action :is_member, only: [:index, :new, :show, :create, :edit, :update]
  before_action :is_member
  # before_action :is_member2, only: [:destroy]
  before_action :check_correct_post, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :destroy, :update]


  def index
    @posts = Post.where(group_id: Group.find_by(id: params[:group_id]))
    # Page.where(category_id: 1)
    # @group = Group.find_by(id:params[:group_id])
# ーー検索フォーム（titleで）ーーーーーーーーーーーーーーーーーーーーーーーーーー
    if params[:post].present?
      @posts = Post.search_title(params[:post][:title])
        if @posts.nil? #もし@postsがnilであれば
          @group = Group.find_by(id: params[:group_id]) #まずGroupのidをparamsからとって
          redirect_to group_posts_path(@group) #リダイレクトさせる
        end
    end
    # @posts = Post.all.order(仕事の難しさレベル: :asc) if params[:仕事の難しさレベル] == "true"
  end
#A一番初め
  # def new
  #   if params[:back]
  #     @post = Post.new(post_params)
  #   else
  #     @post = Post.new
  #   end
  # end
#Bネストver
  # def new
  #   @group = Group.find(params[:group_id])
  #   @post = Post.new
  # end
#C Aに、プラスBver
  def new

    if params[:back]
      @post = Post.new(post_params)
    else
      @group = Group.find(params[:group_id])
      @post = Post.new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @group = Group.find_by(id:params[:group_id])
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # ContactMailer.contact_mail(@post).deliver
      redirect_to group_posts_path, notice:"作成ができました。"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to group_posts_path, notice: "編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to group_posts_path, notice: "削除しました"
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  private

  def set_post
    post_optional = Post.find_by(id:params[:id])
    if post_optional
      @post = post_optional
    else
      redirect_to group_posts_path
    end
  end

  def post_params
    # params.require(:post).permit(:title, :content, :image, :image_cache, :group_id, tag_ids: [])
    params.require(:post).permit(:title, :content, :image, :image_cache, tag_ids: []).merge(group_id: params[:group_id])
  end

  def check_correct_post
    if current_user != Post.find(params[:id]).user
      redirect_to group_posts_path
    end
  end

  def post_access
      redirect_to new_session_path unless logged_in?
  end

  def is_member(group = Group.find_by(id: params[:group_id]))
    redirect_to groups_path if group&.members.length == 0
    join_member = group&.members.select { |member| member&.user_id == current_user.id }[0]
    redirect_to groups_path if join_member.nil?
  end

  # def is_member2
  #   group = Group.find(params[:group_id])
  #   redirect_to group_posts_path(group) if group&.members.length == 0
  #   join_member = group&.members.select { |member| member&.user_id == current_user.id }[0]
  #   redirect_to group_posts_path(group) if join_member.nil?
  # end
end
