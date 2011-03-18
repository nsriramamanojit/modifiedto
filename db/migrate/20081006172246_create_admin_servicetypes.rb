class CreateAdminServicetypes < ActiveRecord::Migration
  def self.up
    create_table :servicetypes ,:id => false do |t|
      t.primary_key :servicetype_id
      t.string :service_type,:limit =>45,:null =>false
      t.string :servicetype_description,:limit =>500
      t.column :servicetype_enabled,'tinyint(1)',:null =>false, :default=>0
      t.string :comments,:limit =>500

      t.timestamps
    end
  end

  def self.down
    drop_table :servicetypes
  end
end
