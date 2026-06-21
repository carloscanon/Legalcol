import json

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"
app_path = r"c:\Users\carlo\Desktop\LegalCol\src\App.vue"

with open(app_path, 'r', encoding='utf-8') as f:
    app_clean = f.read()

# Let's inspect step 1289
with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            data = json.loads(line)
            if data.get("step_index") == 1289:
                tc = data.get("tool_calls", [])[0]
                args = tc.get("args", {})
                target = args.get("TargetContent")
                print("TargetContent:")
                print(repr(target))
                print("Count in clean App.vue:", app_clean.count(target))
                
                # Check near matches (e.g. ignoring whitespace or newline differences)
                # Let's normalize both and compare
                norm_target = "".join(target.split())
                norm_app = "".join(app_clean.split())
                if norm_target in norm_app:
                    print("Normalized target is inside normalized clean App.vue!")
                else:
                    print("Normalized target NOT found in normalized clean App.vue!")
        except Exception as e:
            pass
