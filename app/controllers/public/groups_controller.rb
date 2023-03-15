class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @event = Event.find(params[:event_id])
    @groups = @event.groups.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @event = Event.find(params[:event_id])
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @event = Event.find(params[:event_id])
    @group.owner_id = current_user.id
    @group.event_id = @event.id #イベントに紐付け
    if @group.save
      redirect_to event_groups_path(@event)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to event_groups_path
    else
      render 'edit'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  #グループのオーナーか判断して制限
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to event_groups_path
    end
  end
end
