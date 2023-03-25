class Event < ApplicationRecord
  has_one_attached :event_image
  belongs_to :user

  #タグのリレーション
  has_many :event_tags, dependent: :destroy
  has_many :tags, through: :event_tags, dependent: :destroy

  #ブックマークのリレーション
  has_many :bookmarks, dependent: :destroy

  #コメントのリレーション
  has_many :event_comments, dependent: :destroy

  #グループのリレーション
  has_many :groups, dependent: :destroy

  #バリデーション
  validates :name, presence: true
  validates :introduction, presence: true
  validates :season_start, presence: true
  validates :season_end, presence: true
  validates :time_start, presence: true
  validates :time_end, presence: true
  validates :place, presence: true

  validate :start_end_check

  #開始日と終了日の逆転防止
  def start_end_check
    return false if season_start.blank? || season_end.blank?
    errors.add(:season_end, "は開始日より前の日付は登録できません。") unless
    self.season_start <= self.season_end
  end

  # イベント画像
  def get_event_image
    unless event_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      event_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    event_image
  end

  # 検索機能
  def self.search(search)
    if search != ""
      Event.where(['name LIKE(?) OR place LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      Event.includes(:user).order('created_at DESC')
    end
  end

  # タグ機能
  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tagname: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tagname: new)
      self.tags << new_post_tag
    end
  end

  # ブックマーク機能
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
