import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    for i in range(50):
        line = f.readline()
        if not line:
            break
        data = json.loads(line)
        print(f"Index {data.get('step_index')}: source={data.get('source')} type={data.get('type')}")
