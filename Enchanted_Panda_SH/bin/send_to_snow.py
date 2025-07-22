import csv
import json
import requests
import os
from datetime import datetime

# === CONFIG ===
SPLUNK_APP_PATH = "/opt/splunk/etc/apps/Enchanted_Panda"
LOOKUP_FILE = os.path.join(SPLUNK_APP_PATH, "lookups", "incident_details.csv")

SERVICENOW_INSTANCE = "your_instance"  # e.g., dev12345.service-now.com
USERNAME = "your_snow_user"
PASSWORD = "your_snow_password"
HEADERS = {"Content-Type": "application/json"}

# API Endpoint template
WORKNOTE_API = f"https://{SERVICENOW_INSTANCE}/api/now/table/incident/{{}}"

def send_worknote(row):
    sys_id = row.get("incident_sys_id")
    if not sys_id:
        print("Missing sys_id, skipping row.")
        return

    payload = {
        "work_notes": f"GPT Insight for {row['vm_name']}:\n{row['work_note']}\n\nSummary: {row['gpt_response_summary']}\nTimestamp: {datetime.utcnow().isoformat()}Z",
        "comments": "Auto-posted by Splunk-GPT workflow",
    }

    url = WORKNOTE_API.format(sys_id)
    try:
        response = requests.patch(url, auth=(USERNAME, PASSWORD), headers=HEADERS, data=json.dumps(payload))
        if response.status_code in [200, 204]:
            print(f"✅ Worknote added to Incident {sys_id}")
        else:
            print(f"❌ Failed to update Incident {sys_id}: {response.status_code} - {response.text}")
    except Exception as e:
        print(f"🔥 Error sending to ServiceNow: {e}")

def process_csv():
    with open(LOOKUP_FILE, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            send_worknote(row)

if __name__ == "__main__":
    process_csv()
