module ControllerMacros
  def login_as(account_type)
    # Before each test, create and login the account
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:account]
      account = FactoryBot.create(:account, account_type: account_type)
      # account.confirm! # Or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in account
      @account_user = FactoryBot.create(account_type.to_sym, account_id: account.id)
    end
  end
end
