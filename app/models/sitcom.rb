class Sitcom < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  validates :start_year, presence: true

  def genre
    self[:genre] || "N/A"
  end

  def network
    self[:network] || "N/A"
  end

  def end_year
    self[:end_year] || "Still Running"
  end
end

# has_many :reviews
