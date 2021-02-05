# frozen_string_literal: true

class ChangeOneEmployerToManyModerators < ActiveRecord::Migration[6.0]
  def change
    create_table :moderators do |t|
      t.string :nickname
      t.belongs_to :employer

      t.timestamps
    end
  end
end
