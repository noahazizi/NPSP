*** Settings ***
Resource        robot/Cumulus/resources/NPSP.robot
Library         cumulusci.robotframework.PageObjects
...             robot/Cumulus/resources/RecurringDonationsPageObject.py
...             robot/Cumulus/resources/NPSP.py
Suite Setup     Run keywords
...             Open Test Browser
...             Setup Test Data
...             Enable RD2
Suite Teardown  Delete Records and Close Browser


***Keywords***
# Setup a contact with parameters specified
Setup Test Data
    Setupdata           contact               contact_data=${contact_fields}

*** Variables ***
&{contact_fields}  Email=testuser@example.com

${frequency}  1
${day_of_month}  2
${amount}  100
${method}  Credit Card


*** Test Cases ***

1.Create Open Recurring Donation With Monthly Installment Associated For A Contact
    [Documentation]              This test verifies that an enhanced recurring donation of type open can be created
    ...                          Through the UI by choosing a contact from the dropdown uing the create rd2 modal.
    ...                          Verifies that all the new fields and sections are getting populated and displayed on UI.


    [tags]                                 unstable               W-042701                     feature:RD2

    Go To Page                             Listing                                            npe03__Recurring_Donation__c
    Click Object Button                    New
    Wait For Modal                         New                                                Recurring Donation

    # Reload page is a temporary fix till the developers fix the ui-modal
    Reload Page
    Wait For Modal                         New                                                Recurring Donation

    # Create Enhanced recurring donation of type Open
    Populate Rd2 Modal Form
    ...                                    Contact=${data}[contact][LastName] Household
    ...                                    Amount= ${amount}
    ...                                    Payment Method=Credit Card
    ...                                    Day of Month=${day_of_month}
    Click Rd2 Modal Button                 Save
    Wait Until Modal Is Closed
    Current Page Should Be                 Details                                          npe03__Recurring_Donation__c

    ${rd_id}                               Save Current Record ID For Deletion              npe03__Recurring_Donation__c
    Validate Field Values Under Section

    ...                                    Contact=${data}[contact][FirstName] ${data}[contact][LastName]
    ...                                    Amount=$100.00
    ...                                    Status=Active