import os

log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript.jsonl"
full_log_path = r"C:\Users\carlo\.gemini\antigravity\brain\f560b76c-ba1d-4309-8e4e-26eeffb81950\.system_generated\logs\transcript_full.jsonl"

print("transcript.jsonl size:", os.path.getsize(log_path))
print("transcript_full.jsonl size:", os.path.getsize(full_log_path))

with open(log_path, 'r', encoding='utf-8') as f:
    for i in range(5):
        line = f.readline()
        print(f"Line {i}: {repr(line[:100])}")
