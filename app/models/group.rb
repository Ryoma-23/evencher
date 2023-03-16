class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy

  belongs_to :event

  validates :name, presence: true
end
