import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript.jsonl"

with open(log_path, 'r', encoding='utf-8') as f:
    steps = [json.loads(line) for line in f]

for step_idx in [73, 112, 122]:
    print(f"=== Step {step_idx} ===")
    # Print the step itself
    for s in steps:
        if s.get("step_index") == step_idx:
            print("Tool call args keys:", s.get("tool_calls", [{}])[0].get("args", {}).keys())
            
    # Print next 3 steps
    for s in steps:
        idx = s.get("step_index")
        if step_idx < idx <= step_idx + 4:
            print(f"  Step {idx} source={s.get('source')} type={s.get('type')}")
            print(f"  content: {repr(s.get('content', ''))[:150]}")
