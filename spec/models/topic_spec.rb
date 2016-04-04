require 'rails_helper'

RSpec.describe Topic, type: :model do
  #let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:topic) { create(:topic) }
   it { is_expected.to have_many(:posts) }
#we expect topics to have many labelings
   it { is_expected.to have_many(:labelings) }
 #we expect topics to have many labels through labelings
   it { is_expected.to have_many(:labels).through(:labelings) }



   describe "attributes" do
     it "responds to name" do
       expect(topic).to respond_to(:name)
     end

     it "responds to description" do
       expect(topic).to respond_to(:description)
     end

     it "responds to public" do
       expect(topic).to respond_to(:public)
     end

     it "is public by default" do
       expect(topic.public).to be(true)
     end
   end

   describe "scopes" do
     before do
#Checkpoint -45 create public and private topics to use for testing scopes
       @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
       @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
     end

     describe "visible_to(user)" do
       it "returns all topics if the user is present" do
         user = User.new
#expect visible_to scope to return all topics if user is present
         expect(Topic.visible_to(user)).to eq(Topic.all)
       end
#Assignment-46 publically_viewable spec
       describe "publically_viewable" do
         it "returns public topics" do
           expect(Topic.publically_viewable).to eq([@public_topic])
         end
       end
#Assignment-46 privately_viewable spec
         describe "privately_viewable" do
           it "returns private topics" do
             expect(Topic.privately_viewable).to eq([@private_topic])
           end
         end
       it "returns only public topics if user is nil" do
#expect visible_to scope to return public topics if a user isn't present
         expect(Topic.visible_to(nil)).to eq([@public_topic])
       end
     end
   end
end
