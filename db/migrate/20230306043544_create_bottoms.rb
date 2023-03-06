class CreateBottoms < ActiveRecord::Migration[6.0]
  def change
    create_table :bottoms do |t|
      t.integer :temperature_minimum
      t.integer :temperature_maximum
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
