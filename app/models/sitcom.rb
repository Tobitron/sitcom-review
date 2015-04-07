class Sitcom < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :user,
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

  def owner_or_admin?(current_user)
    unless current_user == nil
      user == current_user || current_user.admin?
    end
  end
end
