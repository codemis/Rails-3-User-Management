# custom matchers to basic web steps provided by capybara
# terse is more implicit here
When /^I leave(?: the)* "([^"]*)"(?: field)* blank$/ do |arg1|
  When %{I fill in "#{arg1}" with ""}
end

When /^I select the following:$/ do |table|
  table.raw.each do |row|
    When %{I select "#{row[1]}" from "#{row[0]}"}
  end
end

When /^I fill in "([^"]*)" with$/ do |field, string|
  When %{I fill in "#{field}" with "#{string}"}
end

When /^I leave the following fields blank:$/ do |table|
  table.raw.each do |row|
    When %{I leave the "#{row}" field blank}
  end
end

Then /^I should see "([^"]*)" for the "([^"]*)" field$/ do |text, field|
  with_scope("error #{field} p tag") do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^the "([^"]*)" radio(?: within "([^"]*)")? should be checked$/ do |label, selector|
  step = %{the "#{label}" checkbox}
  step+= %{ within "#{selector}"} if selector
  step+= " should be checked"
  Then step
end

Then /^I should not see the "([^"]*)" field$/ do |field|
  with_scope("form") do
    field = find_field(field)
    field.should be_nil
  end
end

Then /^I should not see a "([^"]*)" field$/ do |field|
  Then %{I should not see "#{field}" within "form label"}
end

Given /^this scenario needs a way to test it$/ do
  pending
end

Then /^the "([^"]*)" field should not contain user: "([^"]*)"$/ do |field, name|
  user = model!("user: \"#{name}\"")
  Then %{the "#{field}" field should not contain "#{user.full_name}"}
end
