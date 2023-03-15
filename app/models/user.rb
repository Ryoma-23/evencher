class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  #イベントのリレーション
  has_many :events, dependent: :destroy
  
  #ブックマークのリレーション
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_events, through: :bookmarks, source: :event
  
  #コメントのリレーション
  has_many :event_comments, dependent: :destroy
  
  #グループのリレーション
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, source: :event

  #ユーザーアイコン
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/icon_no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image
  end

  #ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # end_user.confirmed_at = Time.now
      user.name = "ゲスト"
    end
  end

  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
