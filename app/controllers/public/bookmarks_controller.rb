class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  
  def create
    @event = Event.find(params[:event_id])
    @bookmark = @event.bookmarks.find_or_create_by(user_id: current_user.id)
    render 'public/bookmarks/create'
  end
  
  def destroy
    @event = Event.find(params[:event_id])
    @bookmark = @event.bookmarks.find_by(user_id: current_user.id)
    @bookmark.destroy if @bookmark
    render 'public/bookmarks/destroy'
  end
end
