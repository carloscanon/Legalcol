import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"

steps = []
with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            steps.append(json.loads(line))
        except:
            pass

matched = []
for i, step in enumerate(steps):
    source = step.get("source")
    type_val = step.get("type")
    if source == "MODEL" and type_val == "PLANNER_RESPONSE":
        tool_calls = step.get("tool_calls", [])
        for tc in tool_calls:
            name = tc.get("name")
            args = tc.get("args", {})
            target = args.get("TargetFile")
            if target and "App.vue" in target:
                success = False
                for j in range(i+1, min(i+5, len(steps))):
                    next_step = steps[j]
                    if next_step.get("type") == "CODE_ACTION":
                        next_content = next_step.get("content", "")
                        if "changes were made" in next_content.lower() or "created file" in next_content.lower():
                            success = True
                            break
                matched.append((step.get("step_index"), name, success))

print("All matched edits for App.vue:")
for m in matched:
    print(m)
