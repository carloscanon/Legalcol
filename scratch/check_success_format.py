import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"

print("Printing tool responses:")
with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            source = data.get("source")
            type_val = data.get("type")
            if source == "SYSTEM" and type_val == "TOOL_RESPONSE":
                content = data.get("content", "")
                if "The following changes were made by" in content:
                    print(f"Step {data.get('step_index')}:")
                    print(content[:300])
                    print("-" * 50)
        except Exception as e:
            pass
