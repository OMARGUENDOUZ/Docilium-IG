CodeSystem: BlindingModeCS
Id: blinding-mode
Title: "Blinding Mode Codes"
* ^url = "http://docilium.health/fhir/ctpm/CodeSystem/blinding-mode"
* ^status = #draft
* ^content = #complete
* #none "None"
* #single "Single"
* #double "Double"
* #triple "Triple"

ValueSet: BlindingModeVS
Id: blinding-mode
Title: "Blinding Mode ValueSet"
* ^url = "http://docilium.health/fhir/ctpm/ValueSet/blinding-mode"
* ^status = #draft
* include codes from system BlindingModeCS