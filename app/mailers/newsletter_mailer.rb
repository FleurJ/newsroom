class NewsletterMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter_mailer.daily.subject
  #
  def daily
    @greeting = "Hi"
    @newsletter = params[:newsletter]

    mail to: User.where(subscribed: true).map(&:email), subject: "Newsletter #{@newsletter.press_review_date.to_s}"
  end
end
