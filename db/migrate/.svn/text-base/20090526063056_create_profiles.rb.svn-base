class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :student_id
      t.string :email
      t.string :name,:null=>false
      t.string :mobile,:null=>false
      t.string :landline
      t.string :alt_email
      t.string :country,:default=>'India'
      t.string :state
      t.string :city
      t.string :address
      t.timestamps
    end
  end
  
  def self.down
    drop_table :profiles
  end
end
