class Public::EventsController < ApplicationController
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save
    redirect_to events_path
  end

  def index
    @event = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    event = Event.find(params[:id])
    event.update(event_params)
    redirect_to event_path(event.id)
  end
  
  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to events_path
  end
  
  private
  
  def event_params
    params.require(:event).permit(:event_image, :name, :introduction, :season_start, :season_end, :time_start, :time_end, :place, :price)
  end
end
