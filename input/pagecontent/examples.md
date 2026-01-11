# Clinical Examples

This page provides complete, real-world clinical scenarios demonstrating how to use the CTPM Implementation Guide profiles and resources.

---

## Example 1: Oncology Phase III Trial - Complete Workflow

### Scenario Overview

**Study:** ONC-001 - Phase III Randomized Study of DRUG O in Solid Tumors  
**NCT Number:** NCT05687266  
**EudraCT Number:** 2024-000567-29  
**Phase:** III  
**Blinding:** Double-blind  
**IWRS Mode:** API Integration  

**Study Design:**
- 2 arms: ARM-A (DRUG O IV) vs ARM-B (Placebo)
- Treatment: 21-day cycles, up to 6 cycles
- Dosing: 3 mg/m² IV infusion on Day 1 of each cycle
- Visit schedule: C1D1, C1D8, C2D1, C2D8, C3D1...

### Key Resources

1. **ResearchStudy/study-onc-001** - Protocol definition
2. **Parameters/config-onc-001** - Study configuration
3. **MedicinalProductDefinition/drug-o-iv-product** - Regulatory definition
4. **MedicationKnowledge/drug-o-iv-knowledge** - Operational knowledge
5. **Patient/patient-p001** - Patient P001
6. **Observation/weight-p001-c1d1** - Weight: 72 kg
7. **Observation/height-p001** - Height: 175 cm
8. **SupplyDelivery/reception-lot-a45821** - Receiving 24 vials
9. **SupplyDelivery/dispensation-p001-c1d1** - Dispensing 2 vials to P001
10. **Provenance/audit-reception** - Audit trail for reception
11. **Provenance/audit-dispensation** - Audit trail for dispensation

---

## Timeline

### Day 1: Protocol Creation (2024-06-01)
**Actor:** Dr. Nadia Benali (Pharmacist)

Creates protocol ONC-001 with:
- Double-blind design
- IWRS API integration
- Visit schedule with 21-day cycles
- Temperature monitoring FULL mode
- Local destruction policy

---

### Day 30: Medication Reception (2025-01-14 09:42)
**Actor:** Dr. Nadia Benali (Pharmacist)

Receives shipment:
- Lot: LT-A45821
- Expiry: 2026-04-30
- Quantity: 24 vials
- Temperature: 4.2°C 
- Packaging: INTACT

**Stock after:** 24 vials available

---

### Day 32: First Dispensation - C1D1 (2025-01-15 09:30)
**Actor:** Dr. Nadia Benali (Pharmacist)

**Patient:** P001, male, age 59

**Anthropometric data:**
- Weight: 72 kg (captured 2025-01-14) 
- Height: 175 cm
- BSA: 1.87 m²

**Dose calculation:**
```
Prescribed: 3 mg/m²
BSA: 1.87 m²
Calculated: 3 × 1.87 = 5.61 mg
Vials: 5.61 / 5 = 1.122 → 2 vials (VIAL_BASED rounding)
```

**IWRS API response:**
- Kit: KIT-001
- Arm: ARM-A
- Transaction: IWRS-TXN-12345

**Stock after:** 22 vials remaining

---

## Example 2: Oral Medication - Compliance Tracking

### Scenario

**Patient:** P002  
**Medication:** DRUG O Oral 25mg capsules  
**Dosing:** 1 capsule daily × 14 days per 28-day cycle  
**Form:** Blister packs (14 capsules/blister)  

### Dispensation - C1D1
Dispenses 28 capsules (2 blisters)

### Return - C2D1 (28 days later)
Patient returns:
- 25 capsules returned
- 3 capsules missing
- Reason: "Forgot 3 doses due to nausea"

**Compliance:**
```
Expected: 14 doses
Actual: 11 doses (14 - 3 missing)
Compliance: 11/14 = 78.6% 
```

**Action:** Study Coordinator notified

---

## Example 3: Temperature Excursion

### Scenario

Reception with temperature excursion:
- Lot: LT-B99234
- Temperature at reception: **12.5°C**  (limit: 8°C)
- Data logger: 9 hours at 10-13°C

**System action:**
- Auto-quarantine → Stock status: QUARANTINE

**Pharmacist action:**
1. Documents excursion
2. Contacts sponsor QA
3. Sends data logger report

**Sponsor decision (next day):**
- Stability confirmed
- Lot released
- Status: QUARANTINE → AVAILABLE

---

## Example 4: Destruction with E-Signature

### Items to Destroy
- 10 used vials (post-infusion)
- 3 expired vials

**Method:** Local incineration (cytotoxic)  
**Contractor:** EcoWaste Solutions  

### Workflow

1. **Batch creation** by Pharmacist
2. **ARC approval** by Julie Bernard (2025-02-01 14:30)
3. **E-signature** by Dr. Nadia Benali (2025-02-01 15:45)
4. **Physical destruction** (2025-02-03)

---

## Example 5: Inter-Site Transfer

**From:** Hospital A (Site 01) - 12 vials  
**To:** Hospital B (Site 02)  
**Reason:** Site 01 closing early  
**Courier:** FedEx Clinical, tracking 123456789  
**Temperature:** 2-8°C maintained  

**Stock impact:**
- Site 01: -12 vials
- Site 02: +12 vials
