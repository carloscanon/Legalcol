import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    count = 0
    for line in f:
        try:
            data = json.loads(line)
            source = data.get("source")
            type_val = data.get("type")
            if source == "SYSTEM" and type_val == "TOOL_RESPONSE":
                print(f"Step {data.get('step_index')}:")
                content = data.get("content", "")
                print(repr(content[:200]))
                print("=" * 60)
                count += 1
                if count >= 10:
                    break
        except Exception as e:
            pass
