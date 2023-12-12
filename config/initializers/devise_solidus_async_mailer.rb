# config/initializers/devise_solidus_async_mailer.rb

module DeviseSolidusAsyncMailer
    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
  
  # Include the module in the relevant models
  Devise::Models::Confirmable.prepend DeviseSolidusAsyncMailer
  Devise::Models::Recoverable.prepend DeviseSolidusAsyncMailer
  # Add other Devise modules as needed
  