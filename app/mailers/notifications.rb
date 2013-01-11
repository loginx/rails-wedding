class Notifications < ActionMailer::Base
  layout 'notifications'
  default from: ENV['DEVISE_EMAILS_FROM'].dup

  def dispatch_rsvp(rsvp)
    Rails.logger.warn("RSVP from mailer: #{rsvp.inspect}")
    @rsvp = Rsvp.find(rsvp['id'])

    mail(to: ENV['NOTIFICATION_EMAIL'].dup.split(';'), subject: "[RSVP] New wedding RSVP submission")
  end

  def confirm_rsvp(guest)
    @guest = Guest.find(guest['id'])
    mail(to: @guest.email, subject: "Your RSVP submission for Xavier and Juliane's wedding")
  end
end
