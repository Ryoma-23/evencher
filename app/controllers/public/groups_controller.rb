class Public::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def show
    @group = Group.find(params[:id])
    # チャットの表示
    @chats = @group.chats.page(params[:page]).order(created_at: :desc).per(30)
    @chat = Chat.new(group_id: @group.id)
  end

  def new
    @event = Event.find(params[:event_id])
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @event = Event.find(params[:event_id]) #イベントを探す
    @group.owner_id = current_user.id
    @group.event_id = @event.id #イベントに紐付け
    @group.users << current_user # @group.usersに、current_userを追加
    if @group.save
      redirect_to event_path(@event.id)
    else
      render 'new'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @event = Event.find(params[:event_id]) #イベントのidを探す
    if @group.destroy
      redirect_to event_path(@event.id)
    end
  end

  def join #イベント参加
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id]) #イベントを探す
    @group.users << current_user # @group.usersに、current_userを追加
    redirect_to event_path(@event.id)
  end

  def withdrawal #イベント退会
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:event_id]) #イベントのidを探す
    #current_userは、@group.usersから消される記述
    @group.users.delete(current_user)
    redirect_to event_path(@event.id)
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

end
