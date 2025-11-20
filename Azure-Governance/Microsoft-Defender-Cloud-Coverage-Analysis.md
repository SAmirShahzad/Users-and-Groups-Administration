# Microsoft Defender for Cloud - Subscription Coverage Analysis

**Date**: November 13, 2025  
**Total Subscriptions Analyzed**: 17  
**Analysis Scope**: All Azure subscriptions in tenant

## 🛡️ **Microsoft Defender for Cloud Status Summary**

### **📊 Virtual Machines Defender Coverage**:
| Status | Count | Subscriptions |
|--------|-------|---------------|
| **✅ Standard (Paid)** | **11** | n01, p02, s01, c01, Azure-Subscription-CAO-Main-001-Adastra, Microsoft Azure, Azure-Sub-Pay-As-You-Go-Governance-Dev-Test-03, Azure-Sub-Pay-As-You-Go-DW-Dev-Test-01, Azure-Sub-Pay-As-You-Go-ODR-B2C-01, Azure-Sub-Pay-As-You-Go-DW-Dev-Test-02, Azure-Sub-Pay-As-You-Go-CatOs-Test1 |
| **🆓 Free Tier** | **6** | p01, n02, i01, m01, Subscription 2, Adastra-CSP-CAO-Dev/Test |

### **💾 Storage Accounts Defender Coverage**:
| Status | Count | Subscriptions |
|--------|-------|---------------|
| **✅ Standard (Paid)** | **8** | m01, Azure-Subscription-CAO-Main-001-Adastra, Microsoft Azure, Azure-Sub-Pay-As-You-Go-Governance-Dev-Test-03, Azure-Sub-Pay-As-You-Go-DW-Dev-Test-01, Azure-Sub-Pay-As-You-Go-DW-Dev-Test-02, Azure-Sub-Pay-As-You-Go-CatOs-Test1 |
| **🆓 Free Tier** | **9** | n01, p01, n02, p02, s01, c01, i01, Azure-Sub-Pay-As-You-Go-ODR-B2C-01, Subscription 2, Adastra-CSP-CAO-Dev/Test |

---

## 🎯 **Core Infrastructure Subscriptions Analysis**

### **Tag Governance Deployed Subscriptions (8 total)**:

| Subscription | VM Defender | Storage Defender | Security Status |
|-------------|-------------|------------------|-----------------|
| **s01** (Sandbox) | ✅ Standard | 🆓 Free | Partial Protection |
| **n01** (Network 01) | ✅ Standard | 🆓 Free | Partial Protection |
| **n02** (Network 02) | 🆓 Free | 🆓 Free | ⚠️ Basic Only |
| **i01** (Identity) | 🆓 Free | 🆓 Free | ⚠️ Basic Only |
| **c01** (Connectivity) | ✅ Standard | 🆓 Free | Partial Protection |
| **m01** (Management) | 🆓 Free | ✅ Standard | Partial Protection |
| **p01** (Production 01) | 🆓 Free | 🆓 Free | ⚠️ Basic Only |
| **p02** (Production 02) | ✅ Standard | 🆓 Free | Partial Protection |

### **⚠️ Critical Findings**:
- **Production Subscriptions**: p01 has only FREE tier protection
- **Identity Infrastructure**: i01 has only FREE tier protection
- **Mixed Coverage**: Inconsistent Defender deployment across core infrastructure

---

## 📈 **Coverage Statistics**

### **Overall Coverage**:
- **VM Defender Standard**: 11/17 subscriptions (**64.7% coverage**)
- **Storage Defender Standard**: 8/17 subscriptions (**47.1% coverage**)
- **Full Protection** (Both VM & Storage Standard): 8/17 subscriptions (**47.1% coverage**)

### **Core Infrastructure Coverage** (8 subscriptions):
- **VM Defender Standard**: 4/8 subscriptions (**50% coverage**)
- **Storage Defender Standard**: 1/8 subscriptions (**12.5% coverage**)
- **No Protection** (Both Free): 3/8 subscriptions (**37.5% - RISK**)

---

## 💰 **Cost Analysis**

### **Current Defender for Cloud Costs**:
- **VM Defender Standard**: 11 subscriptions generating costs
- **Storage Defender Standard**: 8 subscriptions generating costs
- **Total Protected Services**: 19 service types across all subscriptions

### **Free Tier Limitations**:
- **Basic Security Recommendations** only
- **No Advanced Threat Protection**
- **No Just-In-Time VM Access** (JIT)
- **No File Integrity Monitoring**
- **No Adaptive Application Controls**

---

## 🔍 **Security Gaps Identified**

### **🚨 High-Risk Subscriptions** (Free Tier Only):
1. **n02** (Network 02) - Critical network infrastructure
2. **i01** (Identity) - Identity management infrastructure  
3. **p01** (Production 01) - Primary production environment

### **🟡 Medium-Risk Subscriptions** (Partial Protection):
1. **s01** (Sandbox) - VM protected, storage not
2. **n01** (Network 01) - VM protected, storage not
3. **c01** (Connectivity) - VM protected, storage not
4. **m01** (Management) - Storage protected, VM not
5. **p02** (Production 02) - VM protected, storage not

---

## 🎯 **Recommendations**

### **Immediate Actions** (High Priority):
1. **Enable VM Defender Standard** on:
   - p01 (Production 01) - **CRITICAL**
   - i01 (Identity) - **CRITICAL** 
   - n02 (Network 02) - **HIGH**
   - m01 (Management) - **HIGH**

2. **Enable Storage Defender Standard** on production subscriptions:
   - p01, p02 (Both production environments)

### **Strategic Improvements**:
1. **Standardize Protection**: Deploy both VM and Storage Defender on all core infrastructure
2. **Cost Optimization**: Evaluate necessity of Defender on dev/test subscriptions
3. **Policy Enforcement**: Create Azure Policy to enforce Defender deployment
4. **Monitoring**: Set up alerts for Defender status changes

---

## 📋 **Detailed Subscription Matrix**

| Subscription Name | Type | VM Defender | Storage Defender | Recommendation |
|------------------|------|-------------|------------------|----------------|
| s01 | Sandbox | Standard ✅ | Free 🆓 | Enable Storage |
| n01 | Network | Standard ✅ | Free 🆓 | Enable Storage |
| n02 | Network | Free 🆓 | Free 🆓 | **Enable Both** |
| i01 | Identity | Free 🆓 | Free 🆓 | **Enable Both** |
| c01 | Connectivity | Standard ✅ | Free 🆓 | Enable Storage |
| m01 | Management | Free 🆓 | Standard ✅ | Enable VM |
| p01 | Production | Free 🆓 | Free 🆓 | **Enable Both - CRITICAL** |
| p02 | Production | Standard ✅ | Free 🆓 | Enable Storage |
| Azure-Subscription-CAO-Main-001-Adastra | Main | Standard ✅ | Standard ✅ | ✅ Fully Protected |
| Microsoft Azure | Default | Standard ✅ | Standard ✅ | ✅ Fully Protected |
| Azure-Sub-Pay-As-You-Go-Governance-Dev-Test-03 | Dev/Test | Standard ✅ | Standard ✅ | ✅ Fully Protected |
| Azure-Sub-Pay-As-You-Go-DW-Dev-Test-01 | Dev/Test | Standard ✅ | Standard ✅ | ✅ Fully Protected |
| Azure-Sub-Pay-As-You-Go-ODR-B2C-01 | B2C | Standard ✅ | Free 🆓 | Consider Storage |
| Azure-Sub-Pay-As-You-Go-DW-Dev-Test-02 | Dev/Test | Standard ✅ | Standard ✅ | ✅ Fully Protected |
| Azure-Sub-Pay-As-You-Go-CatOs-Test1 | Test | Standard ✅ | Standard ✅ | ✅ Fully Protected |
| Subscription 2 | Unknown | Free 🆓 | Free 🆓 | Evaluate Need |
| Adastra-CSP-CAO-Dev/Test | Dev/Test | Free 🆓 | Free 🆓 | Evaluate Need |

---

## 🚨 **Critical Security Alert**

**PRODUCTION ENVIRONMENT AT RISK**: 
- **p01 (Production 01)** has NO advanced security protection
- **i01 (Identity)** infrastructure lacks threat protection
- **3 out of 8 core subscriptions** have minimal security coverage

**Immediate action required to secure production workloads and identity infrastructure.**

---

*This analysis shows that while Microsoft Defender for Cloud is enabled on most subscriptions (11/17 for VMs), there are significant gaps in production and core infrastructure protection that need immediate attention.*