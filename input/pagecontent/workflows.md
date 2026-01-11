# Operational Workflows

This page describes the step-by-step workflows for key pharmacy operations in clinical trials.

---

## Workflow 1: Protocol Creation

### Prerequisites
- User authenticated as PHARMACIEN or ADMIN
- Approved protocol document available
- Regulatory identifiers assigned (NCT number, EudraCT number)

### Steps

#### 1. Access Protocol Creation Module
- Navigate to: Studies → Create New Protocol
- System displays empty protocol form with 7 configuration blocks

#### 2. Block A: Identification
**Required fields:**
- `protocol_status`: DRAFT | ACTIVE | SUSPENDED | CLOSED | TERMINATED
- `code_internal`: Unique internal code (e.g., "ONC-2024-TRIAL-01")
- `nct_number`: ClinicalTrials.gov identifier (e.g., "NCT05687266")
- `eu_ct_number`: EudraCT number (e.g., "2024-000567-29")
- `title`: Full protocol title
- `sponsor`: Sponsor organization name
- `phase`: I, I/II, II, III, IV, OTHER
- `therapeutic_area`: Oncology, Cardiology, Neurology, etc.

**FHIR Mapping:**
```turtle
Instance: study-onc-001
InstanceOf: ClinicalStudy
* identifier[0]
  * system = "http://clinicaltrials.gov"
  * value = "NCT05687266"
* identifier[1]
  * system = "https://eudract.ema.europa.eu"
  * value = "2024-000567-29"
* title = "A Phase III Randomized Study of DRUG O in Solid Tumors"
* status = #active
* phase = http://terminology.hl7.org/CodeSystem/research-study-phase#phase-3
```

#### 3. Block B: Organization & Contacts
**Required contacts:**
- Principal Investigator (PI): name, email, phone
- Study Coordinator (SC): name, email, phone
- CRA Promoteur: name, email, phone

#### 4. Block C: Operational Parameters
**Blinding:** Select: NONE | SINGLE | DOUBLE | TRIPLE

**Randomization/Arms:** Define arms: ["A", "B", "C"]

**Destruction/Return Policies:**
- `destruction_policy`: NONE | LOCAL | SPONSOR | MIXED
- `return_policy`: LOCAL_STOCK | SPONSOR_RETURN

**FHIR Mapping (via StudyConfig):**
```turtle
Instance: config-onc-001
InstanceOf: StudyConfig
* parameter[Blinding].valueCode = #double
* parameter[DestructionPolicy].valueCode = #local
* parameter[IwrsGovernance].valueCode = #api
```

#### 5. Block D: Visit Schedule
**Define visit structure:**
```json
{
  "visit_schedule": [
    {"visit_code": "C1D1", "day": 1, "requires_dispense": true},
    {"visit_code": "C1D8", "day": 8, "requires_dispense": false},
    {"visit_code": "C2D1", "day": 22, "requires_dispense": true}
  ],
  "treatment_cycles": {
    "cycle_length": 21,
    "max_cycles": 6
  }
}
```

#### 6. Validation & Submission
- Click "Create Protocol"
- Backend validates uniqueness, mandatory fields, coherence rules
- System generates: ResearchStudy + StudyConfig + Audit trail

---

## Workflow 2: Medication Reception (IMP Shipment)

### Prerequisites
- Protocol created and ACTIVE
- At least one medication configured
- User authenticated as PHARMACIEN or TECHNICIEN_PUI
- Physical shipment received from sponsor/depot

### Steps

#### 1. Access Reception Module
- Navigate to: Movements → New Reception
- Select protocol: "ONC-001"
- System displays medication list

#### 2. Select Medication
- Choose: "DRUG O IV 50mg"
- System loads medication configuration from MedicationKnowledge

#### 3. Enter Shipment Details

**Mandatory fields:**
- `lot_number`: Manufacturer lot (e.g., "LT-A45821")
- `expiry_date`: Expiration date (e.g., "2026-04-30")
- `quantity`: Number of units (e.g., 24 vials)
- `accounting_unit`: AUTO-POPULATED from PackagedProductDefinition (VIAL)

**Conditional fields (if temperature_tracking_enabled = true):**
- `temperature_at_reception`: Temperature reading (e.g., 4.2°C)
- `temperature_excursion`: YES/NO

#### 4. Temperature Excursion Handling

**If temperature excursion detected:**
1. System flags shipment as "QUARANTINE" status
2. Pharmacist must document excursion details and contact sponsor
3. If auto_quarantine_on_excursion = true: stock item created with QUARANTINE status

#### 5. FHIR Resource Creation

**SupplyDelivery (Movement):**
```turtle
Instance: reception-drug-o-lot-a45821
InstanceOf: CTPMSupplyDelivery
* status = #completed
* type.coding.code = #RECEPTION
* suppliedItem
  * itemReference = Reference(MedicationKnowledge/drug-o-iv-knowledge)
  * quantity
    * value = 24
    * unit = "vial"
* occurrenceDateTime = "2025-01-14T09:42:17+01:00"
* extension[lotNumber].valueString = "LT-A45821"
* extension[expiryDate].valueDate = "2026-04-30"
* extension[temperatureAtReception].valueQuantity.value = 4.2
```

**Stock Item Creation:**
- Backend creates inventory item with 24 vials available

**Provenance (Audit Trail):**
- Audit entry created with pharmacist attribution and timestamp

#### 6. Confirmation
- System displays success message
- Stock balance updated: +24 vials
- Movement appears in reception log

---

## Workflow 3: Dispensation with BSA-Based Dosing

### Prerequisites
- Protocol ACTIVE
- Medication configured with concentration_type = PER_M2
- Stock available
- Patient enrolled in study
- User authenticated as PHARMACIEN or TECHNICIEN_PUI

### Scenario
- Patient P001, Cycle 1 Day 1 (C1D1)
- Medication: DRUG O IV (dose = 3 mg/m²)
- IWRS mode: API
- Multi-vial dosing allowed

### Steps

#### 1. Access Dispensation Module
- Navigate to: Movements → New Dispensation
- Select protocol: "ONC-001"
- Select medication: "DRUG O IV 50mg"

#### 2. Enter Patient Context
**Required fields:**
- `patient_code`: P001 (system validates patient exists)
- `visit_code`: C1D1 (validates against visit schedule)
- `cycle`: 1
- `day`: 1

#### 3. Collect Anthropometric Data

**System checks: requires_recent_weight_days**
- Protocol setting: requires_recent_weight_days = 7
- System queries Observations for patient P001:
  - `code` = LOINC:29463-7 (Body weight)
  - `effectiveDateTime` within last 7 days

**If recent weight NOT found:**
- System blocks dispensation
- Error: "Weight measurement required within 7 days"

**If recent weight found:**
- Weight = 72 kg (captured 2025-01-14)
- Height = 175 cm (captured at baseline)

#### 4. Calculate BSA
**Formula (Mosteller):**
```
BSA (m²) = √[(height_cm × weight_kg) / 3600]
BSA = √[(175 × 72) / 3600]
BSA = √3.5
BSA = 1.87 m²
```

**System displays:**
- Weight: 72 kg
- Height: 175 cm
- BSA: 1.87 m²
- Dose calculation: 3 mg/m² × 1.87 m² = **5.61 mg**

#### 5. Calculate Vial Requirements

**Medication configuration:**
- `dosage_per_vial`: 5 mg
- `multi_vial_dose_allowed`: true
- `dose_rounding_policy`: VIAL_BASED

**Calculation:**
- Dose needed: 5.61 mg
- Vials needed (exact): 5.61 mg / 5 mg = 1.122 vials
- Rounded: **2 vials** (rounding up to nearest whole vial)

#### 6. IWRS Integration (API Mode)

**System makes API call:**
```http
POST https://iwrs-system.sponsor.com/api/v1/assign-treatment
Body:
{
  "study_code": "ONC-001",
  "patient_code": "P001",
  "visit_code": "C1D1",
  "medication_code": "DRO-IV-50",
  "quantity_requested": 2,
  "bsa": 1.87
}
```

**IWRS Response:**
```json
{
  "status": "SUCCESS",
  "kit_number": "KIT-001",
  "randomization_arm": "ARM-A",
  "transaction_id": "IWRS-TXN-12345"
}
```

#### 7. Stock Deduction Check
- Current stock: 24 vials
- Requested: 2 vials
- Stock sufficient
- System reserves 2 vials

#### 8. Generate Preparation Worksheet

**System populates worksheet from MedicationKnowledge.preparationInstruction:**
```
PREPARATION WORKSHEET - DRUG O IV
Patient: P001 | Visit: C1D1 | Date: 2025-01-15

DOSE CALCULATION:
- Weight: 72 kg
- Height: 175 cm  
- BSA: 1.87 m²
- Prescribed dose: 3 mg/m²
- Calculated dose: 5.61 mg
- Vials to use: 2 vials (lot LT-A45821)

RECONSTITUTION:
1. Aseptically reconstitute each vial with 10 mL NaCl 0.9%
2. Gently swirl (do not shake)
3. Inspect for particulates

DILUTION:
1. Add reconstituted solution to 250 mL NaCl 0.9%
2. Mix gently by inversion
3. Protect from light

STABILITY:
- Use within 4 hours at room temperature
- May store up to 24 hours at 2-8°C

PREPARED BY: __________ DATE: _____ TIME: _____
VERIFIED BY: __________ DATE: _____ TIME: _____
```

#### 9. Create FHIR Resources

**SupplyDelivery (Dispensation):**
```turtle
Instance: dispensation-p001-c1d1
InstanceOf: CTPMSupplyDelivery
* status = #completed
* patient = Reference(Patient/patient-p001)
* type.coding.code = #DISPENSATION
* suppliedItem
  * itemReference = Reference(MedicationKnowledge/drug-o-iv-knowledge)
  * quantity.value = 2
* occurrenceDateTime = "2025-01-15T09:30:00+01:00"
* extension[iwrsTransactionRef].valueString = "IWRS-TXN-12345"
* extension[kitNumber].valueString = "KIT-001"
* extension[visitCode].valueString = "C1D1"
* extension[calculatedDose]
  * extension[bsa].valueQuantity.value = 1.87
  * extension[doseMg].valueQuantity.value = 5.61
  * extension[vialsUsed].valueInteger = 2
```

**Stock Update:**
- lot LT-A45821: 24 vials → **22 vials** remaining

**Provenance:**
- Audit entry with pharmacist e-signature

#### 10. Print & Label
- Print preparation worksheet
- Generate medication label with study ID, patient code, dose, lot, expiry
- Deliver to infusion suite

---

*Next: [Examples →](examples.html)*
