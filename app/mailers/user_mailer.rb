class UserMailer < ApplicationMailer
  require 'mailgun-ruby'

  API_KEY = ENV['MAILGUN_API_KEY']
  MAILGUN_DOMAIN = ENV['MAILGUN_DOMAIN']
  ADMIN_EMAIL = ENV['ADMIN_EMAIL']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password.subject
  #
  def reset_password(user)
    @user = user
    mg_client = Mailgun::Client.new API_KEY
    message_params = { from: ADMIN_EMAIL,
                       to:   user.email,
                       subject: 'Reset password instructions',
                       text: "To reset your password, click the URL below: https://shop-ror.herokuapp.com/password_resets/#{@user.password_reset_token}/edit"
    }
    mg_client.send_message MAILGUN_DOMAIN, message_params
  end

  def order(order, user)
    @order = order
    html = render 'user_mailer/order', order: order
    mg_client = Mailgun::Client.new API_KEY
    message_params = { from: user == 'admin' ? order.user.email : ADMIN_EMAIL,
                       to:   user == 'admin' ? ADMIN_EMAIL : user.email,
                       subject: "Order#{order.id}",
                       html: html
    }
    mg_client.send_message MAILGUN_DOMAIN, message_params
  end
end
