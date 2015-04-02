class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :sitcom

  validates :rating, presence: true,
  numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :user, presence: true
  validates :sitcom, presence: true
  validates_uniqueness_of :user_id, scope: [:sitcom_id], message: "You have already reviewed this show."

  scope :newest_first, -> { order(created_at: :desc) }

  def owner?(current_user)
    user == current_user
  end
end
