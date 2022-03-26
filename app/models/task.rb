class Task < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :description, presence: true, length: { in: 5..300 }
end
