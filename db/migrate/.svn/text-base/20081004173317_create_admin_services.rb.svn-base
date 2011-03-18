class CreateAdminServices < ActiveRecord::Migration
  def self.up
    create_table :services, :id => false do |t|
      t.primary_key :service_id
      t.integer :exam_id
      t.string :service_name,:limit =>45,:null =>false
      t.column :servicetype_id ,'tinyint(4)',:null=>false
      t.string :service_mode,:null =>false,:limit =>10
      t.string :service_description,:limit => 1000
      t.column :payment_required,'tinyint(1) unsigned',:null =>false, :default=>0
      t.string :servicechargeamount,:null =>false,:limit=>10
      t.column :service_status,'char(1)'
      t.column :service_enabled,'tinyint(1) unsigned'
      t.date :service_register_begindate 
      t.date :service_register_lastdate
      t.string :comments,:limit=>500
        t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
