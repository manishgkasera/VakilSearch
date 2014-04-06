class CreateLawyersServices < ActiveRecord::Migration
  def change
    create_table :lawyers_services do |t|
      t.integer :lawyer_id
      t.integer :service_id
    end
  end
end
