Feature: Creating users
  In order to create new user in the system
  As a Admin
  I want to be able to add a user
  
  Background:
    Given I am logged in as an "Administrator"

  Scenario: Cancel on adding a new user
    Given I am on the users page
    And I follow "add a user"
    Then I should be on the new user page
    And I should see "cancel"
    When I follow "cancel"
    Then I should be on the users page
    
  Scenario: Adding a new user
    Given I am on the users page
    And I follow "add a user"
    Then I should be on the new user page
    And I should not see a "login" field
    When I fill in the following:
      | first name        | Johnathan             |
      | last name         | Pulos                 |
      | email             | johnathan@jpulos.com  |
      | password          | testpassword          |
      | confirm password  | testpassword          |
    And I press "save"
    Then I should be on the users page
    And I should see "Johnathan Pulos was successfully added."

  Scenario: Adding a new user should throw error when missing email
    Given I am on the users page
    And I follow "add a user"
    Then I should be on the new user page
    And I should not see a "login" field
    When I fill in the following:
      | first name        | Johnathan             |
      | last name         | Pulos                 |
      | password          | testpassword          |
      | confirm password  | testpassword          |
    And I press "save"
    Then I should see "should look like an email address. and can't be blank" for the "email" field

  Scenario: Adding a new user should throw an error when missing a password
    Given I am on the users page
    And I follow "add a user"
    Then I should be on the new user page
    And I should not see a "login" field
    When I fill in the following:
      | first name        | Johnathan             |
      | last name         | Pulos                 |
      | email             | johnathan@jpulos.com  |
      | confirm password  | testpassword          |
    And I press "save"
    Then I should see "is too short (minimum is 4 characters) and doesn't match confirmation" for the "password" field

  Scenario: Adding a new user should throw an error when missing a confirmation password
    Given I am on the users page
    And I follow "add a user"
    Then I should be on the new user page
    And I should not see a "login" field
    When I fill in the following:
      | first name        | Johnathan             |
      | last name         | Pulos                 |
      | email             | johnathan@jpulos.com  |
      | password          | testpassword          |
    And I press "save"
    Then I should see "is too short (minimum is 4 characters)" 
    Then I should see "is too short (minimum is 4 characters)" for the "confirm password" field  