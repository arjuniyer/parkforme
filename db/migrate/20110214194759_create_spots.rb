class CreateSpots < ActiveRecord::Migration
  def self.up
    create_table :spots do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :spots
  end
end
