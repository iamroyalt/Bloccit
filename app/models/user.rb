class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save { self.role ||= :member }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
 #validates to ensure name is present and has min/max length
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }


  has_secure_password

  enum role: [:member, :admin]
#this method takes a post object and uses where to retrieve teh user's favorites with a
#post_id that matches post.id. If the user has favorited post it will return an array of 1 item
#if they haven't favorited it will return an empty array
#call first on the array will return either the favorite or nil depending on whether they favorited the post
   def favorite_for(post)
     favorites.where(post_id: post.id).first
   end

   def avatar_url(size)
     gravatar_id = Digest::MD5::hexdigest(self.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
   end
#Assignment-45
#method to determine is user has any comments or posts  or favorites by using count method
#this is connected to user show view if statements

    def user_posts?
      self.posts.count > 0
    end

   def user_comments?
     self.comments.count > 0
   end

   def user_favorites?
     self.favorites.count > 0
   end
end
