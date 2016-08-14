class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
  validate :image_size
  
   has_many :favorites
   has_many :favusers, through: :favorites
  
  private
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end
end
