class DeviseMailer < Devise::Mailer
  # Simple welcome email upon user registration, not call to action.
  #
  def welcome_message(record, opts={})
    devise_mail(record, :welcome_message, opts)
  end
end
