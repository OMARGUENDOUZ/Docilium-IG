# Scope and Objectives

## Business Context

### Current State: The Excel Problem

The majority of hospital pharmacy units managing clinical trials currently rely on:
- **Excel spreadsheets** for drug accountability ledgers
- **Paper logs** for reception, dispensation, and destruction records
- **Manual temperature monitoring** logs
- **Email-based** communication with IWRS systems

**Critical Issues:**
- **No traceability**: Who changed what and when is unclear
- **No audit trail**: Cannot reconstruct historical state
- **Inspection failures**: Non-compliant with FDA 21 CFR Part 11 and EMA Annex 11
- **Data integrity risks**: Violates ALCOA+ principles (not Attributable, not Contemporaneous, not Enduring)
- **Error-prone**: Manual calculations for weight-based dosing lead to medication errors
- **Time-consuming**: Reconciliation for sponsor audits takes weeks

### Target State: FHIR-Based Digital Pharmacy

A fully integrated, FHIR-based clinical trial pharmacy system that provides:
- **Real-time accountability**: Instant stock balance calculations
- **Complete audit trail**: Every action logged with user, role, timestamp, and cryptographic signature
- **IWRS integration**: Automatic treatment assignment via API
- **Rule-driven validation**: Protocol-specific business rules enforced automatically
- **GCP/GMP compliance**: Out-of-the-box compliance with regulatory requirements
- **Multi-site interoperability**: Standardized data exchange between sites and sponsors

## Functional Scope

### In Scope for Version 1.0

#### 1. Protocol Management
- Create and configure clinical trial protocols (ResearchStudy)
- Define study parameters: IWRS integration mode, blinding level, visit schedule, patient constraints
- Temperature governance (Basic vs Full)
- Destruction/return policies
- E-signature requirements

#### 2. Medication Definition
- Define IMP/NIMP medicinal products
- Regulatory classification (IMP vs NIMP)
- Hazardous categories (cytotoxic, radiopharmaceutical, biological agent)
- Dosing guidelines (fixed, mg/kg, mg/m²)
- Preparation and reconstitution instructions
- Storage conditions and temperature requirements

#### 3. Pharmacy Movements
Five movement types are supported:

**RECEPTION:** Receive shipments from sponsor/depot, record lot number, expiry date, temperature

**DISPENSATION:** Patient-specific or patient-agnostic dispensing with automatic dose calculations

**RETOUR (Return):** Patient returns with compliance tracking for oral medications

**DESTRUCTION:** Local destruction batch management with e-signature

**TRANSFER:** Inter-site transfers with chain of custody

#### 4. Audit Trail & E-Signatures
- Every action logged in Provenance resources
- User attribution with role at time of action
- Cryptographic hash chain for immutability
- E-signature support for critical actions

#### 5. IWRS Integration
Three integration modes:
- **Manual Mode**: Pharmacy staff manually enters kit number
- **CSV Import Mode**: Batch import of IWRS assignments
- **API Integration Mode**: Real-time API calls during dispensation

#### 6. Temperature Monitoring
- **Basic Mode**: Manual entry of temperature ranges
- **Full Mode**: Continuous monitoring with automatic quarantine on excursion

### Out of Scope (Future Versions)

#### Phase 2 Candidates:
- Equipment management (CSTD systems, filters, pumps)
- Dose escalation protocols for phase I trials
- EDC integration
- Mobile barcode scanning apps

## Use Cases

### UC-1: Oncology Phase III Trial with IV Chemotherapy

**Scenario:**
- Drug O IV, cytotoxic, dose = 3 mg/m², infusion every 21 days
- Double-blind, API-based IWRS
- Multi-vial dispensing allowed
- Local destruction required for cytotoxic waste
- Temperature monitoring: 2-8°C, full mode

**Workflow:**
1. Pharmacist creates protocol with visit schedule, blinding=double, IWRS=API
2. Defines Drug O IV as IMP, hazardous=cytotoxic, concentration=PER_M2
3. Receives 120 vials from sponsor, captures temp=4.2°C
4. Patient P001 presents for C1D1
5. Captures weight=72kg, height=175cm → BSA=1.87m²
6. Calculates dose: 3 mg/m² × 1.87 m² = 5.61 mg → rounds to 2 vials
7. Calls IWRS API → receives kitNumber=KIT-001
8. Dispenses 2 vials, generates preparation worksheet
9. Creates SupplyDelivery movement with audit trail
10. End of month: batch-destroys used materials with e-signature

### UC-2: Oral Medication with Compliance Tracking

**Scenario:**
- Drug O Oral 25mg capsules, blister packs
- Open-label, manual IWRS
- Compliance tracking required (blister count)
- Sponsor return policy for unused medication

**Workflow:**
1. Defines Drug O Oral as IMP, form=capsule, compliance_tracking=BLISTER_COUNT
2. Dispenses 28 capsules (1 blister) to patient for 28-day cycle
3. Patient returns at C2D1 with 3 capsules remaining
4. Pharmacy counts: dispensed=28, returned=25, missing=3 → compliance=89%
5. Logs RETOUR movement with compliance data
6. Unused blisters shipped back to sponsor at end of study

## Success Criteria

1. **Regulatory Acceptance**: Systems implementing this IG pass FDA/EMA inspections without drug accountability findings
2. **Adoption**: At least 10 hospital pharmacies deploy FHIR-based systems using this IG by end of 2026
3. **Interoperability**: Multi-site trials can exchange drug accountability data without custom mappings
4. **Audit Time Reduction**: Time to prepare for sponsor audits reduced by >75%
5. **Error Reduction**: Medication calculation errors reduced by >90% through automated dosing

---

*Next: [Actors & Roles →](actors.html)*
