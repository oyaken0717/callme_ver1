class MembersController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
  end

  def create
    @member = current_user.members.create(group_id: params[:group_id])
    redirect_to groups_path(@member.group_id)
    # , notice: "#{member.group.user.name}さんのグループに参加しました"
  end

  def show
    @member = Member.find_by(id:params[:id])
  end

  def destroy
    member = Member.find_by(id: params[:id])
    # @group = Group.find(params :group_id)
    @group = Group.find_by(id: params[:group_id])
    if member.destroy
      redirect_to group_path(@group)
    else
      # return_back and return
      redirect_to group_path(@group)
    end
    # , notice: "#{member.group.user.name}さんのグループを退会しました"
  end
end
