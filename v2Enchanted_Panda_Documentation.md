# 📘 Enchanted_Panda: GPT-to-ServiceNow Integration for Splunk

## 🧩 Problem Statement

In modern IT environments, monitoring infrastructure performance is critical — but transforming logs and metrics into meaningful insights often requires manual triage and documentation. This leads to:

- **Operational delays** in root cause analysis
- **Missed opportunities** to automate incident enrichment
- **Overhead** in writing consistent work notes in ITSM tools like ServiceNow

## 🎯 Target Users

This app is designed for:

- **Site Reliability Engineers (SREs)** and **Infra Ops teams**
- **Splunk Admins** looking to enrich incident records with AI-generated context
- **ServiceNow-integrated environments** that need real-time, intelligent worknote generation

## 🧠 What the App Does

Enchanted_Panda enables Splunk to:

- Collect **VM-level stats** (CPU, memory, metadata) via scheduled scripts
- Push data into Splunk indexes (`vm_stats`, `infra_insights`)
- Generate AI-based summaries from that data (via GPT or other LLM tools)
- Read insights from a lookup (`incident_details.csv`)
- Automatically post them to ServiceNow incident records as **GPT-authored work notes**

## 🔗 Integration with Splunk

| Component                 | Purpose                                                        |
|--------------------------|----------------------------------------------------------------|
| **Python Script**        | Posts GPT-generated insights to ServiceNow work notes          |
| **Splunk Lookups**       | Acts as input source with `incident_sys_id`, `vm_name`, etc.   |
| **Indexes**              | `vm_stats`, `infra_insights` for raw data and GPT output       |
| **Scheduled Searches**   | Trigger alerts or run at intervals to automate workflow         |
| **Alert Action (optional)** | Bind to searches and send context directly to the script       |

> All insights are seamlessly mapped to their respective ServiceNow incidents using `sys_id`.

## 🚀 Benefits

✅ **Automation** of routine ITSM updates  
✅ **Consistency** in insight delivery  
✅ **Reduction** in manual documentation  
✅ **Accelerated** incident triage with AI-powered summaries  
✅ **Plug-and-play** into Splunk with minimal configuration  

## 📌 Deployment Footprint

- Compatible with Splunk Enterprise or Splunk Cloud (Heavy Forwarder or SH)
- Requires Python 3.x (`requests` module only)
- ServiceNow API account with `incident` write access
- App files include configs, lookup CSV, and self-contained Python script

## 📞 Contact

For setup help or customizations, contact: `ayush`
