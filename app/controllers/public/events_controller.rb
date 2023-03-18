class Public::EventsController < ApplicationController
  before_action :authenticate_user!, except: [:top]

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
    @events = Event.page(params[:page])
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
    @tag_list = @event.tags.pluck(:tagname).join(',')
  end

  def update
    @event = Event.find(params[:id])
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
    event.destroy
    redirect_to events_path
  end

  def search
    @events = Event.search(params[:keyword])
    @tag_list = Tag.all
  end

  def searchtag
    @tag_list = Tag.all #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id]) #クリックしたタグを取得
    @events = @tag.events.all #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def event_params
    params.require(:event).permit(:event_image, :name, :introduction, :season_start, :season_end, :time_start, :time_end, :place, :price)
  end
end
