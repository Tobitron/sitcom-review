class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  validates :value, inclusion: {in: [-1, 0, 1]}
  validates_uniqueness_of :user_id, scope: :review_id

  def value
    self[:value] || 0
  end

  def is_upvote?
    value == 1
  end

  def is_downvote?
    value == -1
  end

  def is_neutral?
    value == 0
  end

  def to_upvote
    update_attributes(value:  1)
  end

  def to_downvote
    update_attributes(value:  -1)
  end

  def to_neutral
    update_attributes(value:  0)
  end

  def upvote
    if is_neutral? || is_downvote?
      to_upvote
    else
      to_neutral
    end
  end

  def downvote
    if is_neutral? || is_upvote?
      to_downvote
    else
      to_neutral
    end
  end
end
