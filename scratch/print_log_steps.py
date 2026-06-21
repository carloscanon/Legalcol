import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript.jsonl"

steps_summary = []
with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            step_idx = data.get("step_index")
            source = data.get("source")
            type_val = data.get("type")
            steps_summary.append((step_idx, source, type_val))
        except Exception as e:
            pass

print("Total steps in transcript.jsonl:", len(steps_summary))
print("First 10 steps:")
for s in steps_summary[:10]:
    print(s)
print("\nLast 15 steps:")
for s in steps_summary[-15:]:
    print(s)
