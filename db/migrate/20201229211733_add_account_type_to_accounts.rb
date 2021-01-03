class AddAccountTypeToAccounts < ActiveRecord::Migration[6.0]
  def change
    change_table :accounts do |t|
      t.string :account_type, null: false, default: 'employee'
    end
  end
end
