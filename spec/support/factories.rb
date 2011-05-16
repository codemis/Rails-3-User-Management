# Sequences
#
Factory.sequence :email do |n|
  "#{n}-email@company.com"
end

Factory.sequence :login do |n|
  "#{n}username"
end

# models
#
Factory.define :user do |a|
  a.first_name Faker::Name.first_name
  a.last_name Faker::Name.last_name
  a.sequence(:login) {Factory.next :login} 
  a.sequence(:email) {Factory.next :email}
  a.password "astrongpassword"
  a.password_confirmation "astrongpassword"
  a.last_login_at Time.now
end