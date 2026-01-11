Profile: ClinicalStudy
Parent: ResearchStudy
Id: clinical-study
Title: "Clinical Study Profile"
Description: "A profile for clinical studies."
* identifier 1..3 MS
* version 1..1
* title 1..1 MS
* date 1..1
* phase 1..1 MS
* studyDesign 1..* 
* focus 1..1 MS
* focus only CodeableReference(MedicinalProductDefinition)
* associatedParty 1..* MS
* associatedParty ^slicing.discriminator.type = #value
* associatedParty ^slicing.discriminator.path = "role"
* associatedParty ^slicing.rules = #open
* associatedParty ^slicing.description = "Roles of parties associated with the study"
* associatedParty ^slicing.ordered = false
* associatedParty contains Sponsor 1..1 and PrincipalInvestigator 1..1 and StudyCoordinator 1..1
and CRAPromoter 1..1 and ProjectManager 0..1 and Insurance 1..*
// Principal investigator
* associatedParty[PrincipalInvestigator].role = #primary-investigator
* associatedParty[PrincipalInvestigator].name 1..1 MS
* associatedParty[PrincipalInvestigator].party 1..1 MS
* associatedParty[PrincipalInvestigator].party only Reference(PractitionerForClinicalTrials)
// Study coordinator
* associatedParty[StudyCoordinator].role = #study-coordinator
* associatedParty[StudyCoordinator].name 1..1 MS
* associatedParty[StudyCoordinator].party 1..1 MS
* associatedParty[StudyCoordinator].party only Reference(PractitionerForClinicalTrials)
// CRA promoter
* associatedParty[CRAPromoter].role = #cra-sponsor
* associatedParty[CRAPromoter].name 1..1 MS
* associatedParty[CRAPromoter].party 1..1 MS
* associatedParty[CRAPromoter].party only Reference(PractitionerForClinicalTrials)
// Sponsor
* associatedParty[Sponsor].role = #sponsor
* associatedParty[Sponsor].name 1..1 MS
* associatedParty[Sponsor].party 1..1 MS
* associatedParty[Sponsor].party only Reference(Organization)
// Project manager
* associatedParty[ProjectManager].role = #project-manager
* associatedParty[ProjectManager].name 1..1 MS
* associatedParty[ProjectManager].party 1..1 MS
* associatedParty[ProjectManager].party only Reference(Practitioner)
// Insurance
* associatedParty[Insurance].role = #insurance
* associatedParty[Insurance].party only Reference(Organization)
* associatedParty[Insurance].period 1..1 MS

* progressStatus 1..1 MS
* progressStatus.state = #approved
* progressStatus.period 1..1 MS
* recruitment 1..1 MS
* recruitment.targetNumber 1..1 MS
* recruitment.actualNumber 1..1 MS 
* classifier 1..* MS
* classifier from TherapeuticAreasValueSet