class EventMailer < ActionMailer::Base
  default from: 'Vigap <no-reply@vigap.com>'

  def post_commented(event, receiver)
    @event = event

    mail to: receiver.email, subject: %[New comment on "#{event.post.title}"]
  end
end
