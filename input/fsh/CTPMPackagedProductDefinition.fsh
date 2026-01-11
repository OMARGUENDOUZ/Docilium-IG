Profile: CTPMPackagedProductDefinition
Parent: PackagedProductDefinition
Id: ctpm-packaged-product-definition
Title: "Clinical Trial Packaged Product Definition"
Description: """
Describes the physical packaging configuration of a clinical trial medication, including 
primary containers (vials, blisters, syringes), quantities, and dosage per container. 
This profile is essential for inventory management, dispensing calculations, and accountability 
unit tracking in clinical trial pharmacy operations.
"""

* ^version = "1.0.0"
* ^status = #active
* ^date = "2026-01-06"
* ^publisher = "DOCELIUM Clinical Trial Pharmacy Management Project"
* ^jurisdiction = urn:iso:std:iso:3166#FR "France"
* ^purpose = """
Enables accurate stock management by defining exactly what constitutes a countable unit 
(e.g., 1 kit = 10 vials of 50mg each). This is critical for IMP accountability reconciliation 
required by GCP guidelines.
"""

// === PACKAGE FOR (LINK TO MEDICINAL PRODUCT) ===
* packageFor 1..1 MS
  * ^short = "Reference to the MedicinalProductDefinition this packaging contains"
  * ^definition = "Links this packaging configuration to the parent medicinal product definition"

// === PACKAGE STRUCTURE ===
* packaging 1..1 MS
  * ^short = "Physical packaging structure"
  * ^definition = "Describes the actual packaging hierarchy: outer carton contains X vials, each vial contains Y mg"
  
  * type 1..1 MS
    * ^short = "Accounting unit for IMP tracking (kit, vial, blister, ampoule)"
    * ^definition = "The type of primary container that directly holds the medication"
    * coding 1..1
      * system 1..1
        * ^short = "Preferably http://standardterms.edqm.eu"
      * code 1..1
        * ^short = "EDQM code (e.g., 30009000 for 'Vial')"
      * display 0..1
// === PROPRIÉTÉS MÉTIER via property ===
* packaging.property 0..* MS
  * ^short = "Product handling properties"
  * ^definition = "General characteristics including destruction policies, return requirements, compliance tracking needs"

// Slice sur property.type
* packaging.property ^slicing.discriminator.type = #value
* packaging.property ^slicing.discriminator.path = "type.coding.code"
* packaging.property ^slicing.rules = #open

* packaging.property contains
    destructionPolicy 0..1 and
    returnPolicy 0..1

// Destruction Policy
* packaging.property[destructionPolicy]
  * type 1..1
    * coding 1..1
      * system = "http://docilium.health/fhir/ctpm/CodeSystem/product-property-type"
      * code = #destruction-policy
      * display = "Destruction Policy"
  * valueCodeableConcept 1..1
    * coding from DestructionPolicyVS (required)
      * ^short = "none | local | sponsor | mixed"

// Sponsor Return Required
* packaging.property[returnPolicy]
  * type 1..1
    * coding 1..1
      * system = "http://docilium.health/fhir/ctpm/CodeSystem/product-property-type"
      * code = #return-policy
  * valueCodeableConcept 1..1

