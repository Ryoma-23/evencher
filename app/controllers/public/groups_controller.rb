class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.ownew_id = current_user.id
    # @group.event_id = event.id #イベントに紐付け
    if @group.save
      redirect_to event_groups_path
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

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to event_groups_path
    end
  end
end
