class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :sitcom

  validates :rating, presence: true,
  numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :user, presence: true
  validates :sitcom, presence: true
  validates :user_id, uniqueness: true,
                      scope: [:sitcom_id],
                      message: "You have already reviewed this show."

  def owner?(current_user)
    user == current_user
  end
end
