# Module Refactoring Documentation

## Previous Architecture (with Circular Dependencies)

```
┌────────────────────┐              ┌───────────────────┐
│                    │              │                   │
│   security-vpc     │              │     fgcp-ha       │
│                    │              │                   │
│  ┌──────────────┐  │              │ ┌─────────────┐   │
│  │ Subnets      │  │              │ │ FortiGate   │   │
│  │              │──┼──────────────┼─► instances   │   │
│  └──────────────┘  │              │ └─────────────┘   │
│                    │              │       │           │
│  ┌──────────────┐  │              │ ┌─────▼───────┐   │
│  │ Route Tables │◄─┼──────────────┼─┤ ENIs        │   │
│  │              │  │              │ └─────────────┘   │
│  └──────────────┘  │              │                   │
│                    │              │                   │
└────────────────────┘              └───────────────────┘
     │         ▲                           │    ▲
     │         │                           │    │
     │         └───────────────────────────┘    │
     │                                          │
     └──────────────────────────────────────────┘

```

The circular dependency existed because:
1. The security-vpc module needed the FortiGate ENI ID to create routes
2. The fgcp-ha module needed the security-vpc subnets to create the FortiGate instances
3. This created a circular reference that cannot be resolved by Terraform

## New Architecture (Dependency Resolved)

```
┌────────────────────┐              ┌───────────────────┐
│                    │              │                   │
│   security-vpc     │              │     fgcp-ha       │
│                    │              │                   │
│  ┌──────────────┐  │              │ ┌─────────────┐   │
│  │ Subnets      │──┼──────────────┼─► FortiGate   │   │
│  │              │  │              │ │ instances   │   │
│  └──────────────┘  │              │ └─────────────┘   │
│                    │              │       │           │
│  ┌──────────────┐  │              │ ┌─────▼───────┐   │
│  │ Route Tables │──┼──────────────┼─► ENIs        │   │
│  │ (creation    │  │              │ └─────┬───────┘   │
│  │  only)       │  │              │       │           │
│  └──────────────┘  │              │ ┌─────▼───────┐   │
│                    │              │ │ Routes      │   │
│                    │              │ │             │   │
│                    │              │ └─────────────┘   │
└────────────────────┘              └───────────────────┘
     │                                        │
     │                                        │
     └────────────────────────────────────────┘

```

The new architecture:
1. The security-vpc module creates subnets and route tables (but no routes)
2. The fgcp-ha module:
   - Uses subnet IDs to create FortiGate instances and ENIs
   - Creates routes that point to FortiGate ENIs, using route table IDs from the security-vpc module
3. The dependency flows in one direction, eliminating the circular reference

## Benefits of the New Architecture

1. Cleaner dependency chain between modules
2. Ability to use subnet CIDRs directly from the security-vpc module outputs
3. More logical separation of concerns: network infrastructure in security-vpc, FortiGate instances and routing in fgcp-ha
4. Improved maintainability and easier to understand resource creation flow
