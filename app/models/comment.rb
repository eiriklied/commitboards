class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commit, counter_cache: true
  validates :user_id, :commit_id, presence: true
  validates :body, presence: true
end
