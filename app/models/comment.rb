class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :body, presence: true
  validates :user, presence: true
  validates :review, presence: true

  def owner_or_admin?(current_user)
    unless current_user == nil
      user == current_user || current_user.admin?
    end
  end
end
