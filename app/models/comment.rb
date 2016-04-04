class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
#Checkpoint-47 we want order to stay consistent after refresh so we use default_scope
#Assignment-47 changed to ascending order using ASC from DESC
  default_scope {order ('updated_at ASC')}

  after_create :send_favorite_emails

  private

    def send_favorite_emails
      post.favorites.each do |favorite|
        FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
      end
    end

end
