import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            content = data.get("content", "")
            step_idx = data.get("step_index")
            if "en la biblioteca esta colocando el video" in content:
                print(f"Found prompt at step {step_idx}:")
                print(content[:300])
        except Exception as e:
            pass
