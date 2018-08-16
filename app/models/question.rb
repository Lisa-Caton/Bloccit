class Question < ApplicationRecord
    has_many :answers
    # We add the answers association to Question
    # This relates the models and allows us to call question.answers
end
