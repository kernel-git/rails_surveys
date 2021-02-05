# frozen_string_literal: true

class RemoveManyToManyConnectionBetweenEmployersAndGroups < ActiveRecord::Migration[6.0]
  def self.up
    drop_table :employers_groups
  end

  def self.down
    create_table :employers_groups, id: false do |t|
      t.belongs_to :employers
      t.belongs_to :groups
    end
  end
end
