class Public::ChatsController < ApplicationController

  def create
    @group = Group.find(params[:group_id]) #グループのidを探す
    @chat = Chat.new(chat_params)
    respond_to do |format|
      if @chat.save
        format.html { redirect_to @chat } # HTMLで返す場合、showアクションを実行し詳細ページを表示
        format.js # create.js.erbが呼び出される
      else
        format.html { render :show } # HTMLで返す場合、show.html.erbを表示
        format.js { render :errors } # 一番最後に実装の解説があります
      end
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :group_id).merge(user_id: current_user.id)
  end
end