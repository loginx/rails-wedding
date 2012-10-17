class Notifications < ActionMailer::Base
  layout 'notifications'
  default from: "no-reply@xjdecember.com", bcc: "xavier@madpython.com", reply_to: 'xavier@madpython.com'

  def dispatch_rsvp(rsvp)
    Rails.logger.warn("RSVP from mailer: #{rsvp.inspect}")
    @rsvp = Rsvp.find(rsvp['id'])

    mail(to: "xavier@madpython.com", subject: "[RSVP] New wedding RSVP submission")
  end

  def confirm_rsvp(guest)
    @guest = Guest.find(guest['id'])
    mail(to: @guest.email, subject: "Your RSVP submission for Xavier and Juliane's wedding")
  end
end
