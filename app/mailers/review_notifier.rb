class ReviewNotifier < ApplicationMailer
  default from: "reviews@example.com"

  def new_review(review)
    @review = review

    mail(
      to: review.sitcom.user.email,
      subject: "New Review for #{review.sitcom.name}")
  end
end
