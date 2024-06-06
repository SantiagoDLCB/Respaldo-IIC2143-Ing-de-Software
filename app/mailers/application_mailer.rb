# frozen_string_literal: true

# Clase abstracta de la que heredan todos los mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
