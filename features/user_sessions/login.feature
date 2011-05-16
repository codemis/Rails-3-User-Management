Feature: Logging in
  In order to make sure users can login and out
  As a Admin or Member
  I want to be able to login and out of the system
  
  Background:
    Given these users exist:
      | first_name  | last_name | login             | email             | last_login_at       | role          | password  | password_confirmation  |
      | Bob         | Jones     | mrjones@gmail.com | mrjones@gmail.com | 2011-05-11 08:05:32 | administrator | testone   | testone                |
      | Greg        | Gary      | gghairy@aol.com   | gghairy@aol.com   | 2011-05-11 08:05:32 | member        | testtwo   | testtwo                |

  Scenario: Logging into the system
    Given I am on the login page
    When I fill in "email" with "mrjones@gmail.com"
    And I fill in "password" with "testone"
    And I press "login"
    Then I should be on the dashboard page
    And I should see "logout"
    And I should see "Welcome Bob Jones"
    And I should see "my account"
    
  Scenario: Logging out of the system
    Given I am logged in as an "Administrator"
    When I follow "logout"
    Then I should be on the home page

  Scenario Outline: failed attempts to login in, validation errors
    Given I am on the login page
    When I fill in the following:
      | email    | <email>    |
      | password | <password> |
    And I press "login"
    Then I should see "<message>" within "<selector>"

    Examples:
      | email           | password        | message         | selector             |
      | cobra@yahoo.com |                 | cannot be blank | form .inline-errors  |
      |                 | astrongpassword | cannot be blank | form .inline-errors  |   