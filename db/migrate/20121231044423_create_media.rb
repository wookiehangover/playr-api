class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.references :playlist
      t.string :url
      t.integer :order
      t.string :flavor
      t.boolean :active
      t.float :start_time
      t.float :end_time

      t.timestamps
    end
  end
end


