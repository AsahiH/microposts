class Micropost < ActiveRecord::Base
  belongs_to :user
  paginates_per 10
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end