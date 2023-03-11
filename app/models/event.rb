class Event < ApplicationRecord
  has_one_attached :event_image
  belongs_to :user

  def get_event_image
    unless event_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      event_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    event_image
  end
  
  def self.search(search)
    if search != ""
      Event.where(['name LIKE(?) OR place LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      Event.includes(:user).order('created_at DESC')
    end
  end
end
