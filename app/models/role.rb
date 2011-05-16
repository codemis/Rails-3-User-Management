class Role < ActiveRecord::Base
  # association
  #
  belongs_to :user

  # validates
  #
  validates :title, :inclusion => {:in => User::ROLES.map{|r| r[1]}}
end