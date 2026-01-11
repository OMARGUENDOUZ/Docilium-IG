CodeSystem: ReturnPolicyCS
Id: return-policy
Title: "Return Policy Codes"
* ^url = "http://docilium.health/fhir/ctpm/CodeSystem/return-policy"
* ^status = #draft
* ^content = #complete
* #local-stock "Local stock"
* #sponsor-return "Sponsor return"

ValueSet: ReturnPolicyVS
Id: return-policy
Title: "Return Policy ValueSet"
* ^url = "http://docilium.health/fhir/ctpm/ValueSet/return-policy"
* ^status = #draft
* include codes from system ReturnPolicyCS