CodeSystem: DestructionPolicyCS
Id: destruction-policy
Title: "Destruction Policy Codes"
* ^url = "http://docilium.health/fhir/ctpm/CodeSystem/destruction-policy"
* ^status = #draft
* ^content = #complete
* #local "Local destruction"
* #sponsor "Sponsor destruction"
* #mixed "Mixed"

ValueSet: DestructionPolicyVS
Id: destruction-policy
Title: "Destruction Policy ValueSet"
* ^url = "http://docilium.health/fhir/ctpm/ValueSet/destruction-policy"
* ^status = #draft
* include codes from system DestructionPolicyCS