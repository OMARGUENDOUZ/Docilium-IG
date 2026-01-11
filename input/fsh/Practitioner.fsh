Profile: PractitionerForClinicalTrials
Parent: Practitioner
Id: practitioner-for-clinical-trials
Title: "Practitioner for Clinical Trials Profile"
Description: "A profile for practitioners involved in clinical trials."
* name 1..1 MS
* telecom ^slicing.discriminator.type = #value
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom ^slicing.ordered = false
* telecom contains PhoneNumber 1..1 and EmailAddress 1..1
* telecom[PhoneNumber].system = #phone
* telecom[PhoneNumber].value 1..1 MS
* telecom[EmailAddress].system = #email
* telecom[EmailAddress].value 1..1 MS
