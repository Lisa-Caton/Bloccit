FactoryBot.define do
   factory :post do
     title RandomData.random_sentence
     body RandomData.random_paragraph
     topic
     user
     rank 0.0
   end
 end
 # we define a new factory for posts that generates a post with a random title and body.