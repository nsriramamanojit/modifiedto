class Administrator < ActiveRecord::Base
  validates_presence_of     :name,:login,:password
  validates_length_of       :login,:password,  :within => 5..25
  validates_uniqueness_of   :login
  def self.authenticate_admin(uname,password)
    find(:first,:conditions=>['login = ? and password = ?',uname,password])
  end
end
