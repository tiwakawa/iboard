class Topic < ActiveRecord::Base
  include ConcernedWithOwn

  attr_accessible :title, :user_id

  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: { maximum: 100 }
end
