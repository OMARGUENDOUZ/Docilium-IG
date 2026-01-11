# Clinical Trial Pharmacy Management (CTPM) Implementation Guide

## Introduction

The **Clinical Trial Pharmacy Management (CTPM) Implementation Guide** defines FHIR R5 profiles, extensions, and workflows for managing investigational medicinal products (IMP) and non-investigational medicinal products (NIMP) in clinical trial pharmacy settings.

This Implementation Guide addresses a critical gap in current practice: most hospital pharmacies still manage IMP/NIMP accountability using Excel spreadsheets and paper logs.

## Scope

### Core Functionalities
- **Protocol Management**: Complete study configuration including IWRS settings, blinding, visit schedules
- **Drug Accountability**: IMP/NIMP inventory management with lot tracking
- **Dispensing Workflows**: Weight-based (mg/kg) and BSA-based (mg/m²) dosing calculations
- **Temperature Monitoring**: Cold chain integrity tracking
- **IWRS Integration**: Manual, CSV import, and API modes
- **Audit Trails**: ALCOA+ compliant provenance with e-signatures
- **Destruction Workflows**: Local vs sponsor-managed destruction

## Architecture Overview

ResearchStudy (Protocol)
    ├── StudyConfig (Parameters)
    ├── MedicinalProductDefinition (Regulatory)
    ├── MedicationKnowledge (Operational)
    └── PackagedProductDefinition (Packaging)

SupplyDelivery (Movements)
    ├── RECEPTION | DISPENSATION | RETOUR | DESTRUCTION | TRANSFER
    └── Provenance (Audit trail with e-signatures)

## Navigation

- [Scope & Objectives](scope.html)
- [Actors & Roles](actors.html)
- [Workflows](workflows.html)
- [Profiles](artifacts.html)
- [Examples](examples.html)