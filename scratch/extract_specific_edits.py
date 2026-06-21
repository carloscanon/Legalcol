import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            step_idx = data.get("step_index")
            if step_idx == 1610:
                print("================ STEP 1610 ================")
                tool_calls = data.get("tool_calls", [])
                for tc in tool_calls:
                    args = tc.get("args", {})
                    print("TargetContent:")
                    print(repr(args.get("TargetContent")))
                    print("ReplacementContent:")
                    print(args.get("ReplacementContent"))
        except:
            pass
