class Public::EventsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  # before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    # タグ：受け取った値を,で区切って配列にする
    tag_list = params[:event][:tagname].split(',')
    if @event.save
      @event.save_tag(tag_list) # save_tag: モデルファイルで定義
      redirect_to events_path
    else
      render :new
    end
  end

  def index
    @events = Event.page(params[:page]).order(created_at: :desc)
    @tag_list = Tag.all
  end

  def show
    @event = Event.find(params[:id])
    @event_tags = @event.tags
    @event_comment = EventComment.new
    # グループ一覧表示
    @groups = @event.groups.all #イベントに紐付いたグループを探す
  end

  def edit
    @event = Event.find(params[:id])
    is_matching_login_user(@event)
    @tag_list = @event.tags.pluck(:tagname).join(',')
  end

  def update
    @event = Event.find(params[:id])
    is_matching_login_user(@event)
    tag_list = params[:event][:tagname].split(',')
    if @event.update(event_params)
      @event.save_tag(tag_list)
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    is_matching_login_user(event)
    event.destroy
    #タグ削除
    tag_ids = []
    Tag.all.each do |tag|
      if tag.event_tags.count == 0
        tag_ids.push(tag.id)
      end
    end
    Tag.where(id: tag_ids).destroy_all
    redirect_to events_path
  end

  def search
    @events = Event.search(params[:keyword]).page(params[:page]).order(created_at: :desc)
    @tag_list = Tag.all
  end

  def searchtag
    @tag_list = Tag.all #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id]) #クリックしたタグを取得
    @events = @tag.events.page(params[:page]).order(created_at: :desc) #クリックしたタグに紐付けられた投稿を全て表示
    @tag_list = Tag.all
  end

  private

  def event_params
    params.require(:event).permit(:event_image, :name, :introduction, :season_start, :season_end, :time_start, :time_end, :place, :price)
  end

  def is_matching_login_user(event)
    unless event.user_id == current_user.id
      redirect_to events_path
    end
  end
end
