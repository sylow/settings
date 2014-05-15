class CreateGlobalConfigurations < ActiveRecord::Migration
  def change
    create_table :global_configurations do |t|
      t.string :key
      t.text :value
      t.string :kind

      t.timestamps
    end
  end
end
