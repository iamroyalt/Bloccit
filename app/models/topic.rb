class Topic < ActiveRecord::Base
  #has_many :posts
  has_many :posts, dependent: :destroy
#we define a has_many relationship between Topic and Labeling using the lablelable interface
   has_many :labelings, as: :labelable
#we define a has_many relationship between topic and label using the Labeling class through the lablelable interface
   has_many :labels, through: :labelings
#scope is a method which generates methods
   scope :visible_to, -> (user) { user ? all : where(public: true) }
end
