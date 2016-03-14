require 'rails_helper'

RSpec.describe Comment, type: :model do
  #let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
   let(:comment) { Comment.create!(body: 'Comment Body', post: post) }
   let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
        let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
   describe "attributes" do
     it "responds to body" do
       expect(comment).to respond_to(:body)
     end
   end
end
