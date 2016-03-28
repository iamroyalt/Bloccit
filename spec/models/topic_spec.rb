require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

   it { is_expected.to have_many(:posts) }
#we expect topics to have many labelings
   it { is_expected.to have_many(:labelings) }
 #we expect topics to have many labels through labelings
   it { is_expected.to have_many(:labels).through(:labelings) }
#############################################
#Assignment-42 changes
   it { is_expected.to have_many(:commentings)}
   it { is_expected.to have_many(:comments).through(:commentings) }
#############################################
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
end
