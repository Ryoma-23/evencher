class Event < ApplicationRecord
  has_one_attached :event_image
  belongs_to :user
end
