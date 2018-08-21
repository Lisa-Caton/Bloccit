FactoryBot.define do
   factory :vote do
     name RandomData.random_name
     description RandomData.random_sentence
     value 1
     user
     post
   end
 end
