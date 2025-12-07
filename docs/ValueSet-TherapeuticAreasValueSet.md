# Therapeutic Areas for Clinical Trials - Clinical Trial Pharmacy Management v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Therapeutic Areas for Clinical Trials**

## ValueSet: Therapeutic Areas for Clinical Trials 

| | |
| :--- | :--- |
| *Official URL*:http://docelium.health/fhir/ctpm/ValueSet/therapeutic-areas | *Version*:0.1.0 |
| Draft as of 2025-12-07 | *Computable Name*:TherapeuticAreasValueSet |

 
A value set of therapeutic areas relevant to clinical trials. 

 **References** 

* [Clinical Study Profile](StructureDefinition-clinical-study.md)

### Définition logique (CLD)

* Include ce(s) code(s) tel quil(s) est (sont) défini(s) dans `http://docelium.health/fhir/ctpm/CodeSystem/therapeutic-areas`version Non précisé (utilise la dernière version provenant du serveur de terminologie)

 

### Expansion

No Expansion for this valueset (not supported by Publication Tooling)

-------

 Explanation of the columns that may appear on this page: 

| | |
| :--- | :--- |
| Level | A few code lists that FHIR defines are hierarchical - each code is assigned a level. In this scheme, some codes are under other codes, and imply that the code they are under also applies |
| System | The source of the definition of the code (when the value set draws in codes defined elsewhere) |
| Code | The code (used as the code in the resource instance) |
| Display | The display (used in the*display*element of a[Coding](http://hl7.org/fhir/R5/datatypes.html#Coding)). If there is no display, implementers should not simply display the code, but map the concept into their application |
| Definition | An explanation of the meaning of the concept |
| Comments | Additional notes about how to use the code |



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "TherapeuticAreasValueSet",
  "url" : "http://docelium.health/fhir/ctpm/ValueSet/therapeutic-areas",
  "version" : "0.1.0",
  "name" : "TherapeuticAreasValueSet",
  "title" : "Therapeutic Areas for Clinical Trials",
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
  "description" : "A value set of therapeutic areas relevant to clinical trials.",
  "compose" : {
    "include" : [
      {
        "system" : "http://docelium.health/fhir/ctpm/CodeSystem/therapeutic-areas",
        "concept" : [
          {
            "code" : "oncology",
            "display" : "Oncologie"
          },
          {
            "code" : "cardiology",
            "display" : "Cardiologie"
          },
          {
            "code" : "neurology",
            "display" : "Neurologie"
          },
          {
            "code" : "infectious-disease",
            "display" : "Maladies infectieuses"
          },
          {
            "code" : "immunology",
            "display" : "Immunologie"
          },
          {
            "code" : "endocrinology",
            "display" : "Endocrinologie"
          },
          {
            "code" : "respiratory",
            "display" : "Maladies respiratoires"
          },
          {
            "code" : "gastroenterology",
            "display" : "Gastroentérologie"
          },
          {
            "code" : "hematology",
            "display" : "Hématologie"
          },
          {
            "code" : "rheumatology",
            "display" : "Rhumatologie"
          },
          {
            "code" : "dermatology",
            "display" : "Dermatologie"
          },
          {
            "code" : "psychiatry",
            "display" : "Psychiatrie"
          },
          {
            "code" : "rare-diseases",
            "display" : "Maladies rares"
          }
        ]
      }
    ]
  }
}

```
