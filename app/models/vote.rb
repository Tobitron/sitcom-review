class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  validates :value, inclusion: {in: [-1, 0, 1]}
  validates_uniqueness_of :user_id, scope: :review_id

  def value
    self[:value] || 0
  end

  def first_upvote
    self.value = 1
    unless self.save
      flash[:notice] = "Something went wrong"
    end
  end

  def first_downvote
    self.value = -1
    unless self.save
      flash[:notice] = "Something went wrong"
    end
  end

  def is_upvote?
    self.value == 1
  end

  def is_downvote?
    self.value == -1
  end

  def is_neutral?
    self.value == 0
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

  #elsif user_vote.value == 0 || user_vote.value == -1
end
