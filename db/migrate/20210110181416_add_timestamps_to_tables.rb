# frozen_string_literal: true

class AddTimestampsToTables < ActiveRecord::Migration[6.0]
  def change
    change_table :employees, &:timestamps
    change_table :employers, &:timestamps
    change_table :question_groups, &:timestamps
    change_table :questions, &:timestamps
    change_table :segments, &:timestamps
  end
end
