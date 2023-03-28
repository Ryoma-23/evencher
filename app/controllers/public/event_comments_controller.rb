class Public::EventCommentsController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def create
    @event = Event.find(params[:event_id])
    @comment = current_user.event_comments.new(event_comment_params)
    @comment.event_id = @event.id
    @comment.save
    render :event_comments #render先にjsファイルを指定
  end

  def destroy
    EventComment.find_by(id: params[:id], event_id: params[:event_id]).destroy
    @event = Event.find(params[:event_id]) #renderしたときに@eventのデータがないので@eventを定義
    render :event_comments #render先にjsファイルを指定
  end

  private

  def event_comment_params
    params.require(:event_comment).permit(:comment)
  end
end
