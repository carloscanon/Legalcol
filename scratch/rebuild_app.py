import json
import os

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"
app_path = r"c:\Users\carlo\Desktop\LegalCol\src\App.vue"

# Read all steps in order
steps = []
with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        try:
            steps.append(json.loads(line))
        except:
            pass

print(f"Loaded {len(steps)} steps.")

successful_edits = []
start_content = None

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
                if name == "write_to_file":
                    # Check if write_to_file succeeded
                    success = False
                    for j in range(i+1, min(i+5, len(steps))):
                        next_step = steps[j]
                        if next_step.get("type") == "CODE_ACTION":
                            next_content = next_step.get("content", "")
                            if "created file" in next_content.lower() or "changes were made" in next_content.lower():
                                success = True
                                break
                    if success:
                        start_content = args.get("CodeContent")
                        print(f"Found successful write_to_file at step {step.get('step_index')}, start content length: {len(start_content)}")
                
                elif name in ["replace_file_content", "multi_replace_file_content"]:
                    success = False
                    for j in range(i+1, min(i+5, len(steps))):
                        next_step = steps[j]
                        if next_step.get("type") == "CODE_ACTION":
                            next_content = next_step.get("content", "")
                            if "changes were made" in next_content.lower() or "created file" in next_content.lower():
                                success = True
                                break
                            elif "error" in next_content.lower() or "failed" in next_content.lower():
                                break
                    
                    if success:
                        successful_edits.append({
                            "step_index": step.get("step_index"),
                            "name": name,
                            "args": args
                        })

if start_content is None:
    print("WARNING: No write_to_file found! Falling back to disk content.")
    with open(app_path, 'r', encoding='utf-8') as f:
        current_content = f.read()
else:
    current_content = start_content

print(f"Found {len(successful_edits)} successful edits to App.vue in total history.")

# Apply them chronologically
for edit in successful_edits:
    step = edit["step_index"]
    name = edit["name"]
    args = edit["args"]
    print(f"\n--- Applying Step {step} ({name}) ---")
    print("Description:", args.get("Description"))
    
    if name == "replace_file_content":
        target = args["TargetContent"]
        replacement = args["ReplacementContent"]
        
        count = current_content.count(target)
        if count == 0:
            print(f"WARNING: TargetContent not found! Step {step} skipped.")
            continue
        elif count > 1 and not args.get("AllowMultiple"):
            # If target count > 1, let's see if we can do a single replace or skip
            print(f"WARNING: TargetContent found {count} times and AllowMultiple is False! Step {step} skipped.")
            continue
        
        current_content = current_content.replace(target, replacement)
        print("Success! Content length now:", len(current_content))
        
    elif name == "multi_replace_file_content":
        chunks = args.get("ReplacementChunks", [])
        print(f"Processing {len(chunks)} chunks...")
        failed_chunk = False
        temp_content = current_content
        for chunk in chunks:
            tg = chunk["TargetContent"]
            rep = chunk["ReplacementContent"]
            c = temp_content.count(tg)
            if c == 0:
                print(f"WARNING: Chunk TargetContent not found!")
                failed_chunk = True
                break
            elif c > 1 and not chunk.get("AllowMultiple"):
                print(f"WARNING: Chunk TargetContent found {c} times and AllowMultiple is False!")
                failed_chunk = True
                break
            temp_content = temp_content.replace(tg, rep)
            
        if not failed_chunk:
            current_content = temp_content
            print("Multi-replace Success! Content length now:", len(current_content))
        else:
            print(f"WARNING: Multi-replace failed for Step {step}!")

# Write the final rebuilt content to App.vue
with open(app_path, 'w', encoding='utf-8') as f:
    f.write(current_content)
print("\nRebuilt App.vue successfully written! Length:", len(current_content))
