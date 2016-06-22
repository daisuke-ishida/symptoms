class User < ActiveRecord::Base
    before_save { self.email = seof.email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
    validates :sex, presence: true
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
end
