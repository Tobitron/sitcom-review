class Sitcom < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  validates :user_id,
  presence: true
  validates :name,
  presence: true,
  uniqueness: true
  validates :description,
  presence: true,
  length: { minimum: 5 }
  validates :start_year,
  presence: true

  def genre
    self[:genre] || "N/A"
  end

  def network
    self[:network] || "N/A"
  end

  def end_year
    self[:end_year] || "Still Running"
  end

  def owner?(current_user)
    user == current_user
  end
end
