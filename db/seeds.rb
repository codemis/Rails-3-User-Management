# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.create!({
  :first_name            => "Admin",
  :last_name             => "inistrator",
  :email                 => "email@company.com",
  :login                 => "email@company.com",
  :password              => "astrongpassword",
  :password_confirmation => "astrongpassword",
  :role_attributes       => {
    :title               => "administrator"
  }
})