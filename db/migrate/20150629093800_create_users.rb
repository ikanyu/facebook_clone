class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
      t.string :email
      t.string :password

      t.timestamps null: false
    end

    create_table :statuses do |t|
      t.string :status
      t.integer :user_id

      t.timestamps null: false
    end

    create_table :comments do |t|
      t.string :comment
      t.integer :status_id
      t.integer :user_id

      t.timestamps null: false
    end

    create_table :likes do |t|
      t.string :status_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end

