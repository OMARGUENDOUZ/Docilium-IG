CodeSystem: MedicationTypeCS
Id: medication-type-cs
Title: "Medication Type Code System"
Description: "IMP vs NIMP classification"
* ^url = "http://docilium.health/fhir/ctpm/CodeSystem/medication-type"
* ^status = #active
* ^content = #complete
* #IMP "Investigational Medicinal Product"
* #NIMP "Non-Investigational Medicinal Product"

ValueSet: MedicationTypeVS
Id: medication-type-vs
Title: "Medication Type Value Set"
* ^url = "http://docilium.health/fhir/ctpm/ValueSet/medication-type"
* ^status = #active
* include codes from system MedicationTypeCS