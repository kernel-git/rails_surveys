class CreateModelsTables < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.float :answer_val
      t.belongs_to :question
      t.belongs_to :user

      t.timestamps
    end

    create_table :questions do |t|
      t.string :question_type
      t.integer :benchmark_val
      t.integer :benchmark_vol
      t.belongs_to :question_group
    end

    create_table :question_groups do |t|
      t.string :label
      t.belongs_to :survey
    end

    create_table :surveys do |t|
      t.string :label

      t.timestamps
    end

    create_table :employers do |t|
      t.string :label
      t.string :email
      t.string :phone
      t.text :address
      t.string :logo_url
    end

    create_table :employers_surveys do |t|
      t.belongs_to :employer
      t.belongs_to :survey
    end

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :account_type
      t.integer :age
      t.integer :position_age
      t.boolean :opt_out
      t.belongs_to :employer
    end

    create_table :segments do |t|
      t.string :label
    end

    create_table :employers_segments do |t|
      t.belongs_to :employers
      t.belongs_to :segments
    end

    create_table :segments_users do |t|
      t.belongs_to :segments
      t.belongs_to :users
    end
  end
end
