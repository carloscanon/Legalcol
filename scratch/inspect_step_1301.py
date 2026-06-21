import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            if data.get("step_index") == 1301:
                tc = data.get("tool_calls", [])[0]
                args = tc.get("args", {})
                print("TargetContent:")
                print(repr(args.get("TargetContent")[:400]))
        except:
            pass
