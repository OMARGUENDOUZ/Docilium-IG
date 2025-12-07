# Clinical Trial Patient Profile - Clinical Trial Pharmacy Management v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Clinical Trial Patient Profile**

## Resource Profile: Clinical Trial Patient Profile 

| | |
| :--- | :--- |
| *Official URL*:http://docelium.health/StructureDefinition/clinical-trial-patient | *Version*:0.1.0 |
| Draft as of 2025-12-07 | *Computable Name*:ClinicalTrialPatient |

 
A profile for patients enrolled in clinical trials. 

**Utilisations:**

* Ce Profil nest utilisé par aucun profil dans ce guide dimplémentation

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/docelium|current/StructureDefinition/clinical-trial-patient)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-clinical-trial-patient.csv), [Excel](StructureDefinition-clinical-trial-patient.xlsx), [Schematron](StructureDefinition-clinical-trial-patient.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "clinical-trial-patient",
  "url" : "http://docelium.health/StructureDefinition/clinical-trial-patient",
  "version" : "0.1.0",
  "name" : "ClinicalTrialPatient",
  "title" : "Clinical Trial Patient Profile",
  "status" : "draft",
  "date" : "2025-12-07T21:23:47+01:00",
  "publisher" : "DOCELIUM",
  "contact" : [
    {
      "name" : "DOCELIUM",
      "telecom" : [
        {
          "system" : "url",
          "value" : "http://docelium.org"
        }
      ]
    }
  ],
  "description" : "A profile for patients enrolled in clinical trials.",
  "fhirVersion" : "5.0.0",
  "mapping" : [
    {
      "identity" : "w5",
      "uri" : "http://hl7.org/fhir/fivews",
      "name" : "FiveWs Pattern Mapping"
    },
    {
      "identity" : "rim",
      "uri" : "http://hl7.org/v3",
      "name" : "RIM Mapping"
    },
    {
      "identity" : "interface",
      "uri" : "http://hl7.org/fhir/interface",
      "name" : "Interface Pattern"
    },
    {
      "identity" : "cda",
      "uri" : "http://hl7.org/v3/cda",
      "name" : "CDA (R2)"
    },
    {
      "identity" : "v2",
      "uri" : "http://hl7.org/v2",
      "name" : "HL7 V2 Mapping"
    },
    {
      "identity" : "loinc",
      "uri" : "http://loinc.org",
      "name" : "LOINC code for the element"
    }
  ],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Patient",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Patient",
  "derivation" : "constraint",
  "differential" : {
    "element" : [
      {
        "id" : "Patient",
        "path" : "Patient"
      },
      {
        "id" : "Patient.identifier",
        "path" : "Patient.identifier",
        "min" : 1,
        "max" : "1",
        "mustSupport" : true
      }
    ]
  }
}

```
