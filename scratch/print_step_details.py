import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            step_idx = data.get("step_index")
            if step_idx in [15, 16, 29, 30]:
                print(f"Step {step_idx}:")
                print("keys:", data.keys())
                print("content snippet:", repr(data.get("content", ""))[:200])
                print("-" * 50)
        except Exception as e:
            pass
