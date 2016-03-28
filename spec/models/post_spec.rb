require 'rails_helper'

RSpec.describe Post, type: :model do
  #let (:post) {Post.create!(title: "New Post Title", body: "New Post Body")}
  #this creates the Parent topic
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  #this is a chained method which creates a post for a topic
     #let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }


   it { is_expected.to have_many(:comments) }
   it { is_expected.to have_many(:votes) }
   it { is_expected.to belong_to(:topic) }
   it { is_expected.to belong_to(:user) }
   it { is_expected.to belong_to(:user) }
   it { is_expected.to validate_presence_of(:title) }
   it { is_expected.to validate_presence_of(:body) }
   it { is_expected.to validate_presence_of(:topic) }
   it { is_expected.to validate_presence_of(:user) }
   it { is_expected.to validate_length_of(:title).is_at_least(5) }
   it { is_expected.to validate_length_of(:body).is_at_least(20) }

   describe "attributes" do
     it "responds to title" do
       expect(post).to respond_to(:title)
     end

     it "responds to body" do
       expect(post).to respond_to(:body)
     end
   end

     it { is_expected.to belong_to(:topic) }

     it { is_expected.to validate_presence_of(:title) }
     it { is_expected.to validate_presence_of(:body) }
     it { is_expected.to validate_presence_of(:topic) }

     it { is_expected.to validate_length_of(:title).is_at_least(5) }
     it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe "attributes" do

    it "responds to title" do
      expect(post).to respond_to(:title)
    end
    it "responds to body" do
      expect(post).to respond_to(:body)
    end
  end

  describe "voting" do
#create 3 up votes and 2 down votes before each voting spec
     before do
       3.times { post.votes.create!(value: 1) }
       2.times { post.votes.create!(value: -1) }
       @up_votes = post.votes.where(value: 1).count
       @down_votes = post.votes.where(value: -1).count
     end

#test thatt up_votes returns the count of up votes
     describe "#up_votes" do
       it "counts the number of votes with value = 1" do
         expect( post.up_votes ).to eq(@up_votes)
       end
     end

#test down votes returns the count of down votes
     describe "#down_votes" do
       it "counts the number of votes with value = -1" do
         expect( post.down_votes ).to eq(@down_votes)
       end
     end

 #test that points returns the sum of all votes on the post
     describe "#points" do
       it "returns the sum of all down and up votes" do
         expect( post.points ).to eq(@up_votes - @down_votes)
       end
     end

     describe "#update_rank" do
#expect that a post's rank will be determined by the following calculation
#determine age of post by subtracting a standard time from its created at time
#this makes newer posts start with a higher ranking which decays over time - an epoch
       it "calculates the correct rank" do
         post.update_rank
         expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
       end

       it "updates the rank when an up vote is created" do
         old_rank = post.rank
         post.votes.create!(value: 1)
         expect(post.rank).to eq (old_rank + 1)
       end

       it "updates the rank when a down vote is created" do
         old_rank = post.rank
         post.votes.create!(value: -1)
         expect(post.rank).to eq (old_rank - 1)
       end
     end
#########Assignment-43##########
 describe "#create vote" do
   it "increases the post up_vote to 1" do
     expect(post.up_votes).to eq(1)
  end

   it "calls #create_vote when a new post is created"
     post = { topic.posts.new(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
     expect(post).to receive(:create_vote)
     post.save
   end

   it "expects the vote to belong to the owner of the post"
    expect(post.votes.first.user).to eq(post.user)
 end
   end
end
