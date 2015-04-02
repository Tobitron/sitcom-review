class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :sitcom
  has_many :comments, dependent: :destroy

  validates :rating, presence: { message: "You must select a rating." },
             numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :user, presence: true
  validates :sitcom, presence: true
  validates_uniqueness_of :user_id, scope: [:sitcom_id], message: "You have already reviewed this show."
  scope :newest_first, -> { order(created_at: :desc) }

  def owner_or_admin?(current_user)
    unless current_user == nil
      user == current_user || current_user.admin?
    end
  end
end
