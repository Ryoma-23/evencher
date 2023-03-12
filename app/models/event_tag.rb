class EventTag < ApplicationRecord
  belongs_to :event
  belongs_to :tag
  
  # なくても問題ない気がする
  validates :event_id, presence: true
  validates :tag_id, presence: true
end
