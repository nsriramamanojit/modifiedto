class CreateServicepayments < ActiveRecord::Migration
  def self.up
    create_table :servicepayments do |t|
      t.column :student_id ,'int(11) unsigned',:null => false
      t.string :email,:null=>false
      t.column :service_id ,'int(11) unsigned',:null => false
      t.string :payment_mode ,:null => false,:default=>'P'
      t.column :payment_sent ,'tinyint(1) unsigned'
      t.timestamps
    end
  end
  
  def self.down
    drop_table :servicepayments
  end
end
