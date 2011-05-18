Given /^I have successfully requested to reset my password$/ do
  Given %{all emails have been delivered}
  Given %{I am on the login page}
  When %{I follow "forgot my password"}
  Then %{I should be on the new forgot password page}
  When %{I fill in "email" with "mrjones@gmail.com"}
  And %{I press "reset"}
  Then %{I should be on the login page}
  And %{I should see "check your email account"}
end

Then /^I should have received an email with password reset instructions$/ do
  Then %{1 email should be delivered to admin@company.com}
  And %{the email should contain "To reset your password"}
  And %{the email should contain "/forgot/"}
end

Given /^I have not provided my email to reset my password$/ do
  Given %{all emails have been delivered}
  Given %{I am on the login page}
  When %{I follow "forgot my password"}
  Then %{I should be on the new forgot password page}
  When %{I fill in "email" with ""}
  And %{I press "reset"}
end

Then /^I should have failed to request a reset url$/ do
  Then %{I should see "email" within "form"}
  And %{I should see /prohibited/}
end

Given /^I have provided an email that does not exist to reset my password$/ do
  Given %{all emails have been delivered}
  Given %{I am on the login page}
  When %{I follow "forgot my password"}
  Then %{I should be on the new forgot password page}
  When %{I fill in "email" with "anemail@nonexistant.com"}
  And %{I press "reset"}
end


When /^I follow the reset link/ do
  Then %{1 email should be delivered}
  When %{I follow "/forgot/" in the email}
  # Then %{I should be on user: "administrator"'s new forgot password page}
  Then %{I should see "new password" within "form"}
  And %{I should see "confirm password" within "form"}
end

When /^I reset my password$/ do
  When %{I fill in "new password" with "astrongpassword"}
  And %{I fill in "confirm password" with "astrongpassword"}
  And %{I press "save new password"}
end

Then /^I should redirected to the dashboard page$/ do
  Then %{I should be on the dashboard page}
  And %{I should not see "not allowed to access"}
end

When /^my new password does not match the confirmation$/ do
  When %{I fill in "new password" with "astrongpassword"}
  And %{I fill in "confirm password" with "notthesamepassword"}
  And %{I press "save new password"}
end

Then /^I should have failed to reset my password$/ do
  Then %{I should see "new password" within "form"}
  And %{I should see /prohibited/}
end
