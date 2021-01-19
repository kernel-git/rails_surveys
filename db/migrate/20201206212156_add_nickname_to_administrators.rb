# frozen_string_literal: true

class AddNicknameToAdministrators < ActiveRecord::Migration[6.0]
  def change
    add_column :administrators, :nickname, :string
  end
end
