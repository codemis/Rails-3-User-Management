Feature: Forgot password
  In order to give user the ability to reset their password
  As a member of the application
  I want to be able to change my password
  
  Background:
    Given these users exist:
      | first_name  | last_name | login             | email             | last_login_at       | role          |
      | Bob         | Jones     | mrjones@gmail.com | mrjones@gmail.com | 2011-05-11 08:05:32 | administrator |
      | Jerry       | Smith     | jjone@yahoo.com   | jones@yahoo.com   | 2011-05-11 08:05:32 | member        |
      | Greg        | Gary      | gghairy@aol.com   | gghairy@aol.com   | 2011-05-11 08:05:32 | administrator |
  
  Scenario: Should see a forgot password link
  Given I am on the login page
  Then I should see "forgot my password"
  
  Scenario: Should be able to request password reset
    Given I am on the login page
    And I follow "forgot my password"
    When I fill in the following:
      | email | mrjones@gmail.com |
    And I press "request reset"
    Then I should be on the login page
    And I should see "Your password has been reset."
    And 1 email should be delivered to mrjones@gmail.com
  
  Scenario: Should require an email
    Given I am on the login page
    And I follow "forgot my password"
    When I fill in the following:
      | email | |
    And I press "request reset"
    Then I should be on the forgot password page
    And I should see "Your email cannot be blank"
  
  Scenario: Should fail if not a user
    Given I am on the login page
    And I follow "forgot my password"
    When I fill in the following:
      | email | faker_email@faked.com |
    And I press "request reset"
    Then I should be on the forgot password page
    And I should see "No account was found"
  
  Scenario: Should be able to reset password
    Given I have successfully requested to reset my password
    When I follow the reset link
    And I reset my password
    Then I should be on the dashboard page
    And I should see "Your password has been reset"
    