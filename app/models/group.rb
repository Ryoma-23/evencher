class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  has_many :chats, dependent: :destroy #グループはたくさんのメッセージを持っている

  belongs_to :event
end
