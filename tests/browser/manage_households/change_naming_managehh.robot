*** Settings ***

Resource        tests/NPSP.robot
Suite Setup     Open Test Browser
Suite Teardown  Delete Records and Close Browser

*** Test Cases ***

Change Naming on Manage Household Page
    #1 contact HouseHold Validation
    ${contact_id1} =  Create Contact with Email
    &{contact1} =  Salesforce Get  Contact  ${contact_id1}
    Click Link                link= &{contact1}[LastName] Household
    
    #2 Create a new contact under HouseHold Validation
    ${contact_id2} =  New Contact for HouseHold
    &{contact2} =  Salesforce Get  Contact  ${contact_id2}
    Header Field Value    Account Name    &{contact1}[LastName] and &{contact2}[LastName] Household
    Click Link    link=&{contact1}[LastName] and &{contact2}[LastName] Household    
    Click Link    link=Show more actions
    Click Link    link=Manage Household    
    Sleep     3        
    Select Frame With Title   Manage Household
    ${loc}    Validate Checkbox    &{contact1}[FirstName] &{contact1}[LastName]    Informal Greeting
    Double Click Element    ${loc}
    ${loc}    Validate Checkbox    &{contact2}[FirstName] &{contact2}[LastName]    Formal Greeting
    Double Click Element    ${loc}
    Sleep    2
    Click Managehh Button       Save
    Sleep    3
    Go To Object Home          Account
    Click Link    link=&{contact1}[LastName] and &{contact2}[LastName] Household
    Sleep    3
    Select Tab    Details
    Check Field Value    Informal Greeting    &{contact2}[FirstName]
    Check Field Value    Formal Greeting    &{contact1}[FirstName] &{contact1}[LastName]