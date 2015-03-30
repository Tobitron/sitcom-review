class Review < ActiveRecord::Base
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :user, presence: true
  #validates :sitcom, presence: true

  belongs_to :user
  #belongs_to :sitcom

end
