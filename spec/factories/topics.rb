FactoryGirl.define do
   factory :topic do
     name RandomData.random_name
     description RandomData.random_sentence
   end
 end

#define a new factory for topics that generates a topic with random name and description
