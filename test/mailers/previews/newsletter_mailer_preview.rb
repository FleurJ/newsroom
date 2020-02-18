# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/newsletter_mailer/daily
  def daily
    newsletter = Newsletter.last
    NewsletterMailer.with(newsletter: newsletter).daily
  end

end
