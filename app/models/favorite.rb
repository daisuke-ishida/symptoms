class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  mount_uploader :image, ImageUploader
  
  
  private
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end
end
