@accession_number @accession-service
Feature: object with an accession should be modifiable
  Background:
    Given I am an "administrator" user logged in as "me"

  Scenario: A released sample with already an accession number should add updated in the history
    Given a sample named "sample" exists for accession
    And the sample name "sample" has previously been released
    And the sample "sample" has the accession number "E-ERA-16"
    Given an accessioning webservice exists which returns a sample accession number "E-ERA-16"
    When I update an accession number for sample "sample"

    When I am on the event history page for sample "sample"
    Then I should see "accession data has been updated by user me"
