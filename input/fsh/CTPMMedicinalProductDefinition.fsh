Profile: CTPMMedicinalProductDefinition
Parent: MedicinalProductDefinition
Id: ctpm-medicinal-product-definition
Title: "Clinical Trial Medicinal Product Definition"
Description: """
Regulatory and scientific definition of an investigational medicinal product (IMP) or 
non-investigational medicinal product (NIMP) used in clinical trials. This profile captures 
the regulatory classification, hazardous characteristics, blinding role, and IWRS requirements 
specific to clinical trial pharmacy management.
"""

* ^version = "1.0.0"
* ^status = #active
* ^date = "2026-01-06"
* ^publisher = "DOCELIUM Clinical Trial Pharmacy Management Project"
* ^contact.name = "DOCELIUM Team"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "contact@docilium.health"
* ^jurisdiction = urn:iso:std:iso:3166#FR "France"
* ^purpose = """
This profile is designed to support hospital pharmacy units managing clinical trials by providing 
a standardized way to define medicinal products with their regulatory status, safety classifications, 
and trial-specific attributes (blinding, IWRS integration).
"""

// === TYPE (IMP/NIMP CLASSIFICATION) ===
* type 1..1 MS
  * ^short = "IMP or NIMP classification"
  * ^definition = """
  Mandatory classification of the product as:
  - IMP (Investigational Medicinal Product): Product being tested in the trial
  - NIMP (Non-Investigational Medicinal Product): Comparator, rescue medication, or concomitant treatment
  """
  * coding 1..1 MS
    * system 1..1
    * system = "http://docilium.health/fhir/ctpm/CodeSystem/medication-type"
      * ^short = "Fixed system for IMP/NIMP codes"
    * code 1..1
      * ^short = "IMP | NIMP"
    * display 0..1
      * ^short = "Human-readable classification"

// === CODE (PRODUCT CODES) ===
* code 1..* MS
  * ^short = "Product codes (internal, EudraCT, sponsor, ATC)"
  * ^definition = """
  Business codes identifying this medicinal product. Must include at least one internal 
  trial code. May include regulatory identifiers (EudraCT drug substance code), sponsor codes,
  and pharmacological classification codes (ATC).
  """

* code ^slicing.discriminator.type = #value
* code ^slicing.discriminator.path = "system"
* code ^slicing.rules = #open
* code ^slicing.description = "Slice based on coding system (internal code, EudraCT, sponsor code, ATC)"
* code ^slicing.ordered = false

* code contains
    internalCode 1..1 MS and
    eudraCtCode 0..1 and
    sponsorCode 0..1 

// Internal Trial Code (MANDATORY)
* code[internalCode]
  * ^short = "Internal trial medication code"
  * ^definition = """
  Unique code assigned by the trial pharmacy or protocol to identify this medication 
  within the trial context. This is the primary code used across all pharmacy movements,
  accountability records, and IWRS integration.
  """
  * system 1..1
  * system = "http://docilium.health/fhir/ctpm/drug-internal-code"
    * ^short = "Internal code system URI"
  * code 1..1
    * ^short = "Code value (e.g., 'DRO-IV-50', 'PLACEBO-A')"
  * display 0..1
    * ^short = "Human-readable product name"

// EudraCT Drug Substance Code
* code[eudraCtCode]
  * ^short = "EudraCT drug substance code"
  * ^definition = """
  European Clinical Trials Database (EudraCT) substance identifier for regulatory 
  traceability within the European Union.
  """
  * system 1..1
  * system = "https://eudract.ema.europa.eu"
    * ^short = "EudraCT substance code system"
  * code 1..1
    * ^short = "EudraCT substance identifier"
  * display 0..1
// Sponsor Product Code
* code[sponsorCode]
  * ^short = "Sponsor-assigned product code"
  * ^definition = """
  Code assigned by the clinical trial sponsor for their internal product tracking across 
  multiple sites, countries, and studies.
  """
  * system 1..1
    * ^short = "Sponsor's code system URI (sponsor-specific)"
    * ^comment = "Format: http://[sponsor-domain]/fhir/product-code or sponsor-provided URI"
  * code 1..1
    * ^short = "Sponsor's product code"
  * display 0..1

// === CLASSIFICATION (ATC, HAZARDOUS CATEGORIES) ===
* classification 0..* MS
  * ^short = "Drug classification codes (ATC, hazardous categories, therapeutic class)"
  * ^definition = """
  Pharmacological and safety classifications for this medicinal product. Multiple classification 
  types can coexist:
  - ATC (Anatomical Therapeutic Chemical): WHO pharmacological classification
  - Hazardous categories: Safety handling requirements (cytotoxic, radiopharmaceutical, etc.)
  - Therapeutic class: Disease-specific categorization
  """
* classification ^slicing.discriminator.type = #value
* classification ^slicing.discriminator.path = "coding.system"
* classification ^slicing.rules = #open
* classification ^slicing.description = "Slice based on classification system (ATC, hazardous categories, therapeutic class)"
* classification ^slicing.ordered = false

* classification contains
    atc 0..1 MS and
    hazardous 0..* MS and
    therapeuticClass 0..* MS and
    wasteCategory 0..* MS

// === ATC CLASSIFICATION ===
* classification[atc]
  * ^short = "ATC (Anatomical Therapeutic Chemical) classification"
  * ^definition = """
  WHO Anatomical Therapeutic Chemical classification system code indicating the 
  pharmacological/therapeutic category of the medication.
  """
  * coding 1..1 MS
    * system 1..1
    * system = "http://www.whocc.no/atc"
      * ^short = "WHO ATC classification system"
    * code 1..1
      * ^short = "ATC code (e.g., L01XX52, L01XX99)"
      * ^definition = "5-character or 7-character ATC code"
    * display 0..1
      * ^short = "ATC description (e.g., 'Pembrolizumab', 'Other antineoplastic agents')"
  * text 0..1
    * ^short = "Human-readable ATC classification summary"
    * ^definition = "Optional text representation, e.g., 'L01XX52 - Pembrolizumab (Antineoplastic agent)'"

// === HAZARDOUS CATEGORIES CLASSIFICATION ===
* classification[hazardous]
  * ^short = "Hazardous substance safety categories"
  * ^definition = """
  Safety classification(s) indicating special handling requirements for hazardous properties.
  Multiple hazardous categories can be assigned if the product has multiple hazardous characteristics.
  """
  * coding 1..1 MS
    * system 1..1
    * system = "http://docilium.health/fhir/ctpm/CodeSystem/hazardous-categories"
      * ^short = "Hazardous categories code system"
    * code 1..1
      * ^short = "cytotoxic | radiopharmaceutical | biological-agent | immunosuppressive | carcinogenic | sensible-temperature | none"
      * ^definition = "Specific hazardous category code"
    * display 0..1
      * ^short = "Human-readable hazardous category label"
  * text 0..1
    * ^short = "Hazardous category description"
    * ^definition = "Optional text describing specific handling precautions for this category"

// === THERAPEUTIC CLASS CLASSIFICATION ===
* classification[therapeuticClass]
  * ^short = "Therapeutic class or mechanism of action classification"
  * ^definition = """
  Disease-specific or mechanism-based therapeutic classification. This is more granular than 
  ATC and focuses on clinical/mechanistic categorization relevant to the disease being studied.
  """
  * coding 1..* MS
    * system 1..1
      * ^short = "Code system for therapeutic class (SNOMED CT, MeSH, sponsor-specific, institutional)"
      * ^comment = "If no standard code system, use sponsor-specific URI or institutional code system"
    * code 1..1
      * ^short = "Therapeutic class code"
    * display 0..1
      * ^short = "Therapeutic class description"
  * text 0..1
    * ^short = "Free-text therapeutic class description"
    * ^definition = "Human-readable description if coded representation insufficient"

// === Waste Category ===
* classification[wasteCategory]
  * ^short = "Waste category for disposal and environmental impact"
  * ^definition = """
  Classification of the waste generated by this medicinal product, indicating 
  appropriate disposal methods and environmental impact considerations.
  """
  * coding 1..* MS
    * system 1..1
      * ^short = "Code system for therapeutic class (SNOMED CT, MeSH, sponsor-specific, institutional)"
      * ^comment = "If no standard code system, use sponsor-specific URI or institutional code system"
    * code 1..1
      * ^short = "Waste category code"
    * display 0..1
      * ^short = "Waste category description"
  * text 0..1
    * ^short = "Free-text waste category description"
    * ^definition = "Human-readable description if coded representation insufficient"

// === NAME ===
* name 1..* MS
  * ^short = "Names for the medicinal product"
  * ^definition = "One or more names for the product, including scientific name (INN/DCI) and trade names"
  
  * productName 1..1 MS
    * ^short = "Full product name"
    * ^definition = "The official name of the product as it should appear in pharmacy records and labels"

// === PEDIATRIC USE ===
* pediatricUseIndicator 0..1 MS
  * ^short = "Pediatric formulation indicator"
  * ^definition = "Boolean flag indicating whether this is a pediatric-specific formulation with adjusted dosage, palatability, or administration route"

* clinicalTrial 1..1 MS
  * ^short = "Clinical trial(s) using this medicinal product"
  * ^definition = """
  Reference to ResearchStudy resource representing the clinical trial in which 
  this medicinal product is being investigated or used. This establishes the link between 
  the product definition and the study protocol.
  """

// === ROUTE OF ADMINISTRATION ===
* route 1..* MS
  * ^short = "Intended route(s) of administration"
  * ^definition = """
  Approved administration route(s) for this medicinal product in the clinical trial context.
  Multiple routes may be specified if the protocol allows flexibility (e.g., IV or SC administration).
  """
  * coding 1..* MS
    * system 1..1
    * code 1..1
      * ^short = "Route code (IV, SC, PO, IM, INHAL, IT, etc.)"
    * display 0..1

