class CreateAdminExamtypes < ActiveRecord::Migration
  def self.up
    create_table :examtypes do |t|
      t.string :examtype ,:limit=>20,:null => false
      t.string :examtype_description ,:limit=>500
      t.string :comments ,:limit=>500

      t.timestamps
    end
  end

  def self.down
    drop_table :examtypes
  end
end
