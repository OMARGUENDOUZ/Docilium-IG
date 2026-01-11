# Actors and Roles

## Role-Based Access Control (RBAC) Principles

The CTPM system implements strict RBAC with the following principles:

1. **Role-based permissions**: Authorization by role, not individual user
2. **Study-level access**: Users may have different roles across different studies
3. **Critical action controls**:
   - E-signature for pharmacist actions (destruction certificates, period closures)
   - ARC visa when required by protocol
   - Append-only audit trail (no deletions allowed)
4. **No anonymous access**: All users must authenticate (email + password + 2FA mandatory)

## User Roles

### PHARMACIEN (Pharmacist)
**Objective:** Responsible for IMP/NIMP accountability and compliance

**Access:**
- Create/modify study protocols
- Configure medications and equipment
- Perform all movements (reception, dispensation, return, destruction, transfer)
- Modify non-locked movements
- Generate accountability reports (partial or global)
- E-sign destruction certificates and accounting periods
- Lock/unlock accounting periods
- View audit trail (filtered by assigned studies)

**FHIR Representation:**
```
Provenance.agent.role = http://docilium.health/fhir/ctpm/CodeSystem/user-role#PHARMACIEN
```

---

### TECHNICIEN_PUI (Pharmacy Technician)
**Objective:** Operational support for pharmacy movements

**Access:**
- Enter movements (reception, dispensation, return, transfer) if configured
- View real-time stock levels
- View movement history for assigned studies
- Generate reports (read-only)

---

### ARC_PROMOTEUR (Clinical Research Associate - Sponsor)
**Objective:** Monitoring and validation on behalf of sponsor

**Access:**
- View movements, stock, medication configurations (read-only)
- View accounting periods and destruction batches
- Approve/visa movements when required by protocol
- Approve destruction batches
- Generate accountability reports (read-only)
- View audit trail (filtered by assigned studies)

---

### AUDITEUR/INSPECTEUR (Auditor/Inspector)
**Objective:** External oversight and GCP compliance verification

**Access:**
- View all data in read-only mode
- Full audit trail access (filtered by assigned studies)
- View locked accounting periods
- Export reports (non-modifiable formats only)

---

## Permissions Matrix

| Action / Module | PHARMACIEN | TECHNICIEN_PUI | ARC_PROMOTEUR | AUDITEUR |
|-----------------|------------|----------------|---------------|----------|
| **Access assigned studies** | | | (assigned) | (assigned) |
| **Create/modify study** | | ❌ | ❌ | ❌ |
| **Configure medications/equipment** | | ❌ | ❌ | ❌ |
| **Enter movements** | | (if config allows) | ❌ | ❌ |
| **Modify non-locked movement** | | | ❌ | ❌ |
| **View audit trail** | (study-filtered) | (restricted) | (study-filtered) | (read-only) |
| **Manage stock** | | | ❌ | (read-only) |
| **Generate accountability reports** | | | (read-only) | (read-only) |
| **Approve movements (ARC visa)** | ❌ | ❌ | | ❌ |
| **E-sign accounting period** | (e-signature) | ❌ | ❌ | ❌ |
| **Lock/unlock accounting period** | | ❌ | ❌ | ❌ |
| **E-sign destruction batch** | (e-signature) | ❌ | ❌ | ❌ |
| **Approve destruction batch (ARC)** | ❌ | ❌ | | ❌ |
| **Export CSV/PDF** | | | | |

## Locking and Immutability Rules

### When Does a Record Become Read-Only?

A movement, accounting period, or destruction batch becomes **read-only** when:

1. **Associated with a LOCKED accounting period**
2. **Already e-signed by pharmacist**
3. **Already approved by ARC** (if protocol requires ARC visa)

**Correction Mechanism:**
- Direct modification forbidden → must create:
  - **Corrective movement** (for operational errors)
  - **Amending period** (for accounting adjustments)

## Audit Trail Requirements

### Mandatory Audit Events

Every action SHALL create a `Provenance` resource with:

1. **User attribution**: `Provenance.agent.who` (reference to Practitioner)
2. **Role at time of action**: `Provenance.agent.role` (pharmacien, technicien, arc, etc.)
3. **Study context**: `Provenance.extension[studyReference]`
4. **Before/after snapshots**: For modifications, include `Provenance.entity` with before/after state
5. **Cryptographic hash**: `Provenance.extension[hashCurrent]` for ALCOA+ integrity

### Example Audit Entry
```json
{
  "resourceType": "Provenance",
  "id": "audit-dispensation-p001",
  "target": [
    {
      "reference": "SupplyDelivery/dispensation-p001-c1d1"
    }
  ],
  "recorded": "2025-01-15T09:30:17+01:00",
  "activity": {
    "coding": [
      {
        "system": "http://docilium.health/fhir/ctpm/CodeSystem/audit-action",
        "code": "CREATE_MOVEMENT"
      }
    ]
  },
  "agent": [
    {
      "who": {
        "reference": "Practitioner/pharmacist-nadia"
      },
      "role": [
        {
          "coding": [
            {
              "system": "http://docilium.health/fhir/ctpm/CodeSystem/user-role",
              "code": "PHARMACIEN"
            }
          ]
        }
      ]
    }
  ],
  "signature": [
    {
      "type": [
        {
          "system": "urn:iso-astm:E1762-95:2013",
          "code": "1.2.840.10065.1.12.1.1"
        }
      ],
      "when": "2025-01-15T09:31:02+01:00",
      "who": {
        "reference": "Practitioner/pharmacist-nadia"
      },
      "data": "YmY5MmMzYTFlNmMzNDk3ZmNiM2YyMmJlMzRkMjgxYjkxZGZiMDhiMmQ1OTRhODVkYzA0ZjI4MDFkMWNkMmZlZg=="
    }
  ],
  "extension": [
    {
      "url": "http://docilium.health/fhir/ctpm/StructureDefinition/hash-current",
      "valueString": "bf92c3a1e6c3497fcb3f22be34d281b91dfb08b2d594a85dc04f2801d1cd2fef"
    }
  ]
}
```

---

*Next: [Workflows →](workflows.html)*
