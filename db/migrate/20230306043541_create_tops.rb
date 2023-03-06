class CreateTops < ActiveRecord::Migration[6.0]
  def change
    create_table :tops do |t|
      t.integer :temperature_minimum
      t.integer :temperature_maximum
      t.string :image
      t.integer :user_id
      t.integer :outfits_count

      t.timestamps
    end
  end
end
