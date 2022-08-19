class Post < ApplicationRecord
    validates :body, :title, presence: true
    belongs_to :user, foreign_key: "user_id"
end
