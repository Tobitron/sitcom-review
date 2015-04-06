class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates_uniqueness_of :user_id, scope: :review_id

  def value
    self[:value] || 0
  end
end
