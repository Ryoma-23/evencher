class Public::ChatsController < ApplicationController

  def create
    @group = Group.find(params[:group_id]) #グループのidを探す
    @chat = Chat.new(chat_params)
    @chat.save
    redirect_to event_group_path(@group.event, @group)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :group_id).merge(user_id: current_user.id)
  end
end