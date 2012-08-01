class Comment < ActiveRecord::Base
  include ConcernedWithOwn

  attr_accessible :body, :user_id

  belongs_to :user
  belongs_to :topic

  validates :body, presence: true, length: { maximum: 300 }
end
