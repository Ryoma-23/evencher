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
  end

  def edit
  end
  
  private
  
  def event_params
    params.require(:event).permit(:name, :introduction, :season_start, :season_end, :time_start, :time_end, :place, :price)
  end
end
