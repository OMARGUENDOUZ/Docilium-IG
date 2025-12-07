# Clinical Study Profile - Clinical Trial Pharmacy Management v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Clinical Study Profile**

## Resource Profile: Clinical Study Profile 

| | |
| :--- | :--- |
| *Official URL*:http://docelium.health/StructureDefinition/clinical-study | *Version*:0.1.0 |
| Draft as of 2025-12-07 | *Computable Name*:ClinicalStudy |

 
A profile for clinical studies. 

**Utilisations:**

* Ce Profil nest utilisé par aucun profil dans ce guide dimplémentation

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/docelium|current/StructureDefinition/clinical-study)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-clinical-study.csv), [Excel](StructureDefinition-clinical-study.xlsx), [Schematron](StructureDefinition-clinical-study.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "clinical-study",
  "url" : "http://docelium.health/StructureDefinition/clinical-study",
  "version" : "0.1.0",
  "name" : "ClinicalStudy",
  "title" : "Clinical Study Profile",
  "status" : "draft",
  "date" : "2025-12-07T21:41:42+01:00",
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
  "description" : "A profile for clinical studies.",
  "fhirVersion" : "5.0.0",
  "mapping" : [
    {
      "identity" : "w5",
      "uri" : "http://hl7.org/fhir/fivews",
      "name" : "FiveWs Pattern Mapping"
    },
    {
      "identity" : "BRIDG5.1",
      "uri" : "https://bridgmodel.nci.nih.gov",
      "name" : "BRIDG 5.1 Mapping"
    },
    {
      "identity" : "v2",
      "uri" : "http://hl7.org/v2",
      "name" : "HL7 V2 Mapping"
    },
    {
      "identity" : "rim",
      "uri" : "http://hl7.org/v3",
      "name" : "RIM Mapping"
    },
    {
      "identity" : "clinicaltrials-gov",
      "uri" : "http://clinicaltrials.gov",
      "name" : "ClinicalTrials.gov Mapping"
    }
  ],
  "kind" : "resource",
  "abstract" : false,
  "type" : "ResearchStudy",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/ResearchStudy",
  "derivation" : "constraint",
  "differential" : {
    "element" : [
      {
        "id" : "ResearchStudy",
        "path" : "ResearchStudy"
      },
      {
        "id" : "ResearchStudy.identifier",
        "path" : "ResearchStudy.identifier",
        "min" : 1,
        "max" : "3",
        "mustSupport" : true
      },
      {
        "id" : "ResearchStudy.title",
        "path" : "ResearchStudy.title",
        "min" : 1,
        "mustSupport" : true
      },
      {
        "id" : "ResearchStudy.phase",
        "path" : "ResearchStudy.phase",
        "min" : 1,
        "mustSupport" : true
      },
      {
        "id" : "ResearchStudy.classifier",
        "path" : "ResearchStudy.classifier",
        "min" : 1,
        "mustSupport" : true,
        "binding" : {
          "strength" : "required",
          "valueSet" : "http://docelium.health/fhir/ctpm/ValueSet/therapeutic-areas"
        }
      },
      {
        "id" : "ResearchStudy.associatedParty",
        "path" : "ResearchStudy.associatedParty",
        "min" : 1,
        "mustSupport" : true
      },
      {
        "id" : "ResearchStudy.recruitment",
        "path" : "ResearchStudy.recruitment",
        "min" : 1,
        "mustSupport" : true
      },
      {
        "id" : "ResearchStudy.recruitment.targetNumber",
        "path" : "ResearchStudy.recruitment.targetNumber",
        "min" : 1,
        "mustSupport" : true
      },
      {
        "id" : "ResearchStudy.recruitment.actualNumber",
        "path" : "ResearchStudy.recruitment.actualNumber",
        "min" : 1,
        "mustSupport" : true
      }
    ]
  }
}

```
