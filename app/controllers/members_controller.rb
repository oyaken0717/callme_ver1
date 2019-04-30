class MembersController < ApplicationController
  def index
    # @members = Member.find_by(group_id: params[:group_id])
    # @members = Member.user.groups
    @group = Group.find(params[:group_id])
    # binding.pry
  end

  def create
    member = current_user.members.create(group_id: params[:group_id])
    redirect_to groups_url
    # , notice: "#{member.group.user.name}さんのグループに参加しました"
  end

  def show
    @member = Member.find_by(id:params[:id])
  end

  def destroy
    # member = current_user.members.find_by(id: params[:id]).destroy

    member = Member.find_by(id: params[:id]).destroy
    member.destroy

    redirect_to groups_url
    # , notice: "#{member.group.user.name}さんのグループを退会しました"
  end
end
