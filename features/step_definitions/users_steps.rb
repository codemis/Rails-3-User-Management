Given /^these users exist:$/ do |table|
  table.hashes.each do |row|
    role_title = row.delete('role')
    row.merge!(:role_attributes => {:title => role_title})
    user = Factory.create(:user, row)
    find_model!("user: \"#{user.full_name}\"", {:id => user.id})
  end
end

Then /^I should see these users:$/ do |table|
  table.raw.each do |row|
    user = model!("user: \"#{row[0]}\"")
    Then %{I should see "#{row[0]}" within "table.users>tbody #user_#{user.id}"}
    Then %{I should see "#{row[1]}" within "table.users>tbody #user_#{user.id}"}
    Then %{I should see "#{row[2]}" within "table.users>tbody #user_#{user.id}"}
  end
end

When /^I click "([^"]*)" for user: "([^"]*)"$/ do |text, name|
  user = model!("user: \"#{name}\"")
  When %{I follow "#{text}" within "table.users>tbody>tr#user_#{user.id}>td.actions"}
end

Given /^I delete #{capture_model}$/ do |name|
  m = model!(name)
  m.destroy.should be_true
end