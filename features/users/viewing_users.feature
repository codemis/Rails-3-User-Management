Feature: Viewing users
  In order to see the users of the current system
  As a Admin
  I want to be able to view all users in a list
  
  Background:
    Given I am logged in as an "Administrator"
    Given these users exist:
      | first_name  | last_name | login             | email             | last_login_at       | role          |
      | Bob         | Jones     | mrjones@gmail.com | mrjones@gmail.com | 2011-05-11 08:05:32 | administrator |
      | Jerry       | Jones     | jjones@yahoo.com  | jjones@yahoo.com  | 2011-05-11 08:05:32 | administrator |
      | Greg        | Gary      | gghairy@aol.com   | gghairy@aol.com   | 2011-05-11 08:05:32 | member        |
      
  Scenario: viewing all users
    Given I am on the users page
    #Then show me the page
    Then I should see these users:
      | Bob Jones   | mrjones@gmail.com | mrjones@gmail.com |
      | Jerry Jones | jjones@yahoo.com  | jjones@yahoo.com  |
      | Greg Gary   | gghairy@aol.com   | gghairy@aol.com   |