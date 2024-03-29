# frozen_string_literal: true

class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ['izgachev01@gmail.com']
  end
end

ActionMailer::Base.register_interceptor(SandboxEmailInterceptor) if Rails.env.staging?
