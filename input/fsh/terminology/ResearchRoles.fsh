CodeSystem: CustomResearchRolesCS
Id: custom-research-roles
Title: "Custom Research Study Roles"
* ^url = "http://docilium.health/fhir/ctpm/CodeSystem/custom-research-roles"
* ^status = #draft
* ^content = #complete
* #study-coordinator "Study Coordinator"
* #cra-sponsor "CRA Promoteur"
* #project-manager "Project Manager"
* #insurance "Insurance"

ValueSet: ExtendedResearchStudyPartyRoleVS
Id: extended-research-study-party-role
Title: "Extended Research Study Party Role"
* include codes from valueset http://hl7.org/fhir/ValueSet/research-study-party-role
* include codes from system CustomResearchRolesCS
