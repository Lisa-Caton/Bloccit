FactoryBot.define do
   factory :topic do
     name RandomData.random_name
     description RandomData.random_sentence
   end
 end
 # we define a new factory for topics that generates a topic with a random name and description.