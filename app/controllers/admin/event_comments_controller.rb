class Admin::EventCommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @event_comments = EventComment.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    EventComment.find(params[:id]).destroy
    redirect_to admin_event_comments_path
  end
end
