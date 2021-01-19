# frozen_string_literal: true

class AdminsSeeds
  def initialize; end

  def perform
    admin = Administrator.new({
                                nickname: 'test_admin'
                              })
    account = Account.new({
                            account_type: 'administrator',
                            email: 'test_admin@gmail.com',
                            password: '11111111'
                          })

    begin
      account.save!
      admin.account = account
      admin.save!
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
