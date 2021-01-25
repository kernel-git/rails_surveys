# frozen_string_literal: true

class AdminsSeeds
  include LoggerExtension

  def initialize; end

  def perform
    @admin = Administrator.new({
                                 nickname: 'test_admin'
                               })
    @admin.build_account(
      account_user_type: 'Administrator',
      email: 'test_admin@gmail.com',
      password: '11111111',
      password_confirmation: '11111111'
    )
    log_errors(@admin) unless @admin.save
  end
end
