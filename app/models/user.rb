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
    has_many :posts
    has_many :following_relationships, class_name: "Relationship",
                                       foreign_key: "follower_id",
                                       dependent: :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    has_many :follower_relationships, class_name: "Relationship",
                                      foreign_key: "followed_id",
                                      dependent: :destroy
    has_many :follower_users, through: :fllower_relationships, source: :follower
    
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    def following?(other_user)
        following_user.include?(other_user)
    end
    
    def feed_items
       Post.where(user_id: following_user_ids+[self.id])
    end
                                       
end
