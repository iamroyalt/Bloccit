require 'rails_helper'

RSpec.describe Post, type: :model do
  #let (:post) {Post.create!(title: "New Post Title", body: "New Post Body")}
  #this creates the Parent topic
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  #this is a chained method which creates a post for a topic
     let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

     it { is_expected.to belong_to(:topic) }

  describe "attributes" do

    it "responds to title" do
      expect(post).to respond_to(:title)
    end
    it "responds to body" do
      expect(post).to respond_to(:body)
    end
  end
end
