require 'rails_helper'
include RandomData

 RSpec.describe Label, type: :model do
   #let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   #let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   #let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
   let(:topic) { create(:topic) }
   let(:user) { create(:user) }
   let(:post) { create(:post) }
   let(:label) { create(:label, name: "label") }
   let(:label2) {  create(:label, name: "label2") }

   it { is_expected.to have_many :labelings }
   it { is_expected.to have_many(:topics).through(:labelings) }
   it { is_expected.to have_many(:posts).through(:labelings) }

   describe "labelings" do
     it "allows the same label to be associated with a different topic and post" do
       topic.labels << label
       post.labels << label

       topic_label = topic.labels[0]
       post_label = post.labels[0]

       expect(topic_label).to eql(post_label)
     end
   end
#we see describe .update_labels do because it is a class method because it affects more than one label at a times
#so it doesn't make sense to make it an instance method
   describe ".update_labels" do
      it "takes a comma delimited string and returns an array of Labels" do
        labels = "#{label.name}, #{label2.name}"
        labels_as_a = [label, label2]
#expect update_labels to return an array of label objects which are parsed from the comma delimited string that is passed in
        expect(Label.update_labels(labels)).to eq(labels_as_a)
      end
    end
 end
