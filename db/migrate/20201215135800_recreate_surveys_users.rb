# frozen_string_literal: true

class RecreateSurveysUsers < ActiveRecord::Migration[6.0]
  def change
    drop_table :surveys_users
    create_table :surveys_users do |t|
      t.belongs_to :survey
      t.belongs_to :user
    end
  end
end
