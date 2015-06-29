class AddTags < ActiveRecord::Migration
  def change
    create_table :status_tags do |t|
      t.integer  :status_id
      t.integer  :tag_id

      t.timestamps null: false
    end

    create_table :tags do |t|
      t.string  :name

      t.timestamps null: false
    end
  end
end

