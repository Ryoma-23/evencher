class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  #バリデーション
  validates :comment, presence: true
end
