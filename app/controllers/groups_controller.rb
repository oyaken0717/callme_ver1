class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :group_access
  before_action :required_admin, only: [:edit]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.members.build(user_id: current_user.id, user_is_author: true)
    # @group = current_user.groups.build(group_params)
    if @group.save #&& Member.create(user_id: current_user.id, group_id: params[:group_id] )
      redirect_to groups_path, notice: "グループを作成しました！"
    else
      render 'new'
    end

  end

  def show
    @member = current_user.members.find_by(group_id: @group.id)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "グループを編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice:"グループを削除しました！"
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_access
    redirect_to new_session_path unless logged_in?
  end

  def required_admin
    redirect_to groups_path unless current_user&.is_author(@group.id)
  end
end
