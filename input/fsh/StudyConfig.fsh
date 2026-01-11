Profile: StudyConfig
Parent: Parameters
Id: study-config 
Title: "Study Configuration Parameters"
Description: "Configuration parameters for clinical studies."
* parameter ^slicing.discriminator.type = #value
* parameter ^slicing.discriminator.path = "name"
* parameter ^slicing.rules = #open
* parameter ^slicing.description = "parameters for study configuration"
* parameter ^slicing.ordered = false
* parameter contains StudyReference 1..1 and Blinding 0..1 and ArmRandomization 0..1 and CohortRandomization 0..1
and DestructionPolicy 0..1 and returnPolicy 0..1 and PatientTemperatureTracking 0..1 and RequiredDoubleSignatures 0..1 
and RequireWeightRecency 0..1 and WeightRecencyRule 0..1 and WeightRecencyType 0..1 and SubstanceTemperatureGouvernance 0..1
and IwrsGovernance 1..1
// Study Reference
* parameter[StudyReference].name = "study-reference"
* parameter[StudyReference].valueReference 1..1 MS
// Blinding
* parameter[Blinding].name = "blinding"
* parameter[Blinding].valueCode 1..1 MS

