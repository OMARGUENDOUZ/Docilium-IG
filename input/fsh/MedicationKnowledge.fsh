Profile: CTPMMedicationKnowledge
Parent: MedicationKnowledge
Id: ctpm-medication-knowledge
Title: "Clinical Trial Medication Knowledge"
Description: """
Comprehensive clinical and operational knowledge for a clinical trial medication, including:
- Dose calculation methods (fixed, weight-based, BSA-based)
- Preparation and reconstitution instructions
- Stability windows and storage requirements
- Required equipment and safety precautions
- Destruction and return policies
- Compliance tracking methods (for oral medications)

This resource acts as the 'instruction manual' for pharmacy staff handling the medication.
"""

* ^version = "1.0.0"
* ^status = #active
* ^date = "2026-01-06"
* ^publisher = "DOCELIUM Clinical Trial Pharmacy Management Project"
* ^jurisdiction = urn:iso:std:iso:3166#FR "France"
* ^purpose = """
Centralizes all operational knowledge required for safe and protocol-compliant handling of 
clinical trial medications. Reduces reliance on paper protocols and enables rule-driven 
validation in pharmacy systems.
"""

// === IDENTIFIERS ===
* identifier 1..* MS
  * ^short = "Business identifiers"
  * ^definition = "Unique identifiers linking this knowledge base to the medication definition"
// === STATUS ===
* status 1..1 MS
  * ^short = "active | inactive | entered-in-error"
  * ^definition = """
  Lifecycle status:
  - active: Current instructions in use
  - inactive: Superseded by updated version or protocol closed
  - entered-in-error: Created in error, disregard
  """
* definitional
// === DOSE FORM ===
  * doseForm 1..1 MS
    * ^short = "Pharmaceutical dose form"
    * ^definition = """
    The form of the medication as it will be administered (not necessarily as received).
    Examples:
    - 'Powder for solution for infusion' (received as powder, administered as infusion)
    - 'Solution for injection' (ready-to-use)
    - 'Capsule, hard' (oral solid)
    - 'Solution for inhalation' (nebulizer administration)
    """
    * coding 1..* MS
      * system 1..1
        * ^short = "Preferably http://standardterms.edqm.eu"
      * code 1..1
        * ^short = "EDQM dose form code"
      * display 0..1

// === INTENDED ROUTE ===
  * intendedRoute 1..* MS
    * ^short = "Intended route(s) of administration"
    * ^definition = """
    Route(s) by which this medication knowledge applies. Multiple routes may be specified 
    if protocol allows flexibility or if the same product can be given via different routes.
    """
    * coding 1..* MS
      * system 1..1
      * code 1..1
        * ^short = "IV | SC | PO | IM | INHAL | IT | TOPICAL | OTHER"
  // === DRUG CHARACTERISTIC ===
  * drugCharacteristic 0..* MS
    * ^short = "Physical and chemical characteristics"
    * ^definition = """
    Specific properties of the medication relevant to preparation, handling, or administration:
    - Diluent type and volume range
    - Final concentration range after dilution
    - Filter requirements
    - Physical appearance (color, clarity)
    - pH range
    - Osmolarity
    """
    * type 1..1 MS
      * ^short = "Type of characteristic (diluent, concentration, filter, appearance, pH)"
      * ^definition = "Classification of the characteristic being described"
      * coding 1..1
        * system 1..1
        * code 1..1
          * ^short = "diluent | final-concentration | filter | appearance | ph | osmolarity"
  
    * value[x] 1..1 MS
      * ^short = "Value of this characteristic"
      * ^definition = "The actual value or range (string for text descriptions, Quantity for numeric values)"

// === INDICATION GUIDELINE (DOSE CALCULATIONS) ===
* indicationGuideline 0..* MS
  * ^short = "Dosing guidelines for specific indications or patient populations"
  * ^definition = """
  Structured dosing information including:
  - Dose calculation method (fixed dose, mg/kg, mg/m²)
  - Actual dose amount
  - Dose adjustments for specific patient characteristics (renal impairment, age, etc.)
  """
  
  * indication 0..1
    * ^short = "Clinical indication for this dosing guideline"
    * ^definition = "The condition or trial phase for which this dosing applies"  
  * dosingGuideline 1..* MS
    * ^short = "Specific dosing instructions"
    * ^definition = "One or more dosing regimens applicable to this indication"
    
    * dosage 1..* MS
      * ^short = "Dosage details"
      * ^definition = "Structured representation of the dose"
      
      * type 1..1 MS
        * ^short = "Type of dosing (fixed, per kg, per m²)"
        * ^definition = """
        Classification of dose calculation method:
        - fixed: Same dose for all patients (e.g., 100 mg)
        - per-kg: Dose scaled by body weight (e.g., 5 mg/kg)
        - per-m²: Dose scaled by body surface area (e.g., 75 mg/m²)
        - other: Other calculation method described in text
        """
        * coding 1..1
          * system 1..1
          * system = "http://docilium.health/fhir/ctpm/CodeSystem/concentration-type"
          * code 1..1
            * ^short = "fixed | per-kg | per-m2 | other"
      
      * dosage 1..* MS
        * ^short = "Actual dose specification"
        * ^definition = "The dose amount and unit"
        
        * doseAndRate 1..* MS
          * ^short = "Dose quantity and rate"
          
          * doseQuantity 0..1 MS
            * ^short = "Dose amount (e.g., 3 mg/m², 5 mg/kg, 100 mg)"
            * ^definition = "Numeric dose with units appropriate to the dosing type"
            * value 1..1
              * ^short = "Numeric value (3, 5, 75, 100, etc.)"
            * unit 1..1
              * ^short = "Unit string (mg/m², mg/kg, mg, etc.)"
            * system 1..1
            * system = "http://unitsofmeasure.org"
            * code 1..1
              * ^short = "UCUM code (mg/m2, mg/kg, mg, etc.)"
          
          * rateRatio 0..1
            * ^short = "Infusion rate (for IV administration)"
            * ^definition = "Rate at which the medication should be administered (e.g., 100 mL/hour)"
        * maxDosePerAdministration	0..1 MS
          * ^short = "Maximum dose per administration"
          * ^definition = "Upper limit on dose for safety"

// === PREPARATION INSTRUCTION ===
* preparationInstruction 0..1 MS
  * ^short = "Step-by-step preparation and reconstitution instructions"
  * ^definition = """
  Comprehensive text-based instructions for preparing the medication for administration.
  This is the pharmacist's primary reference for compounding and reconstitution.
  """

// === STORAGE GUIDELINE ===
* storageGuideline 0..* MS
  * ^short = "Storage and stability requirements"
  * ^definition = """
  Complete storage instructions including:
  - Temperature range for unopened product
  - Light protection requirements
  - Orientation requirements (upright storage)
  - Stability after opening, reconstitution, or dilution
  - Freeze/thaw cycles allowed
  """
  
  * stabilityDuration 0..1 MS
  
  * environmentalSetting 0..* MS
    * ^short = "Environmental factors (temperature monitoring, light exposure)"
    * ^definition = "Codified environmental requirements"
    * type 1..1 MS
      * ^short = "Type of environmental setting"
      * ^definition = "Classification of the environmental requirement"
      * coding 1..1
        * system 1..1
        * code 1..1
          * ^short = "temperature-monitored | light-protected | upright-storage"