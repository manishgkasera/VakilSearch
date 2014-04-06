class CreateLawyers < ActiveRecord::Migration
  def self.up
    create_table :lawyers do |t|
      t.string :code
      t.string :name
      t.integer :experiance
      t.integer :location_id
      t.decimal :average_rating, scale: 1, precision: 2, default: 0.0
      t.timestamps
    end
  end

  def self.down
    drop_table :lawyers
  end
end
