class Admin::EventCommentsController < ApplicationController
  def index
    @event_comments = EventComment.all
  end
  
  def destroy
    EventComment.find(params[:id]).destroy
    redirect_to admin_event_comments_path
  end
end
