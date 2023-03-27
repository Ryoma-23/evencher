class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @events = Event.page(params[:page]).order(created_at: :desc)
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def destroy
    event = Event.find(params[:id])
    event.destroy
    #タグ削除
    tag_ids = []
    Tag.all.each do |tag|
      if tag.event_tags.count == 0
        tag_ids.push(tag.id)
      end
    end
    Tag.where(id: tag_ids).destroy_all
    redirect_to admin_events_path
  end
end