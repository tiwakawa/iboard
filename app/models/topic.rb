class Topic < ActiveRecord::Base
  attr_accessible :title, :user_id

  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
end
