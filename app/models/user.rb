class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true 
  has_many :tweets

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
end
