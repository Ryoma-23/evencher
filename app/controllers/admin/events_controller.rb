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
    redirect_to admin_events_path
  end
end