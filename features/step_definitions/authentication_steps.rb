Given /^these users exists:$/ do |table|
  table.hashes.each do |row|
    role_title = row.delete("role")
    row.merge!(:role_attributes => {:title => role_title.downcase}, :password_confirmation => row['password'])
    user = Factory.create(:user, row)
    find_model!("user: \"#{user.role.title.capitalize}\"", {:id => user.id})
  end
end

Given /^I am logged in as a(?:n)* "([^"]*)"$/ do |role_title|
  user = Factory.create(:user, {
    :email => "n-#{User.count}-email@company.com",
    :password => "astrongpassword",
    :password_confirmation => "astrongpassword",
    :role_attributes => {
      :title => role_title.downcase
    }
  })

  find_model!("user: \"I\"", {:id => user.id})
  find_model!("user: \"Me\"", {:id => user.id})

  visit "/login"
  fill_in "email", :with => user.login
  fill_in "password", :with => user.password
  click_button "login"
end

Given /^I already logged in$/ do
  Given %{I am logged in as an "Administrator"}
end

Given /^I am logged out$/ do
  visit "/logout"
end
