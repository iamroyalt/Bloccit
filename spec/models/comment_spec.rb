require 'rails_helper'
include RandomData

RSpec.describe Comment, type: :model do
#########Assignment-42 changes
   let(:comment) { Comment.create!(name: 'Comment') }
###################
   let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
   let(:comment) { Comment.create!(body: 'Comment Body', topic: topic, post: post, user: user) }

      #it { is_expected.to belong_to(:post) }
      #it { is_expected.to belong_to(:user) }

###########Assignment-42 changes############
      it { is_expected.to have_many :commentings}
      it { is_expected.to have_many(:topics).through(:commentings) }
      it { is_expected.to have_many(:posts).through (:commentings)}
########################
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_length_of(:body).is_at_least(5) }
################Assignment-42##############
   describe "commentings" do
      it "allows comments to be associated with different topics and posts" do
        topic.comments << comment
        post.comments << comment

        topic_comment = topic.comments[0]
        post_comment = post.comments[0]

        expect(topic_comments).to eql(post_comments)
      end
    end
###########################################

   describe "attributes" do
     it "responds to body" do
       expect(comment).to respond_to(:body)
     end
   end
end
