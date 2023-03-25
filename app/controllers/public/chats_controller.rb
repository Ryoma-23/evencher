class Public::ChatsController < ApplicationController

  def create
    @group = Group.find(params[:group_id]) #グループのidを探す
    @chat = Chat.new(chat_params)
    if @chat.save
      
    else
      render '/public/groups/show'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :group_id).merge(user_id: current_user.id)
  end
end