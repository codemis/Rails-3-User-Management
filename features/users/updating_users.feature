Feature: Updating users
  In order to see the users of the current system
  As a Admin
  I want to be able to view all users in a list
  
  Background:
    Given these users exist:
      | first_name  | last_name | login             | email             | last_login_at       | role          |
      | Bob         | Jones     | mrjones@gmail.com | mrjones@gmail.com | 2011-05-11 08:05:32 | administrator |
      | Jerry       | Smith     | jjone@yahoo.com   | jones@yahoo.com   | 2011-05-11 08:05:32 | member        |
      | Greg        | Gary      | gghairy@aol.com   | gghairy@aol.com   | 2011-05-11 08:05:32 | administrator |

  Scenario: Cancel on updating a current user
    Given I am logged in as an "Administrator"
    And I am on the users page
    When I click "edit" for user: "Bob Jones"
    Then I should be on the user: "Bob Jones" edit page
    And I should see "cancel"
    When I follow "cancel"
    Then I should be on the users page
    
  Scenario: Cancel link should be missing if I am a member
    Given I am logged in as an "Member"
    And I follow "my account"
    Then I should not see "cancel"
      
  Scenario: updating a current user
    Given I am logged in as an "Administrator"
    And I am on the users page
    When I click "edit" for user: "Bob Jones"
    Then I should be on the user: "Bob Jones" edit page
    And I should not see a "login" field
    When I fill in the following:
      | first name  | Bobby   |
      | last name   | Joneses |
    And I press "update"
    Then I should be on the users page
    And I should see "Bobby Joneses"
    And I should see "Bobby Joneses account was successfully updated."

  Scenario: updating a current user should throw an error if missing first name
    Given I am logged in as an "Administrator"
    And I am on the users page
    When I click "edit" for user: "Bob Jones"
    Then I should be on the user: "Bob Jones" edit page
    And I should not see a "login" field
    When I fill in the following:
      | first name  |         |
      | last name   | Joneses |
    And I press "update"
    Then I should see "can't be blank" for the "first name" field

  Scenario: updating a current user should throw an error if missing last name
    Given I am logged in as an "Administrator"
    And I am on the users page
    When I click "edit" for user: "Bob Jones"
    Then I should be on the user: "Bob Jones" edit page
    And I should not see a "login" field
    When I fill in the following:
      | first name  | Bobby   |
      | last name   |         |
    And I press "update"
    Then I should see "can't be blank" for the "last name" field
    
  Scenario: updating a current user should throw an error if missing email
    Given I am logged in as an "Administrator"
    And I am on the users page
    When I click "edit" for user: "Bob Jones"
    Then I should be on the user: "Bob Jones" edit page
    And I should not see a "login" field
    When I fill in the following:
      | first name  | Bobby   |
      | email       |         |
    And I press "update"
    Then I should see "can't be blank" for the "email" field

  Scenario: updating a current user should throw an error if missing confirm password
    Given I am logged in as an "Administrator"
    And I am on the users page
    When I click "edit" for user: "Bob Jones"
    Then I should be on the user: "Bob Jones" edit page
    And I should not see a "login" field
    When I fill in the following:
      | password          | Bobby   |
      | confirm password  |         |
    And I press "update"
    Then I should see "is too short (minimum is 4 characters)" for the "confirm password" field
    
  Scenario: should be able to delete a current user
    Given I am logged in as an "Administrator"
    And I am on the users page
    When I click "delete" for user: "Bob Jones"
    Then I should be on the users page
    And I should see "Bob Jones account was successfully removed."
    And I should not see "mrjones@gmail.com"
    
  Scenario: member should not be allowed to edit role
    Given I am logged in as a "Member"
    And I follow "my account"
    Then I should not see the "role" field
    
  Scenario: administrator should be allowed to edit role
    Given I am logged in as a "Administrator"
    And I follow "my account"
    Then I should see "role"