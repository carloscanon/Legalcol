import os

app_path = r"c:\Users\carlo\Desktop\LegalCol\src\App.vue"

with open(app_path, 'r', encoding='utf-8') as f:
    content = f.read()

target = """                <!-- Google Style Result Card -->
                <div 
                  v-for="norm in filteredNorms" 
                  :key="norm.id" 
                  class="google-result-card"
                >
                  <!-- Breadcrumb and metadata -->
                  <div class="google-result-breadcrumb">
                    <span>https://legalcol.consultanormativa.com</span>
                    <i data-lucide="chevron-right"></i>
                    <span>{{ norm.type.toLowerCase() }}s</span>
                    <i data-lucide="chevron-right"></i>
                    <span>{{ norm.id }}</span>
                  </div>

                  <!-- Google Blue Hyperlink Header -->
                  <h3 class="google-result-title" @click="viewNormDetails(norm)">
                    {{ norm.fullName }} (Vigencia: {{ norm.status }})
                  </h3>

                  <!-- Snippet / Description text -->
                  <p class="google-result-snippet">
                    <span class="google-result-date">{{ norm.date }} — </span>
                    {{ norm.summary }}
                  </p>

                  <!-- Actions / Cache simulator -->
                  <div class="google-result-actions mt-4 flex gap-16 text-xs">
                    <span class="google-action-link" @click="viewNormDetails(norm)">Ver Resumen IA</span>
                    <span class="google-action-link" @click="simulatePDFDownload(norm)">Descargar PDF</span>
                    <span class="google-action-link" @click="openAIConversationForNorm(norm)">Preguntar a IA</span>
                  </div>
                </div>"""

replacement = """                <!-- Google Style Result Card (Video on Left, Info on Right) -->
                <div 
                  v-for="norm in filteredNorms" 
                  :key="norm.id" 
                  class="google-result-card"
                  style="display: flex; flex-direction: row; gap: 20px; align-items: flex-start; padding: 16px; background: var(--bg-secondary); border: 1px solid var(--border-color); border-radius: 8px;"
                >
                  <!-- Video Area on the Left -->
                  <div class="result-video-left" style="flex-shrink: 0; width: 180px; position: relative;">
                    <div 
                      class="youtube-video-container" 
                      style="border-radius: 6px; overflow: hidden; box-shadow: var(--shadow-sm); padding-bottom: 56.25%; position: relative; height: 0; width: 100%; cursor: pointer;"
                      @click="selectedVideo = youtubeVideosData.find(v => v.id === norm.relatedVideoId) || youtubeVideosData[0] || { embedUrl: 'https://www.youtube.com/embed/dQw4w9WgXcQ', title: norm.fullName }"
                    >
                      <img 
                        :src="youtubeVideosData.find(v => v.id === norm.relatedVideoId) ? youtubeVideosData.find(v => v.id === norm.relatedVideoId).thumbnail : (youtubeVideosData[0] ? youtubeVideosData[0].thumbnail : 'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?q=80&w=400&auto=format&fit=crop')" 
                        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;" 
                        alt="Miniatura del Video"
                      />
                      <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.25); display: flex; align-items: center; justify-content: center;">
                        <i data-lucide="play-circle" style="color: white; width: 36px; height: 36px;"></i>
                      </div>
                    </div>
                    <div class="text-center mt-6" style="font-size: 0.7rem; color: var(--text-muted); font-weight: bold; text-transform: uppercase;">
                      <span>{{ youtubeVideosData.find(v => v.id === norm.relatedVideoId) ? 'Video de la Norma' : 'Ver Video General' }}</span>
                    </div>
                  </div>

                  <!-- Text Details Area on the Right -->
                  <div class="result-details-right" style="flex-grow: 1; min-width: 0;">
                    <!-- Breadcrumb and metadata -->
                    <div class="google-result-breadcrumb">
                      <span>https://legalcol.consultanormativa.com</span>
                      <i data-lucide="chevron-right"></i>
                      <span>{{ norm.type.toLowerCase() }}s</span>
                      <i data-lucide="chevron-right"></i>
                      <span>{{ norm.id }}</span>
                    </div>

                    <!-- Google Blue Hyperlink Header -->
                    <h3 class="google-result-title" @click="viewNormDetails(norm)" style="margin-top: 4px;">
                      {{ norm.fullName }} (Vigencia: {{ norm.status }})
                    </h3>

                    <!-- Snippet / Description text -->
                    <p class="google-result-snippet" style="margin-top: 4px;">
                      <span class="google-result-date">{{ norm.date }} — </span>
                      {{ norm.summary }}
                    </p>

                    <!-- Actions / Cache simulator -->
                    <div class="google-result-actions mt-12 flex gap-16 text-xs">
                      <span class="google-action-link" @click="viewNormDetails(norm)">Ver Resumen IA</span>
                      <span class="google-action-link" @click="simulatePDFDownload(norm)">Descargar PDF</span>
                      <span class="google-action-link" @click="openAIConversationForNorm(norm)">Preguntar a IA</span>
                    </div>
                  </div>
                </div>"""

# Normalize target newlines to match the file
target_lf = target.replace("\r\n", "\n")
target_crlf = target.replace("\n", "\r\n")

if target_lf in content:
    content = content.replace(target_lf, replacement)
    print("Replaced successfully (LF)!")
elif target_crlf in content:
    content = content.replace(target_crlf, replacement)
    print("Replaced successfully (CRLF)!")
else:
    print("TargetContent NOT found!")
    # Check normalized match
    norm_tg = "".join(target_lf.split())
    norm_content = "".join(content.split())
    if norm_tg in norm_content:
        print("Normalized match is present! Indentation or spacing is slightly different.")
        # Let's perform a regular expression or replace ignoring spacing if possible,
        # or show where it starts.
        import re
        pattern = re.escape(target_lf).replace(r"\ ", r"\s+").replace(r"\n", r"\s+")
        content, count = re.subn(pattern, replacement, content)
        print(f"Replaced via regex: {count} times")

with open(app_path, 'w', encoding='utf-8') as f:
    f.write(content)
