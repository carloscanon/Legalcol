<template>
  <div class="app-layout">
    <!-- TOP NAVIGATION BAR -->
    <header class="header">
      <div class="container header-container">
        <div class="logo-row" style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
          <div class="logo" @click="currentTab = 'home'; mobileMenuOpen = false" style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
            <img :src="logoUrl" :style="{ width: logoWidth + 'px', height: 'auto', borderRadius: '4px' }" class="company-logo" alt="LegalCol Logo" />
          </div>
          <!-- Hamburger button for mobile devices -->
          <button class="mobile-menu-toggle" @click="mobileMenuOpen = !mobileMenuOpen" aria-label="Toggle Menu" style="background: none; border: none; font-size: 1.5rem; color: var(--text-primary); cursor: pointer; display: none;">
            <span v-if="!mobileMenuOpen">☰</span>
            <span v-else>✕</span>
          </button>
        </div>

        <nav class="nav-links" :class="{ 'nav-links-mobile-open': mobileMenuOpen }">
          <a href="#" :class="{ active: currentTab === 'home' }" @click.prevent="currentTab = 'home'; mobileMenuOpen = false">
            <i data-lucide="home"></i> Inicio
          </a>
          <a href="#" :class="{ active: currentTab === 'library' }" @click.prevent="currentTab = 'library'; mobileMenuOpen = false">
            <i data-lucide="book-open"></i> Biblioteca
          </a>
          <a href="#" :class="{ active: currentTab === 'youtube' }" @click.prevent="currentTab = 'youtube'; mobileMenuOpen = false">
            <i data-lucide="youtube" class="text-danger"></i> LegalCol TV
          </a>
          <a href="#" :class="{ active: currentTab === 'ia' }" @click.prevent="currentTab = 'ia'; mobileMenuOpen = false">
            <i data-lucide="sparkles"></i> Asistente IA
          </a>
          <a href="#" :class="{ active: currentTab === 'marketplace' }" @click.prevent="currentTab = 'marketplace'; mobileMenuOpen = false">
            <i data-lucide="users"></i> Expertos & Servicios
          </a>
          <a href="#" :class="{ active: currentTab === 'academy' }" @click.prevent="currentTab = 'academy'; mobileMenuOpen = false">
            <i data-lucide="graduation-cap"></i> Academia
          </a>
          <a href="#" :class="{ active: currentTab === 'memberships' }" @click.prevent="currentTab = 'memberships'; mobileMenuOpen = false">
            <i data-lucide="credit-card"></i> Membresías
          </a>
        </nav>

        <div class="header-actions" :class="{ 'header-actions-mobile-open': mobileMenuOpen }">
          <!-- Auth Trigger / Profile Indicator -->
          <div v-if="currentUserSession" class="flex align-center gap-8">
            <div class="user-avatar-pill" @click="currentTab = 'admin'; mobileMenuOpen = false" title="Panel Administrativo">
              <div class="user-avatar-circle">
                {{ currentUserSession.profile.full_name ? currentUserSession.profile.full_name.charAt(0).toUpperCase() : 'U' }}
              </div>
              <span class="user-avatar-name">{{ currentUserSession.profile.full_name }}</span>
            </div>
            <button class="btn btn-xs btn-outline" @click="handleLogout(); mobileMenuOpen = false" title="Cerrar Sesión" style="padding: 6px;">
              <i data-lucide="log-out" style="width: 14px; height: 14px;"></i>
            </button>
          </div>
          <button v-else class="btn btn-xs btn-outline" @click="showAuthModal = true; mobileMenuOpen = false" style="padding: 6px 12px; font-size: 0.8rem;">
            <i data-lucide="user" style="width: 14px; height: 14px;"></i> Ingresar
          </button>

          <div class="cart-btn" @click="currentTab = 'marketplace'; mobileMenuOpen = false">
            <i data-lucide="shopping-cart"></i>
            <span class="cart-badge" v-if="cart.length > 0">{{ cart.length }}</span>
          </div>
          <button class="btn btn-primary" @click="openConsultancyModal(); mobileMenuOpen = false">
            <i data-lucide="phone-call"></i> Asesoría
          </button>
        </div>
      </div>
    </header>

    <!-- MAIN BODY -->
    <main class="main-content">
      
      <!-- ================== 1. TAB: HOME ================== -->
      <section v-if="currentTab === 'home'" class="tab-panel animate-fade">
        <!-- Hero Section: Spectacular, high-end styling with Nike/Stripe curves -->
        <div class="hero-spectacular">
          <div class="hero-bg-shapes">
            <div class="shape-glow shape-1"></div>
            <div class="shape-glow shape-2"></div>
            <div class="shape-clip-bg"></div>
          </div>
          
          <div class="container hero-inner">
            <!-- Welcome Banner / Comando Center (Only for Authenticated Users) -->
            <div v-if="currentUserSession" class="command-welcome-box mb-32 p-24 border rounded" style="background: var(--bg-secondary); border: 1px solid var(--border-color); border-radius: var(--radius-md); box-shadow: var(--shadow-sm); margin-bottom: 32px;">
              <div class="flex justify-between align-center flex-wrap gap-16">
                <div>
                  <h2 style="font-size: 1.6rem; color: var(--text-primary); font-family: var(--font-sans); font-weight: 700;">
                    Buenos días, {{ currentUserSession.profile.full_name }}
                  </h2>
                  <p class="text-secondary mt-4" style="font-size: 0.95rem; color: var(--text-secondary);">
                    Centro de Comando Legal Inteligente. Tienes <strong class="text-danger" style="color: var(--color-danger);">3 cambios normativos pendientes</strong> por revisar y <strong>2 obligaciones</strong> que vencen esta semana.
                  </p>
                </div>
                <div class="flex gap-12">
                  <div class="badge-status vigente" style="padding: 6px 12px; font-size: 0.8rem; border-radius: var(--radius-sm); font-weight: bold; background: rgba(52,168,83,0.1); color: var(--color-success); border: 1px solid rgba(52,168,83,0.2);">
                    <i data-lucide="shield-check" style="color: var(--color-success); width:16px; height:16px;"></i>
                    <span>Gemelo Digital Activo: 47 obligaciones</span>
                  </div>
                </div>
              </div>

              <!-- Quick Widgets Grid (PowerBI Dashboard Tiles style) -->
              <div class="grid mt-24" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px;">
                <!-- Widget 1: Ultimas Busquedas (PowerBI Tile) -->
                <div class="powerbi-tile bg-primary" style="background: var(--bg-primary); border-radius: 4px; border: 1px solid var(--border-color); border-left: 5px solid #4285f4; box-shadow: 0 2px 4px rgba(0,0,0,0.02); display: flex; flex-direction: column; justify-content: space-between; min-height: 110px; padding: 16px 16px 16px 20px;">
                  <div>
                    <span class="text-muted block" style="font-size: 0.75rem; text-transform: uppercase; font-weight: bold; letter-spacing: 0.5px; color: var(--text-muted);">Historial de Consultas</span>
                    <h4 style="font-size: 1.3rem; font-weight: 800; color: var(--text-primary); margin-top: 4px; margin-bottom: 8px;">3 Búsquedas</h4>
                  </div>
                  <div class="flex flex-column gap-4" style="display: flex; flex-direction: column; gap: 4px; border-top: 1px solid var(--border-color); padding-top: 6px;">
                    <a href="#" @click.prevent="searchQuery = 'ley 1581'; triggerQuickSearch()" class="text-xs text-accent font-bold" style="color: #4285f4; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 190px; display: block;">• ley 1581</a>
                    <a href="#" @click.prevent="searchQuery = 'Habeas Data'; triggerQuickSearch()" class="text-xs text-accent font-bold" style="color: #4285f4; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 190px; display: block;">• Habeas Data</a>
                  </div>
                </div>

                <!-- Widget 2: Normas Consultadas (PowerBI Tile) -->
                <div class="powerbi-tile bg-primary" style="background: var(--bg-primary); border-radius: 4px; border: 1px solid var(--border-color); border-left: 5px solid #a855f7; box-shadow: 0 2px 4px rgba(0,0,0,0.02); display: flex; flex-direction: column; justify-content: space-between; min-height: 110px; padding: 16px 16px 16px 20px;">
                  <div>
                    <span class="text-muted block" style="font-size: 0.75rem; text-transform: uppercase; font-weight: bold; letter-spacing: 0.5px; color: var(--text-muted);">Normas Consultadas</span>
                    <h4 style="font-size: 1.3rem; font-weight: 800; color: var(--text-primary); margin-top: 4px; margin-bottom: 8px;">2 Leyes</h4>
                  </div>
                  <div class="flex flex-column gap-4" style="display: flex; flex-direction: column; gap: 4px; border-top: 1px solid var(--border-color); padding-top: 6px;">
                    <a href="#" @click.prevent="viewNormDetails(normsData[0])" class="text-xs text-primary font-bold" style="color: var(--text-primary); overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 190px; display: block;">• Ley 1581 de 2012</a>
                    <a href="#" @click.prevent="viewNormDetails(normsData[1])" class="text-xs text-primary font-bold" style="color: var(--text-primary); overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 190px; display: block;">• Decreto 1377 de 2013</a>
                  </div>
                </div>

                <!-- Widget 3: Mis Favoritos (PowerBI Tile) -->
                <div class="powerbi-tile bg-primary" style="background: var(--bg-primary); border-radius: 4px; border: 1px solid var(--border-color); border-left: 5px solid #ef4444; box-shadow: 0 2px 4px rgba(0,0,0,0.02); display: flex; flex-direction: column; justify-content: space-between; min-height: 110px; padding: 16px 16px 16px 20px;">
                  <div>
                    <span class="text-muted block" style="font-size: 0.75rem; text-transform: uppercase; font-weight: bold; letter-spacing: 0.5px; color: var(--text-muted);">Biblioteca Guardada</span>
                    <h4 style="font-size: 1.3rem; font-weight: 800; color: var(--text-primary); margin-top: 4px; margin-bottom: 8px;">{{ favorites.length }} Favoritos</h4>
                  </div>
                  <div class="flex flex-column gap-4" style="display: flex; flex-direction: column; gap: 4px; border-top: 1px solid var(--border-color); padding-top: 6px;">
                    <div v-if="favorites.length === 0" class="text-xs text-muted">Ningún favorito guardado</div>
                    <a v-else v-for="favId in favorites.slice(0, 2)" :key="favId" href="#" @click.prevent="viewNormDetails(normsData.find(n => n.id === favId))" class="text-xs text-primary font-bold" style="color: var(--text-primary); overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 190px; display: block;">
                      • {{ favId }}
                    </a>
                  </div>
                </div>

                <!-- Widget 4: Alertas Activas (PowerBI Tile) -->
                <div class="powerbi-tile bg-primary" style="background: var(--bg-primary); border-radius: 4px; border: 1px solid var(--border-color); border-left: 5px solid #eab308; box-shadow: 0 2px 4px rgba(0,0,0,0.02); display: flex; flex-direction: column; justify-content: space-between; min-height: 110px; padding: 16px 16px 16px 20px;">
                  <div>
                    <span class="text-muted block" style="font-size: 0.75rem; text-transform: uppercase; font-weight: bold; letter-spacing: 0.5px; color: var(--text-muted);">Alertas del Sistema</span>
                    <h4 style="font-size: 1.3rem; font-weight: 800; color: var(--text-primary); margin-top: 4px; margin-bottom: 8px;">2 Críticas</h4>
                  </div>
                  <div class="flex flex-column gap-4" style="display: flex; flex-direction: column; gap: 4px; border-top: 1px solid var(--border-color); padding-top: 6px;">
                    <span class="text-xs text-danger font-bold flex align-center gap-4" style="color: #ef4444; font-size: 0.72rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 190px; display: block;">
                      <span class="pulse-dot" style="display: inline-block; width: 6px; height: 6px; background: #ef4444; border-radius: 50%;"></span> Regulación IA (Nueva)
                    </span>
                    <span class="text-xs text-warning font-bold flex align-center gap-4" style="color: #eab308; font-size: 0.72rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 190px; display: block;">
                      <span class="pulse-dot" style="display: inline-block; width: 6px; height: 6px; background: #eab308; border-radius: 50%;"></span> Cambios Ciberderecho
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="hero-grid-split">
              <!-- Left side: Text & Search -->
              <div class="hero-left-col">
                <div class="badge-premium-pill">
                  <span class="pulse-dot"></span>
                  <span>{{ homeHeroBadge }}</span>
                </div>
                
                <h1 class="hero-headline" v-html="homeHeroTitle">
                </h1>
                
                <p class="hero-subheadline">
                  {{ homeHeroSubtitle }}
                </p>

                <!-- Spectacular search bar -->
                <div class="search-bar-spectacular" :style="{ maxWidth: homeSearchWidth }">
                  <div class="search-input-wrapper">
                    <i data-lucide="search" class="search-icon-spec"></i>
                    <input 
                      type="text" 
                      placeholder="Buscar por ley, decreto, resolución o palabra clave..." 
                      v-model="searchQuery"
                      @keyup.enter="triggerQuickSearch"
                    />
                  </div>
                  <button class="btn-search-spec" @click="triggerQuickSearch">
                    <span>Buscar Ahora</span>
                    <i data-lucide="arrow-right"></i>
                  </button>
                </div>

                <!-- Analizador de Contratos con IA -->
                <div class="hero-contract-analyzer mt-24 animate-slide-up" style="background: rgba(255, 255, 255, 0.03); border: 1px dashed rgba(255, 255, 255, 0.15); border-radius: 12px; padding: 16px; display: flex; align-items: center; justify-content: space-between; gap: 16px; backdrop-filter: blur(10px); transition: border-color 0.3s, background 0.3s; margin-top: 24px; margin-bottom: 24px;" onmouseover="this.style.borderColor='var(--color-accent)'; this.style.background='rgba(255, 255, 255, 0.05)'" onmouseout="this.style.borderColor='rgba(255, 255, 255, 0.15)'; this.style.background='rgba(255, 255, 255, 0.03)'">
                  <div style="display: flex; align-items: center; gap: 12px; text-align: left;">
                    <div style="background: rgba(139, 92, 246, 0.15); color: #8b5cf6; width: 42px; height: 42px; border-radius: 10px; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                      <i data-lucide="file-text" style="width: 20px; height: 20px;"></i>
                    </div>
                    <div>
                      <h4 style="margin: 0; font-size: 0.9rem; font-weight: 700; color: var(--text-primary);">¿Analizar un Contrato con IA?</h4>
                      <p style="margin: 4px 0 0 0; font-size: 0.75rem; color: var(--text-secondary);">Suba su archivo (PDF, Word o TXT) para identificar riesgos y cláusulas críticas al instante.</p>
                    </div>
                  </div>
                  <label class="btn btn-sm btn-primary" style="cursor: pointer; display: inline-flex; align-items: center; gap: 6px; white-space: nowrap; margin: 0;">
                    <i data-lucide="upload" style="width: 14px; height: 14px;"></i> Subir Contrato
                    <input type="file" accept=".pdf,.doc,.docx,.txt" @change="simulateContractAnalysis" style="display: none;" />
                  </label>
                </div>

                <div class="hero-stats-row">
                  <div class="hero-stat-item">
                    <h3>{{ homeStat1Value }}</h3>
                    <span>{{ homeStat1Label }}</span>
                  </div>
                  <div class="hero-stat-item">
                    <h3>{{ homeStat2Value }}</h3>
                    <span>{{ homeStat2Label }}</span>
                  </div>
                  <div class="hero-stat-item">
                    <h3>{{ homeStat3Value }}</h3>
                    <span>{{ homeStat3Label }}</span>
                  </div>
                </div>
              </div>

              <!-- Right side: Interactive Widget Preview -->
              <div class="hero-right-col">
                <!-- Video Destacado del Canal (Mayor Tamaño) -->
                <div class="hero-glass-card hover-lift hero-video-card" :style="{ width: '100%', maxWidth: homeFeaturedVideoWidth + 'px', marginBottom: '24px' }">
                  <div class="card-glass-header mb-8" style="margin-bottom: 8px;">
                    <div class="flex align-center gap-8">
                      <i data-lucide="youtube" class="text-danger" style="width:16px; height:16px;"></i>
                      <span class="text-xs uppercase tracking font-bold">Video Destacado LegalCol TV</span>
                    </div>
                    <span class="badge-status vigente" style="padding: 2px 6px; font-size: 0.65rem;">Educativo</span>
                  </div>
                  <div class="youtube-video-container" style="border-radius: 8px; overflow: hidden; box-shadow: var(--shadow-sm); padding-bottom: 56.25%; position: relative; height: 0; width: 100%;">
                    <iframe 
                      :src="homeFeaturedVideoId ? ('https://www.youtube.com/embed/' + homeFeaturedVideoId) : (youtubeVideosData[0] ? youtubeVideosData[0].embedUrl : 'https://www.youtube.com/embed/dQw4w9WgXcQ')" 
                      :title="homeFeaturedVideoId ? 'Video Destacado Custom' : (youtubeVideosData[0] ? youtubeVideosData[0].title : 'Video Destacado')"
                      frameborder="0" 
                      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                      allowfullscreen
                      style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
                    ></iframe>
                  </div>
                  <h4 class="mt-8 text-sm font-bold" style="color: var(--text-primary); line-height: 1.3; margin-top: 8px;">
                    {{ homeFeaturedVideoId ? (youtubeVideosData.find(v => v.id === homeFeaturedVideoId)?.title || 'Video Personalizado') : (youtubeVideosData[0] ? youtubeVideosData[0].title : 'Cumplimiento de la Ley 1581 en Colombia') }}
                  </h4>
                </div>

                <!-- Actualización en Vivo (Moved Down) -->
                <div class="hero-glass-card hover-lift">
                  <div class="card-glass-header">
                    <div class="flex align-center gap-8">
                      <div class="pill-red-dot"></div>
                      <span class="text-xs uppercase tracking">Actualización en Vivo</span>
                    </div>
                    <span class="text-xs text-muted">Hace 5 min</span>
                  </div>
                  
                  <div class="card-glass-body mt-12">
                    <span class="norm-type-badge">LEY RECIENTE</span>
                    <h3 class="mt-8 text-md font-bold">Ley 1581 de Protección de Datos</h3>
                    <p class="text-secondary text-xs mt-8">Marco legal que garantiza el derecho de los ciudadanos a conocer, actualizar y rectificar información sensible en bases de datos.</p>
                  </div>
                  
                  <div class="card-glass-footer mt-16 pt-12 border-top flex justify-between align-center">
                    <button class="btn btn-xs btn-outline bg-blue-light text-blue" @click="currentTab = 'library'">
                      Leer Documento
                    </button>
                    <button class="btn btn-xs btn-primary" @click="currentTab = 'ia'">
                      Preguntar a IA
                    </button>
                  </div>
                </div>

                <!-- Asistente Jurídico IA -->
                <div class="hero-glass-card hover-lift secondary-card">
                  <div class="flex align-center gap-12">
                    <div class="badge-icon-bg bg-purple">
                      <i data-lucide="sparkles" class="text-purple"></i>
                    </div>
                    <div>
                      <h4 class="text-xs font-bold uppercase tracking">Asistente Jurídico IA</h4>
                      <p class="text-muted text-xs">"Generando resumen ejecutivo..."</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Quick Access Categories -->
        <div class="container section-margin">
          <h2 class="section-title">Acceso rápido a categorías</h2>
          <div class="grid grid-categories">
            <div class="category-card" @click="selectCategoryFilter('Ley')">
              <div class="cat-icon bg-blue"><i data-lucide="scroll"></i></div>
              <h3>Leyes</h3>
              <p>Leyes Estatutarias y Ordinarias</p>
            </div>
            <div class="category-card" @click="selectCategoryFilter('Decreto')">
              <div class="cat-icon bg-purple"><i data-lucide="file-text"></i></div>
              <h3>Decretos</h3>
              <p>Decretos Reglamentarios y Únicos</p>
            </div>
            <div class="category-card" @click="selectCategoryFilter('Resolución')">
              <div class="cat-icon bg-green"><i data-lucide="file-check"></i></div>
              <h3>Resoluciones</h3>
              <p>Resoluciones Ministeriales y Técnicas</p>
            </div>
            <div class="category-card" @click="selectCategoryFilter('Sentencia')">
              <div class="cat-icon bg-amber"><i data-lucide="gavel"></i></div>
              <h3>Sentencias</h3>
              <p>Jurisprudencia de Altas Cortes</p>
            </div>
          </div>
        </div>

        <!-- Featured Section: Split Norms vs Activity -->
        <div class="container section-margin grid grid-two-cols">
          <!-- Left: Most Consulted Norms & Updates -->
          <div>
            <h2 class="section-title">Últimas actualizaciones y más consultadas</h2>
            <div class="norms-list">
              <div 
                v-for="norm in normsData.slice(0, 3)" 
                :key="norm.id" 
                class="norm-list-item hover-lift"
                @click="viewNormDetails(norm)"
              >
                <div class="norm-item-header">
                  <span class="norm-type-badge">{{ norm.type }}</span>
                  <span class="badge-status vigente" :class="norm.status.toLowerCase()">{{ norm.status }}</span>
                </div>
                <h3>{{ norm.fullName }}</h3>
                <p class="norm-item-desc">{{ norm.summary }}</p>
                <div class="norm-item-footer">
                  <span><i data-lucide="calendar"></i> {{ norm.date }}</span>
                  <span><i data-lucide="building"></i> {{ norm.entity }}</span>
                </div>
              </div>
            </div>
            <div style="margin-top: 16px;">
              <button class="btn btn-outline w-full" @click="currentTab = 'library'">
                Ver toda la Biblioteca
              </button>
            </div>
          </div>

          <!-- Right: Meet Experts & Access Courses -->
          <div>
            <h2 class="section-title">Comunidad & Academia</h2>
            
            <!-- Quick Expert Profile Card -->
            <div class="highlight-box mb-24">
              <div class="box-badge">Experto Destacado</div>
              <div class="flex align-center gap-16 mt-12">
                <img :src="expertsData[0].photo" alt="Experto" class="expert-avatar" />
                <div>
                  <h4 class="expert-name-title">{{ expertsData[0].name }}</h4>
                  <p class="expert-specialty-subtitle">{{ expertsData[0].specialty }}</p>
                </div>
              </div>
              <p class="expert-desc-short mt-12">"{{ expertsData[0].experience }}"</p>
              <div class="flex justify-between align-center mt-16 pt-16 border-top">
                <span class="rating"><i data-lucide="star" style="color: var(--color-warning); fill: var(--color-warning);"></i> {{ expertsData[0].rating }} ({{ expertsData[0].reviews }} opiniones)</span>
                <button class="btn btn-xs btn-primary" @click="viewExpertProfile(expertsData[0])">
                  Ver Perfil
                </button>
              </div>
            </div>


          </div>
        </div>
      </section>

      <!-- ================== 2. TAB: LIBRARY & VISOR (GOOGLE-LIKE SEARCH) ================== -->
      <section v-if="currentTab === 'library'" class="tab-panel animate-fade">
        <div class="google-search-container">
          
          <!-- Google Header Style Search Bar & Filter Row -->
          <div class="google-header-row">
            <div class="google-logo-mini" @click="resetFilters">
              <span class="g-blue">L</span>
              <span class="g-red">e</span>
              <span class="g-yellow">g</span>
              <span class="g-blue">a</span>
              <span class="g-green">l</span>
              <span class="g-red">G</span>
            </div>
            
            <div class="google-input-box-wrapper">
              <input 
                type="text" 
                placeholder="Buscar en la base de datos de normas de Latinoamérica..." 
                v-model="librarySearchQuery"
                class="google-search-input"
              />
              <i data-lucide="search" class="google-search-icon-right"></i>
            </div>
          </div>

          <!-- Google Tabs Row -->
          <div class="google-tabs-bar">
            <div class="google-tab-item" :class="{ active: filterType === '' }" @click="filterType = ''">
              <i data-lucide="search"></i> Todos
            </div>
            <div class="google-tab-item" :class="{ active: filterType === 'Ley' }" @click="filterType = 'Ley'">
              <i data-lucide="scroll"></i> Leyes
            </div>
            <div class="google-tab-item" :class="{ active: filterType === 'Decreto' }" @click="filterType = 'Decreto'">
              <i data-lucide="file-text"></i> Decretos
            </div>
            <div class="google-tab-item" :class="{ active: filterType === 'Resolución' }" @click="filterType = 'Resolución'">
              <i data-lucide="file-check"></i> Resoluciones
            </div>
            <div class="google-tab-item" :class="{ active: filterType === 'Sentencia' }" @click="filterType = 'Sentencia'">
              <i data-lucide="gavel"></i> Sentencias
            </div>
          </div>

          <!-- Google Search Results Metadata -->
          <div class="google-results-meta">
            Aproximadamente {{ filteredNorms.length }} resultados (0.04 segundos) para la consulta.
          </div>

          <!-- Main search results layout split: Results / Quick Filters -->
          <div class="google-results-layout mt-16">
            
            <!-- Left side: Google Search Results -->
            <div class="google-results-main">
              <div v-if="filteredNorms.length > 0" class="google-results-list">                <!-- Google Style Result Card (Video on Left, Info on Right) -->
                <div 
                  v-for="norm in filteredNorms" 
                  :key="norm.id" 
                  class="google-result-card"
                  style="display: flex; flex-direction: row; gap: 20px; align-items: flex-start; padding: 16px; background: var(--bg-secondary); border: 1px solid var(--border-color); border-radius: 8px; hover: box-shadow: var(--shadow-sm);"
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
                      <span class="google-action-link" @click="downloadPDF(norm)">Descargar PDF</span>
                      <span class="google-action-link" @click="openAIConversationForNorm(norm)">Preguntar a IA</span>
                    </div>
                  </div>
                </div>

              </div>

              <!-- Empty state -->
              <div v-else class="google-empty-state">
                <h3>Su búsqueda no produjo resultados.</h3>
                <p>Sugerencias:</p>
                <ul>
                  <li>Asegúrese de que todas las palabras estén escritas correctamente.</li>
                  <li>Intente usar otras palabras clave o términos más generales.</li>
                  <li>Pruebe a limpiar los filtros actuales.</li>
                </ul>
              </div>
            </div>

            <!-- Right side: Sidebar Refined Quick Filters (Google styling) -->
            <aside class="google-results-sidebar">
              <div class="google-sidebar-box">
                <h4>Filtros de Búsqueda</h4>
                
                <!-- Sector -->
                <div class="google-filter-item mt-12">
                  <label>Sector Especializado</label>
                  <select v-model="filterSector">
                    <option value="">Todos los Sectores</option>
                    <option value="Tecnología y Telecomunicaciones">Tecnología y Privacidad</option>
                    <option value="Salud">Salud</option>
                    <option value="Comercio e Industria">Comercio e Industria</option>
                    <option value="Justicia">Justicia</option>
                  </select>
                </div>

                <!-- Vigencia -->
                <div class="google-filter-item mt-12">
                  <label>Estado de Vigencia</label>
                  <select v-model="filterStatus">
                    <option value="">Cualquier estado</option>
                    <option value="Vigente">Vigente</option>
                    <option value="Histórico">Histórico</option>
                  </select>
                </div>

                <!-- Año -->
                <div class="google-filter-item mt-12">
                  <label>Año de Emisión</label>
                  <select v-model="filterYear">
                    <option value="">Cualquier fecha</option>
                    <option value="2012">2012</option>
                    <option value="2013">2013</option>
                    <option value="2019">2019</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                  </select>
                </div>
              </div>

              <!-- Quick IA Tip -->
              <div class="google-sidebar-box mt-16 bg-blue-light border-blue">
                <div class="flex align-center gap-8 text-blue font-bold">
                  <i data-lucide="sparkles"></i>
                  <span>Tip de Búsqueda</span>
                </div>
                <p class="text-xs mt-8">Haga clic en cualquier resultado para abrir el **Visor Documental Premium** con el resumen inteligente estructurado por IA.</p>
              </div>
            </aside>
          </div>
        </div>

        <!-- ================= DOCUMENT VISOR MODAL / PANEL ================= -->
        <div v-if="selectedNorm" class="visor-backdrop" @click.self="selectedNorm = null">
          <div class="visor-container animate-slide-up">
            <!-- Visor Header -->
            <div class="visor-header">
              <div>
                <span class="norm-type-badge">{{ selectedNorm.type }}</span>
                <h2>{{ selectedNorm.fullName }}</h2>
                <div class="flex gap-16 mt-4 text-secondary text-sm">
                  <span><strong>Emisor:</strong> {{ selectedNorm.entity }}</span>
                  <span><strong>Fecha:</strong> {{ selectedNorm.date }}</span>
                  <span><strong>Vigencia:</strong> <span class="badge-status vigente" :class="selectedNorm.status.toLowerCase()">{{ selectedNorm.status }}</span></span>
                </div>
              </div>
              <button class="close-visor" @click="selectedNorm = null">
                <i data-lucide="x"></i>
              </button>
            </div>

            <!-- Visor Body Layout: Split Document content / IA features -->
            <div class="visor-body">
              <!-- Left: Document Core Text -->
              <div class="visor-doc-text">
                <div class="visor-toolbar mb-16">
                  <button class="btn btn-xs btn-outline" @click="downloadPDF(selectedNorm)">
                    <i data-lucide="download"></i> Descargar PDF
                  </button>
                  <button class="btn btn-xs btn-outline" @click="toggleFavorite(selectedNorm)">
                    <i data-lucide="heart" :class="{ 'fill-danger': isFavorite(selectedNorm.id) }"></i> 
                    {{ isFavorite(selectedNorm.id) ? 'Favorito' : 'Guardar' }}
                  </button>
                  <button class="btn btn-xs btn-outline" @click="shareNorm(selectedNorm)">
                    <i data-lucide="share-2"></i> Compartir
                  </button>
                  <button class="btn btn-xs btn-outline" @click="printNorm">
                    <i data-lucide="printer"></i> Imprimir
                  </button>
                  <button class="btn btn-xs btn-outline bg-blue-light text-blue" @click="consultExpertFromVisor(selectedNorm)">
                    <i data-lucide="user-check"></i> Consultar Experto
                  </button>
                </div>
                
                <h4 class="visor-section-title">Texto Oficial de la Norma</h4>
                <div class="document-content-view">
                  <p>{{ selectedNorm.content }}</p>
                  <div class="document-scaffold-text">
                    <p><strong>[Artículos siguientes...]</strong> Con el fin de garantizar el derecho al habeas data constitucional, el tratamiento de datos sensibles requiere estricta autorización. Se prohibe la cesión de bases de datos a terceros sin consentimiento explícito y verificable.</p>
                  </div>
                </div>
              </div>

              <!-- Right: AI Smart Assistant for this Norm -->
              <div class="visor-ai-panel">
                <div class="ai-box-header">
                  <i data-lucide="sparkles" class="text-blue"></i>
                  <h4>Resumen IA & Obligaciones</h4>
                </div>
                
                <div class="ai-box-content">
                  <div class="ai-summary-block mb-16">
                    <h5>Resumen Ejecutivo Inteligente</h5>
                    <p>{{ selectedNorm.aiSummary }}</p>
                  </div>

                  <div class="ai-obligations-block">
                    <h5>Obligaciones Clave para Organizaciones</h5>
                    <ul>
                      <li v-for="ob in selectedNorm.aiObligations" :key="ob">
                        <i data-lucide="check-circle" class="text-success"></i>
                        <span>{{ ob }}</span>
                      </li>
                    </ul>
                  </div>

                  <div class="ai-actions-block mt-16">
                    <button class="btn btn-xs btn-primary w-full" @click="openAIConversationForNorm(selectedNorm)">
                      Preguntar a la IA sobre esta norma
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- ================== 3. TAB: AI JURIDICAL ASSISTANT ================== -->
      <section v-if="currentTab === 'ia'" class="tab-panel animate-fade">
        <div class="container section-margin">
          <div class="ai-chat-layout">
            <!-- Left Panel: Norm Picker for context -->
            <div class="ai-chat-sidebar">
              <h3>Contexto del Asistente</h3>
              <p class="text-secondary text-sm">Seleccione una norma para que la Inteligencia Artificial responda con base en ella, o consulte de manera general.</p>
              
              <div class="norm-selector-list mt-16">
                <div 
                  class="norm-selector-item" 
                  :class="{ active: chatContextNorm === null }"
                  @click="chatContextNorm = null"
                >
                  <i data-lucide="globe"></i>
                  <div>
                    <h5>Consulta General</h5>
                    <span class="text-xs">Toda la base regulatoria</span>
                  </div>
                </div>

                <div 
                  v-for="norm in normsData" 
                  :key="norm.id"
                  class="norm-selector-item" 
                  :class="{ active: chatContextNorm && chatContextNorm.id === norm.id }"
                  @click="chatContextNorm = norm"
                >
                  <i data-lucide="file-text"></i>
                  <div>
                    <h5>{{ norm.title }}</h5>
                    <span class="text-xs">{{ norm.type }} ({{ norm.year }})</span>
                  </div>
                </div>
              </div>

              <!-- Legal Disclaimer -->
              <div class="disclaimer-box mt-24">
                <div class="disclaimer-header">
                  <i data-lucide="alert-triangle"></i>
                  <span>Aviso de Limitación de Responsabilidad</span>
                </div>
                <p>Las respuestas del Asistente IA son orientativas y de carácter educativo. No constituyen asesoría jurídica formal ni sustituyen el criterio de un abogado o experto legal.</p>
              </div>
            </div>

            <!-- Right Panel: Conversation Space -->
            <div class="ai-chat-main">
              <div class="chat-header">
                <div class="flex align-center gap-8">
                  <div class="bot-avatar">
                    <i data-lucide="sparkles"></i>
                  </div>
                  <div>
                    <h4>Asistente Jurídico Inteligente</h4>
                    <span class="bot-status" v-if="chatContextNorm">Analizando contextualmente: {{ chatContextNorm.title }}</span>
                    <span class="bot-status" v-else>Listo para responder sobre normatividad general</span>
                  </div>
                </div>
                <button class="btn btn-xs btn-outline" @click="clearChat">
                  Limpiar Conversación
                </button>
              </div>

              <div class="chat-messages" ref="chatMessagesContainer">
                <div 
                  v-for="(msg, idx) in chatHistory" 
                  :key="idx" 
                  class="chat-msg-wrapper"
                  :class="msg.sender"
                >
                  <div class="chat-msg">
                    <div class="msg-sender-name">{{ msg.sender === 'user' ? 'Usted' : 'Asistente IA' }}</div>
                    <div class="msg-content" v-html="msg.text"></div>
                    <div class="msg-time">{{ msg.time }}</div>
                  </div>
                </div>
                
                <div class="chat-msg-wrapper assistant" v-if="isBotTyping">
                  <div class="chat-msg">
                    <div class="msg-sender-name">Asistente IA</div>
                    <div class="msg-content typing-dots">
                      <span></span><span></span><span></span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Suggestions row -->
              <div class="chat-suggestions" v-if="chatHistory.length <= 1">
                <span class="suggestion-tag" @click="applySuggestion('¿Cuáles son mis principales obligaciones corporativas bajo la Ley 1581?')">
                  ¿Obligaciones Ley 1581?
                </span>
                <span class="suggestion-tag" @click="applySuggestion('Explícame los estándares mínimos de la Resolución 3100 de salud')">
                  ¿Resolución 3100?
                </span>
                <span class="suggestion-tag" @click="applySuggestion('¿Qué sanciones impone la SIC por brechas de seguridad?')">
                  ¿Sanciones SIC?
                </span>
              </div>

              <!-- Input bar -->
              <div class="chat-input-bar">
                <input 
                  type="text" 
                  placeholder="Pregunte sobre vigencias, obligaciones, sanciones..." 
                  v-model="chatInput"
                  @keyup.enter="sendChatMessage"
                />
                <button class="btn btn-primary" @click="sendChatMessage">
                  <i data-lucide="send"></i> Enviar
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- ================== 4. TAB: EXPERTS & MARKETPLACE ================== -->
      <section v-if="currentTab === 'marketplace'" class="tab-panel animate-fade">
        <div class="container section-margin">
          <div class="marketplace-header-row mb-24">
            <div>
              <h2>Directorio de Expertos & Marketplace</h2>
              <p class="text-secondary">Contrate consultorías de alto nivel o agende diagnósticos gratuitos con profesionales verificados.</p>
            </div>
            <!-- Promotion box / WhatsApp -->
            <div class="help-box-quick" @click="openConsultancyModal">
              <i data-lucide="message-square"></i>
              <div>
                <h5>¿Necesita ayuda personalizada?</h5>
                <span class="text-xs">Chatee con un asesor comercial por WhatsApp</span>
              </div>
            </div>
          </div>

          <!-- Section: List of Experts -->
          <div class="experts-list-section">
            <h3 class="sub-section-title mb-16">Nuestros Expertos Certificados</h3>
            <div class="experts-grid">
              <div v-for="exp in expertsData" :key="exp.id" class="expert-card hover-lift">
                <div class="expert-card-body">
                  <img :src="exp.photo" :alt="exp.name" class="expert-card-photo" />
                  <div class="expert-card-info">
                    <div class="flex justify-between align-center">
                      <h4>{{ exp.name }}</h4>
                      <span class="rating"><i data-lucide="star" class="fill-warning text-warning"></i> {{ exp.rating }}</span>
                    </div>
                    <span class="expert-badge-specialty">{{ exp.specialty }}</span>
                    <p class="expert-bio">{{ exp.experience }}</p>
                    
                    <div class="expert-certifications-list">
                      <strong>Certificaciones:</strong>
                      <ul>
                        <li v-for="cert in exp.certifications.slice(0, 2)" :key="cert">{{ cert }}</li>
                      </ul>
                    </div>
                  </div>
                </div>
                <div class="expert-card-actions">
                  <button class="btn btn-xs btn-outline" @click="viewExpertProfile(exp)">
                    Ver Perfil Completo
                  </button>
                  <button class="btn btn-xs btn-outline bg-blue-light text-blue" @click="bookExpertAppointment(exp)">
                    <i data-lucide="calendar"></i> Agendar Cita
                  </button>
                  <button class="btn btn-xs btn-primary" @click="hireExpertConsulting(exp)">
                    <i data-lucide="briefcase"></i> Contratar Asesoría
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- Section: Services Marketplace / Products -->
          <div class="services-section mt-48">
            <h3 class="sub-section-title mb-16">Servicios y Auditorías Estructuradas</h3>
            <div class="marketplace-grid">
              <!-- Service Card 1 -->
              <div class="service-card hover-lift">
                <div class="service-card-body">
                  <div class="service-badge">Auditoría Completa</div>
                  <h4>Diagnóstico Integral Ley 1581</h4>
                  <p class="service-desc">Evaluación del nivel de cumplimiento legal y técnico de bases de datos. Incluye manual de políticas y reporte final de riesgos.</p>
                  <div class="service-price-row">
                    <span class="price">$450 USD</span>
                    <span class="price-original">$600 USD</span>
                  </div>
                </div>
                <div class="service-card-footer">
                  <button class="btn btn-primary w-full" @click="addToCart('Diagnóstico Integral Ley 1581', 450)">
                    Agregar al Carrito
                  </button>
                </div>
              </div>

              <!-- Service Card 2 -->
              <div class="service-card hover-lift">
                <div class="service-card-body">
                  <div class="service-badge">Acompañamiento</div>
                  <h4>Habilitación Médica Res. 3100</h4>
                  <p class="service-desc">Estructuración documental completa y revisión de condiciones tecnológicas para inscripción exitosa de consultorios o IPS ante el REPS.</p>
                  <div class="service-price-row">
                    <span class="price">$550 USD</span>
                  </div>
                </div>
                <div class="service-card-footer">
                  <button class="btn btn-primary w-full" @click="addToCart('Habilitación Médica Res. 3100', 550)">
                    Agregar al Carrito
                  </button>
                </div>
              </div>

              <!-- Service Card 3 -->
              <div class="service-card hover-lift">
                <div class="service-card-body">
                  <div class="service-badge">Capacitación In-Company</div>
                  <h4>Taller de Ciberseguridad Legal</h4>
                  <p class="service-desc">Capacitación corporativa para directivos e ingenieros sobre la Ley 1273 de delitos informáticos y gestión jurídica del riesgo digital.</p>
                  <div class="service-price-row">
                    <span class="price">$350 USD</span>
                  </div>
                </div>
                <div class="service-card-footer">
                  <button class="btn btn-primary w-full" @click="addToCart('Taller de Ciberseguridad Legal', 350)">
                    Agregar al Carrito
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- ================= CART & CHECKOUT DRAWER ================= -->
        <div v-if="cart.length > 0" class="cart-drawer">
          <div class="cart-drawer-header">
            <h4><i data-lucide="shopping-cart"></i> Carrito de Compras</h4>
            <button class="close-drawer" @click="cart = []"><i data-lucide="x"></i></button>
          </div>
          <div class="cart-items-list">
            <div v-for="(item, idx) in cart" :key="idx" class="cart-item">
              <div>
                <h5>{{ item.name }}</h5>
                <span class="cart-item-price">${{ item.price }} USD</span>
              </div>
              <button class="remove-item-btn" @click="removeFromCart(idx)"><i data-lucide="trash-2"></i></button>
            </div>
          </div>
          <!-- Coupon Box -->
          <div class="coupon-box mt-16">
            <input type="text" placeholder="Código de Cupón" v-model="couponCode" />
            <button class="btn btn-xs btn-outline" @click="applyCoupon">Aplicar</button>
          </div>
          <div class="cart-summary mt-16 border-top pt-16">
            <div class="flex justify-between mb-8">
              <span>Subtotal:</span>
              <span>${{ cartSubtotal }} USD</span>
            </div>
            <div class="flex justify-between mb-8 text-success" v-if="discount > 0">
              <span>Descuento ({{ couponApplied }}):</span>
              <span>-${{ discount }} USD</span>
            </div>
            <div class="flex justify-between font-bold text-lg mb-16">
              <span>Total:</span>
              <span>${{ cartTotal }} USD</span>
            </div>
            <button class="btn btn-primary w-full" @click="triggerCheckout">
              Proceder al Pago Seguro
            </button>
          </div>
        </div>

        <!-- ================= EXPERT PROFILE MODAL ================= -->
        <div v-if="activeExpertProfile" class="visor-backdrop" @click.self="activeExpertProfile = null">
          <div class="visor-container expert-profile-modal-container animate-slide-up">
            <div class="visor-header">
              <h3>Perfil Profesional</h3>
              <button class="close-visor" @click="activeExpertProfile = null"><i data-lucide="x"></i></button>
            </div>
            <div class="expert-profile-layout">
              <div class="profile-left">
                <img :src="activeExpertProfile.photo" alt="Experto" class="profile-photo-large" />
                <h4>{{ activeExpertProfile.name }}</h4>
                <span class="expert-badge-specialty">{{ activeExpertProfile.specialty }}</span>
                
                <div class="rating-box-large mt-12">
                  <div class="stars">
                    <i data-lucide="star" class="fill-warning text-warning"></i>
                    <i data-lucide="star" class="fill-warning text-warning"></i>
                    <i data-lucide="star" class="fill-warning text-warning"></i>
                    <i data-lucide="star" class="fill-warning text-warning"></i>
                    <i data-lucide="star" class="fill-warning text-warning"></i>
                  </div>
                  <span>{{ activeExpertProfile.rating }} de 5 ({{ activeExpertProfile.reviews }} opiniones)</span>
                </div>
              </div>
              <div class="profile-right">
                <h5 class="profile-subtitle">Acerca de la Trayectoria</h5>
                <p>{{ activeExpertProfile.experience }}</p>

                <h5 class="profile-subtitle mt-16">Certificaciones y Acreditaciones</h5>
                <ul class="cert-list">
                  <li v-for="cert in activeExpertProfile.certifications" :key="cert">
                    <i data-lucide="award"></i> {{ cert }}
                  </li>
                </ul>

                <h5 class="profile-subtitle mt-16">Casos de Éxito</h5>
                <div class="success-case-box">
                  <p>{{ activeExpertProfile.successCases }}</p>
                </div>

                <h5 class="profile-subtitle mt-16">Vídeo de Introducción</h5>
                <div class="youtube-video-container mt-8">
                  <iframe 
                    :src="activeExpertProfile.videoUrl" 
                    title="Video del experto"
                    frameborder="0" 
                    allowfullscreen
                  ></iframe>
                </div>

                <div class="profile-action-buttons mt-24 border-top pt-16">
                  <button class="btn btn-outline" @click="bookExpertAppointment(activeExpertProfile)">
                    <i data-lucide="calendar"></i> Agendar Cita de Diagnóstico
                  </button>
                  <button class="btn btn-primary" @click="hireExpertConsulting(activeExpertProfile)">
                    Contratar Asesoría Express (${{ activeExpertProfile.price }} USD / hora)
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- ================== 5. TAB: ACADEMY (CURSOS & KAHOOT) ================== -->
      <section v-if="currentTab === 'academy'" class="tab-panel animate-fade">
        <div class="container section-margin">
          <!-- Top Row: Gamification Stats -->
          <div class="gamification-banner mb-32">
            <div class="gamification-header">
              <div>
                <h2>Academia Virtual de Formación Regulada</h2>
                <p class="text-secondary">Obtenga insignias y puntos completando evaluaciones para certificar sus conocimientos.</p>
              </div>
              <div class="user-stats">
                <div class="stat-badge">
                  <i data-lucide="flame" class="text-warning"></i>
                  <span>Puntos: {{ userPoints }} XP</span>
                </div>
                <div class="stat-badge">
                  <i data-lucide="award" class="text-success"></i>
                  <span>Insignias: {{ userBadges.length }}</span>
                </div>
              </div>
            </div>
            <div class="badges-row mt-12" v-if="userBadges.length > 0">
              <span v-for="badge in userBadges" :key="badge" class="badge-item">
                <i data-lucide="shield-check"></i> {{ badge }}
              </span>
            </div>
          </div>

          <!-- Section: Courses Grid -->
          <div class="courses-section">
            <h3 class="sub-section-title mb-16">Programas y Certificaciones Especializadas</h3>
            <div class="courses-grid">
              <div v-for="course in coursesData" :key="course.id" class="course-card hover-lift">
                <img :src="course.image" :alt="course.title" class="course-img" />
                <div class="course-body">
                  <span class="course-category-badge">{{ course.category }}</span>
                  <h4>{{ course.title }}</h4>
                  <p class="course-desc-text">{{ course.description }}</p>
                  
                  <div class="course-meta mt-12">
                    <span><i data-lucide="clock"></i> {{ course.duration }}</span>
                    <span><i data-lucide="bar-chart-2"></i> {{ course.level }}</span>
                  </div>

                  <div class="course-footer mt-16 pt-12 border-top">
                    <span class="course-price">${{ course.price }} USD</span>
                    <button class="btn btn-xs btn-primary" @click="buyCourse(course)">
                      Inscribirse
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Section: Kahoot Trivia -->
          <div class="trivia-section mt-48">
            <div class="trivia-banner">
              <div class="trivia-banner-content">
                <span class="badge-trivia">¡Desafío del Mes!</span>
                <h3>Evaluaciones de Certificación Rápida</h3>
                <p>Demuestre que domina la protección de datos y cumplimiento público. Complete la trivia con éxito y reciba un certificado en PDF automático.</p>
                
                <!-- Start Button / Quiz State Machine -->
                <div class="trivia-actions mt-16" v-if="quizState === 'idle'">
                  <button class="btn btn-primary" @click="startQuiz">
                    Iniciar Evaluación Tipo Kahoot
                  </button>
                </div>
              </div>
              <div class="trivia-banner-img">
                <i data-lucide="trophy"></i>
              </div>
            </div>

            <!-- QUIZ RUNNING STATE -->
            <div class="quiz-box mt-24" v-if="quizState === 'running'">
              <div class="quiz-header">
                <span>Pregunta {{ currentQuestionIndex + 1 }} de {{ triviaData.length }}</span>
                <!-- Timer -->
                <div class="quiz-timer" :class="{ 'warning-timer': quizTimer <= 5 }">
                  <i data-lucide="clock"></i> <span>{{ quizTimer }}s</span>
                </div>
              </div>
              
              <div class="quiz-question-body mt-16">
                <h4>{{ currentQuestion.question }}</h4>
                <span class="quiz-theme-badge mt-8">{{ currentQuestion.theme }}</span>
              </div>

              <!-- Options Grid -->
              <div class="quiz-options-grid mt-24">
                <button 
                  v-for="(option, idx) in currentQuestion.options" 
                  :key="idx"
                  class="quiz-option-btn"
                  @click="submitQuizAnswer(idx)"
                >
                  <span class="option-letter">{{ ['A', 'B', 'C', 'D'][idx] }}</span>
                  <span class="option-text">{{ option }}</span>
                </button>
              </div>
            </div>

            <!-- QUIZ FINISHED STATE -->
            <div class="quiz-box finished-box mt-24" v-if="quizState === 'finished'">
              <div class="finished-layout">
                <i data-lucide="award" class="success-trophy"></i>
                <h3>¡Evaluación Completada!</h3>
                <p class="score-text">Puntaje obtenido: <strong>{{ quizScore }} de {{ triviaData.length }} correctas</strong></p>
                <p class="xp-added" v-if="quizScore === triviaData.length">¡Excelente! Has ganado +150 XP y la insignia "Cumplimiento Perfecto".</p>
                
                <div class="flex gap-16 justify-center mt-24">
                  <button class="btn btn-outline" @click="resetQuiz">
                    Reintentar Evaluación
                  </button>
                  <button class="btn btn-primary" @click="downloadQuizCertificate" v-if="quizScore >= 2">
                    <i data-lucide="download"></i> Descargar Certificado Oficial
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- ================== 5.5. TAB: YOUTUBE CLONE PLATFORM ================== -->
      <section v-if="currentTab === 'youtube'" class="tab-panel animate-fade">
        <div class="youtube-app-wrapper">
          
          <!-- YouTube Sidebar Navigation -->
          <aside class="yt-sidebar">
            <div class="yt-sidebar-group">
              <div class="yt-sidebar-item" :class="{ active: currentTab === 'youtube' }" @click="currentTab = 'youtube'">
                <i data-lucide="play"></i> <span>Canal TV</span>
              </div>
              <div class="yt-sidebar-item" @click="currentTab = 'home'">
                <i data-lucide="home"></i> <span>Inicio</span>
              </div>
              <div class="yt-sidebar-item" @click="currentTab = 'library'">
                <i data-lucide="compass"></i> <span>Explorar</span>
              </div>
              <div class="yt-sidebar-item" @click="currentTab = 'ia'">
                <i data-lucide="sparkles"></i> <span>Abogado IA</span>
              </div>
            </div>
            
            <div class="yt-sidebar-group border-top mt-12 pt-12">
              <div class="yt-sidebar-title">Tú</div>
              <div class="yt-sidebar-item" @click="currentTab = 'memberships'">
                <i data-lucide="credit-card"></i> <span>Mi Suscripción</span>
              </div>
              <div class="yt-sidebar-item" @click="openConsultancyModal">
                <i data-lucide="phone-call"></i> <span>Soporte 24/7</span>
              </div>
            </div>
          </aside>

          <!-- YouTube Feed Content -->
          <main class="yt-feed-container">
            <!-- Channel Header Banner -->
            <div class="yt-channel-banner">
              <div class="yt-banner-overlay"></div>
              <div class="yt-channel-info-row">
                <div class="yt-channel-avatar-big">L</div>
                <div class="yt-channel-meta-text">
                  <h2>LegalCol TV</h2>
                  <div class="flex align-center gap-12 text-sm mt-4 text-secondary-light">
                    <span>@LegalCol</span>
                    <span>•</span>
                    <span>24.5 K suscriptores</span>
                    <span>•</span>
                    <span>142 videos</span>
                  </div>
                  <p class="yt-channel-bio text-xs mt-8">Canal oficial de educación jurídica y regulatoria de Latinoamérica. Simplificamos las leyes complejas en videos prácticos.</p>
                  
                  <div class="flex gap-12 mt-16">
                    <a href="https://www.youtube.com/@LegalCol/videos" target="_blank" class="btn btn-sm btn-youtube-red">
                      <i data-lucide="youtube"></i> Suscribirse
                    </a>
                    <button class="btn btn-sm btn-outline text-white border-white" @click="openConsultancyModal">
                      <i data-lucide="message-square"></i> Hablar con Asesor
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <!-- YouTube Video Filter Tags -->
            <div class="yt-tags-bar mt-24">
              <span class="yt-tag-pill active">Todos</span>
              <span class="yt-tag-pill">Protección de Datos</span>
              <span class="yt-tag-pill">Salud</span>
              <span class="yt-tag-pill">Ciberseguridad</span>
              <span class="yt-tag-pill">IA & Innovación</span>
              <span class="yt-tag-pill">Recientes</span>
            </div>

            <!-- Video Grid -->
            <div class="yt-video-grid mt-24">
              <div v-for="video in youtubeVideosData" :key="video.id" class="yt-video-card" @click="selectedVideo = video">
                <div class="yt-video-thumbnail">
                  <img :src="video.thumbnail" :alt="video.title" />
                  <span class="yt-video-time">{{ video.duration }}</span>
                  <div class="yt-thumbnail-hover-overlay">
                    <i data-lucide="play" class="play-icon-yt"></i>
                  </div>
                </div>
                
                <div class="yt-video-details mt-12">
                  <div class="yt-channel-avatar-small">L</div>
                  <div class="yt-video-meta">
                    <h4 class="yt-video-title">{{ video.title }}</h4>
                    <span class="yt-channel-name">LegalCol TV <i data-lucide="check-circle" class="check-verified-icon"></i></span>
                    <div class="yt-video-stats text-xs">
                      <span>{{ video.views }} vistas</span>
                      <span>•</span>
                      <span>Hace 2 meses</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </main>
        </div>

      </section>

      <!-- ================== 6. TAB: MEMBERSHIPS ================== -->
      <section v-if="currentTab === 'memberships'" class="tab-panel animate-fade">
        <div class="container section-margin">
          <div class="memberships-layout">
            <!-- Plan Pricing selector -->
            <div class="pricing-header">
              <h2>Membresías Normativas</h2>
              <p class="text-secondary">Escale su acceso y mantenga a su equipo actualizado con nuestras opciones flexibles.</p>
            </div>

            <div class="pricing-grid mt-32">
              <!-- Plan 1 -->
              <div class="pricing-card" :class="{ active: currentMembership === 'Gratuito' }">
                <div class="card-header-pricing">
                  <h4>Plan Gratuito</h4>
                  <div class="price-box">
                    <span class="price-val">$0</span>
                    <span class="price-period">/ siempre libre</span>
                  </div>
                </div>
                <div class="card-body-pricing">
                  <ul>
                    <li><i data-lucide="check"></i> Consulta básica de normas</li>
                    <li><i data-lucide="check"></i> Buscador de palabras clave</li>
                    <li class="muted-feature"><i data-lucide="x"></i> Descargas de PDF ilimitadas</li>
                    <li class="muted-feature"><i data-lucide="x"></i> Asistente de IA avanzado</li>
                    <li class="muted-feature"><i data-lucide="x"></i> Diagnóstico de expertos</li>
                  </ul>
                </div>
                <div class="card-footer-pricing">
                  <button class="btn btn-outline w-full" :disabled="currentMembership === 'Gratuito'" @click="changeMembershipPlan('Gratuito')">
                    {{ currentMembership === 'Gratuito' ? 'Plan Activo' : 'Seleccionar' }}
                  </button>
                </div>
              </div>

              <!-- Plan 2 -->
              <div class="pricing-card professional hover-lift" :class="{ active: currentMembership === 'Profesional' }">
                <div class="ribbon">Recomendado</div>
                <div class="card-header-pricing">
                  <h4>Plan Profesional</h4>
                  <div class="price-box">
                    <span class="price-val">$29</span>
                    <span class="price-period">/ mes</span>
                  </div>
                </div>
                <div class="card-body-pricing">
                  <ul>
                    <li><i data-lucide="check"></i> Biblioteca legal ilimitada</li>
                    <li><i data-lucide="check"></i> Descargas directas en PDF</li>
                    <li><i data-lucide="check"></i> Asistente IA Avanzado (Sin límite)</li>
                    <li><i data-lucide="check"></i> Notificaciones de cambios normativos</li>
                    <li class="muted-feature"><i data-lucide="x"></i> Capacitación corporativa</li>
                  </ul>
                </div>
                <div class="card-footer-pricing">
                  <button class="btn btn-primary w-full" @click="changeMembershipPlan('Profesional')">
                    {{ currentMembership === 'Profesional' ? 'Plan Activo' : 'Mejorar a Profesional' }}
                  </button>
                </div>
              </div>

              <!-- Plan 3 -->
              <div class="pricing-card" :class="{ active: currentMembership === 'Corporativo' }">
                <div class="card-header-pricing">
                  <h4>Plan Corporativo</h4>
                  <div class="price-box">
                    <span class="price-val">$149</span>
                    <span class="price-period">/ mes</span>
                  </div>
                </div>
                <div class="card-body-pricing">
                  <ul>
                    <li><i data-lucide="check"></i> Usuarios ilimitados en la organización</li>
                    <li><i data-lucide="check"></i> Acceso API de Consultas</li>
                    <li><i data-lucide="check"></i> 1 Capacitación corporativa mensual</li>
                    <li><i data-lucide="check"></i> Soporte de expertos premium 24/7</li>
                    <li><i data-lucide="check"></i> Dashboard multiusuario</li>
                  </ul>
                </div>
                <div class="card-footer-pricing">
                  <button class="btn btn-outline w-full" @click="changeMembershipPlan('Corporativo')">
                    {{ currentMembership === 'Corporativo' ? 'Plan Activo' : 'Contratar Plan Corporativo' }}
                  </button>
                </div>
              </div>
            </div>

            <!-- Subscriber Dashboard -->
            <div class="subscriber-dashboard mt-48 p-24 border rounded shadow-sm bg-secondary">
              <h3><i data-lucide="settings"></i> Panel de Gestión de Suscripción</h3>
              
              <div class="grid grid-three-cols mt-16 text-center">
                <div class="dash-stat">
                  <span>Membresía actual:</span>
                  <h4>{{ currentMembership }}</h4>
                </div>
                <div class="dash-stat">
                  <span>Estado:</span>
                  <h4 class="text-success">Activo</h4>
                </div>
                <div class="dash-stat">
                  <span>Próximo pago:</span>
                  <h4>20 de Julio, 2026</h4>
                </div>
              </div>

              <div class="flex justify-between align-center mt-24 border-top pt-16">
                <button class="btn btn-outline btn-xs" @click="simulateInvoiceDownload">
                  Ver Facturas anteriores
                </button>
                <button class="btn btn-danger btn-xs" @click="cancelSubscription">
                  Cancelar Renovación
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- ================== 7. TAB: ADMIN PANEL ================== -->
      <section v-if="currentTab === 'admin'" class="tab-panel animate-fade">
        <div class="container section-margin">
          
          <!-- Admin Header -->
          <div class="admin-header-row flex justify-between align-center flex-wrap gap-16 mb-24">
            <div>
              <h2 style="margin-bottom: 4px;">Panel Administrativo</h2>
              <p class="text-secondary text-sm">Gestión centralizada de contenidos, configuración y estadísticas de la plataforma LegalCol.</p>
            </div>
            <div class="flex align-center gap-8" v-if="currentUserSession">
              <div class="badge-status vigente" style="padding: 6px 14px; font-size: 0.8rem;">
                <i data-lucide="shield-check" style="width:14px;height:14px;"></i>
                <span>{{ currentUserSession.profile.role === 'admin' ? 'Administrador' : currentUserSession.profile.role }}</span>
              </div>
            </div>
          </div>

          <!-- Admin Sub-Navigation Tabs -->
          <div class="admin-subnav-tabs mb-32">
            <button class="admin-subnav-btn" :class="{ active: adminActivePanel === 'kpi' }" @click="adminActivePanel = 'kpi'">
              <i data-lucide="bar-chart-2"></i> Dashboard KPI
            </button>
            <button class="admin-subnav-btn" :class="{ active: adminActivePanel === 'content' }" @click="adminActivePanel = 'content'">
              <i data-lucide="layers"></i> Gestión de Contenidos
            </button>
            <button class="admin-subnav-btn" :class="{ active: adminActivePanel === 'logo' }" @click="adminActivePanel = 'logo'">
              <i data-lucide="image"></i> Logo &amp; Marca
            </button>
            <button class="admin-subnav-btn" :class="{ active: adminActivePanel === 'home_config' }" @click="adminActivePanel = 'home_config'">
              <i data-lucide="layout-template"></i> Configurar Inicio
            </button>
            <button class="admin-subnav-btn" :class="{ active: adminActivePanel === 'supabase' }" @click="adminActivePanel = 'supabase'">
              <i data-lucide="database"></i> Supabase DB
            </button>
          </div>

          <!-- ===== SUB-PANEL 1: KPI Dashboard ===== -->
          <div v-if="adminActivePanel === 'kpi'">
            <!-- KPI Cards Grid -->
            <div class="grid grid-categories">
              <div class="kpi-card">
                <div class="kpi-icon bg-blue"><i data-lucide="users"></i></div>
                <div class="kpi-content">
                  <span>Usuarios Activos</span>
                  <h4>14,280</h4>
                  <p class="text-success text-xs"><i data-lucide="trending-up"></i> +12% esta semana</p>
                </div>
              </div>
              <div class="kpi-card">
                <div class="kpi-icon bg-purple"><i data-lucide="file-text"></i></div>
                <div class="kpi-content">
                  <span>Normas Consultadas</span>
                  <h4>89,450</h4>
                  <p class="text-success text-xs"><i data-lucide="trending-up"></i> +28% este mes</p>
                </div>
              </div>
              <div class="kpi-card">
                <div class="kpi-icon bg-green"><i data-lucide="dollar-sign"></i></div>
                <div class="kpi-content">
                  <span>Ingresos Mensuales</span>
                  <h4>$18,450 USD</h4>
                  <p class="text-success text-xs"><i data-lucide="trending-up"></i> +5.4% de crecimiento</p>
                </div>
              </div>
              <div class="kpi-card">
                <div class="kpi-icon bg-amber"><i data-lucide="phone-call"></i></div>
                <div class="kpi-content">
                  <span>Consultorías Solicitadas</span>
                  <h4>342</h4>
                  <p class="text-secondary text-xs">Conversión: 8.9%</p>
                </div>
              </div>
              <div class="kpi-card">
                <div class="kpi-icon bg-blue"><i data-lucide="book-open"></i></div>
                <div class="kpi-content">
                  <span>Normas en Biblioteca</span>
                  <h4>{{ normsData.length }}</h4>
                  <p class="text-secondary text-xs">Documentos indexados</p>
                </div>
              </div>
              <div class="kpi-card">
                <div class="kpi-icon bg-purple"><i data-lucide="video"></i></div>
                <div class="kpi-content">
                  <span>Videos en LegalCol TV</span>
                  <h4>{{ youtubeVideosData.length }}</h4>
                  <p class="text-secondary text-xs">Videos publicados</p>
                </div>
              </div>
              <div class="kpi-card">
                <div class="kpi-icon bg-green"><i data-lucide="graduation-cap"></i></div>
                <div class="kpi-content">
                  <span>Cursos Publicados</span>
                  <h4>{{ coursesData.length }}</h4>
                  <p class="text-secondary text-xs">En academia</p>
                </div>
              </div>
              <div class="kpi-card">
                <div class="kpi-icon bg-amber"><i data-lucide="user-check"></i></div>
                <div class="kpi-content">
                  <span>Expertos Registrados</span>
                  <h4>{{ expertsData.length }}</h4>
                  <p class="text-secondary text-xs">Disponibles</p>
                </div>
              </div>
            </div>

            <!-- Activity Log -->
            <div class="admin-panel-card p-24 border rounded mt-32">
              <h3 class="mb-16"><i data-lucide="activity" style="display:inline;width:18px;height:18px;vertical-align:middle;margin-right:8px;"></i>Bitácora de Eventos Recientes</h3>
              <div class="system-logs-list">
                <div class="log-item">
                  <span class="log-time">08:44</span>
                  <span class="log-text">Usuario <strong>carlos.restrepo@empresa.co</strong> mejoró al Plan Profesional.</span>
                </div>
                <div class="log-item">
                  <span class="log-time">08:40</span>
                  <span class="log-text">Inteligencia Artificial analizó satisfactoriamente la consulta de 'Habeas Data financiero'.</span>
                </div>
                <div class="log-item">
                  <span class="log-time">08:32</span>
                  <span class="log-text">Se agendó videoconferencia por Google Meet con la experta Dra. Camila Vargas.</span>
                </div>
                <div class="log-item">
                  <span class="log-time">07:15</span>
                  <span class="log-text">Descarga automática de PDF de la Sentencia T-240 realizada de forma correcta.</span>
                </div>
              </div>
            </div>
          </div>

          <!-- ===== SUB-PANEL 2: Content Management CMS ===== -->
          <div v-if="adminActivePanel === 'content'">

            <!-- CMS Header + Tipo selector -->
            <div class="cms-header mb-20">
              <div>
                <h3 style="margin:0 0 2px 0;">Gestor de Contenidos</h3>
                <p class="text-secondary text-sm">Crea, edita y elimina cualquier contenido publicado en la plataforma.</p>
              </div>
              <div class="cms-type-pills">
                <button class="cms-pill" :class="{ active: adminActiveContentForm === 'norm' }" @click="adminActiveContentForm='norm'; editingNormId=''; cmsSearch=''"><i data-lucide="file-text"></i> Normativas <span class="cms-pill-count">{{ normsData.length }}</span></button>
                <button class="cms-pill" :class="{ active: adminActiveContentForm === 'video' }" @click="adminActiveContentForm='video'; editingVideoId=''; cmsSearch=''"><i data-lucide="youtube"></i> Videos <span class="cms-pill-count">{{ youtubeVideosData.length }}</span></button>
                <button class="cms-pill" :class="{ active: adminActiveContentForm === 'expert' }" @click="adminActiveContentForm='expert'; editingExpertId=''; cmsSearch=''"><i data-lucide="user-check"></i> Expertos <span class="cms-pill-count">{{ expertsData.length }}</span></button>
                <button class="cms-pill" :class="{ active: adminActiveContentForm === 'course' }" @click="adminActiveContentForm='course'; editingCourseId=''; cmsSearch=''"><i data-lucide="graduation-cap"></i> Cursos <span class="cms-pill-count">{{ coursesData.length }}</span></button>
                <button class="cms-pill" :class="{ active: adminActiveContentForm === 'trivia' }" @click="adminActiveContentForm='trivia'; editingTriviaId=''; cmsSearch=''"><i data-lucide="help-circle"></i> Trivia <span class="cms-pill-count">{{ triviaData.length }}</span></button>
              </div>
            </div>

            <!-- CMS Layout: tabla + formulario -->
            <div class="cms-layout">

              <!-- ============ PANEL IZQUIERDO: TABLA ============ -->
              <div class="cms-table-panel admin-panel-card border rounded">

                <!-- Barra de acción: buscar + nuevo -->
                <div class="cms-toolbar">
                  <div class="cms-search-box">
                    <i data-lucide="search" style="width:14px;height:14px;color:var(--text-muted);"></i>
                    <input v-model="cmsSearch" type="text" placeholder="Buscar..." />
                  </div>
                  <button class="btn btn-primary btn-sm" @click="clearCmsForm()">
                    <i data-lucide="plus" style="width:14px;height:14px;"></i> Nuevo
                  </button>
                </div>

                <!-- ---- TABLA: NORMATIVAS ---- -->
                <div v-if="adminActiveContentForm === 'norm'" class="cms-table-wrap">
                  <table class="cms-table">
                    <thead><tr><th>Tipo</th><th>Título</th><th>Sector</th><th>Entidad</th><th style="width:90px;text-align:center;">Acciones</th></tr></thead>
                    <tbody>
                      <tr v-for="n in normsData.filter(x => !cmsSearch || x.title?.toLowerCase().includes(cmsSearch.toLowerCase()) || x.entity?.toLowerCase().includes(cmsSearch.toLowerCase()))" :key="n.id" :class="{ 'cms-row-active': editingNormId === n.id }">
                        <td><span class="cms-badge cms-badge-blue">{{ n.type }}</span></td>
                        <td class="cms-cell-primary">{{ n.title }}</td>
                        <td class="cms-cell-secondary">{{ n.sector }}</td>
                        <td class="cms-cell-secondary">{{ n.entity }}</td>
                        <td class="cms-actions-cell">
                          <button class="cms-btn-edit" @click="editNormEntry(n)" title="Editar"><i data-lucide="pencil" style="width:13px;height:13px;"></i></button>
                          <button class="cms-btn-delete" @click="deleteNormEntry(n.id)" title="Eliminar"><i data-lucide="trash-2" style="width:13px;height:13px;"></i></button>
                        </td>
                      </tr>
                      <tr v-if="normsData.length === 0"><td colspan="5" class="cms-empty">No hay normativas publicadas.</td></tr>
                    </tbody>
                  </table>
                </div>

                <!-- ---- TABLA: VIDEOS ---- -->
                <div v-if="adminActiveContentForm === 'video'" class="cms-table-wrap">
                  <table class="cms-table">
                    <thead><tr><th>Categoría</th><th>Título</th><th>Duración</th><th>Vistas</th><th style="width:90px;text-align:center;">Acciones</th></tr></thead>
                    <tbody>
                      <tr v-for="v in youtubeVideosData.filter(x => !cmsSearch || x.title?.toLowerCase().includes(cmsSearch.toLowerCase()))" :key="v.id" :class="{ 'cms-row-active': editingVideoId === v.id }">
                        <td><span class="cms-badge cms-badge-red">{{ v.category }}</span></td>
                        <td class="cms-cell-primary">{{ v.title }}</td>
                        <td class="cms-cell-secondary">{{ v.duration }}</td>
                        <td class="cms-cell-secondary">{{ v.views }}</td>
                        <td class="cms-actions-cell">
                          <button class="cms-btn-edit" @click="editVideoEntry(v)" title="Editar"><i data-lucide="pencil" style="width:13px;height:13px;"></i></button>
                          <button class="cms-btn-delete" @click="deleteYoutubeVideoEntry(v.id)" title="Eliminar"><i data-lucide="trash-2" style="width:13px;height:13px;"></i></button>
                        </td>
                      </tr>
                      <tr v-if="youtubeVideosData.length === 0"><td colspan="5" class="cms-empty">No hay videos publicados.</td></tr>
                    </tbody>
                  </table>
                </div>

                <!-- ---- TABLA: EXPERTOS ---- -->
                <div v-if="adminActiveContentForm === 'expert'" class="cms-table-wrap">
                  <table class="cms-table">
                    <thead><tr><th>Foto</th><th>Nombre</th><th>Especialidad</th><th>Precio</th><th style="width:90px;text-align:center;">Acciones</th></tr></thead>
                    <tbody>
                      <tr v-for="e in expertsData.filter(x => !cmsSearch || x.name?.toLowerCase().includes(cmsSearch.toLowerCase()) || x.specialty?.toLowerCase().includes(cmsSearch.toLowerCase()))" :key="e.id" :class="{ 'cms-row-active': editingExpertId === e.id }">
                        <td><img :src="e.photo" style="width:32px;height:32px;border-radius:50%;object-fit:cover;" /></td>
                        <td class="cms-cell-primary">{{ e.name }}</td>
                        <td class="cms-cell-secondary">{{ e.specialty }}</td>
                        <td class="cms-cell-secondary">${{ e.price }}</td>
                        <td class="cms-actions-cell">
                          <button class="cms-btn-edit" @click="editExpertEntry(e)" title="Editar"><i data-lucide="pencil" style="width:13px;height:13px;"></i></button>
                          <button class="cms-btn-delete" @click="deleteExpertEntry(e.id)" title="Eliminar"><i data-lucide="trash-2" style="width:13px;height:13px;"></i></button>
                        </td>
                      </tr>
                      <tr v-if="expertsData.length === 0"><td colspan="5" class="cms-empty">No hay expertos registrados.</td></tr>
                    </tbody>
                  </table>
                </div>

                <!-- ---- TABLA: CURSOS ---- -->
                <div v-if="adminActiveContentForm === 'course'" class="cms-table-wrap">
                  <table class="cms-table">
                    <thead><tr><th>Nivel</th><th>Título</th><th>Instructor</th><th>Precio</th><th style="width:90px;text-align:center;">Acciones</th></tr></thead>
                    <tbody>
                      <tr v-for="c in coursesData.filter(x => !cmsSearch || x.title?.toLowerCase().includes(cmsSearch.toLowerCase()) || x.instructor?.toLowerCase().includes(cmsSearch.toLowerCase()))" :key="c.id" :class="{ 'cms-row-active': editingCourseId === c.id }">
                        <td><span class="cms-badge cms-badge-green">{{ c.level }}</span></td>
                        <td class="cms-cell-primary">{{ c.title }}</td>
                        <td class="cms-cell-secondary">{{ c.instructor }}</td>
                        <td class="cms-cell-secondary">${{ c.price }}</td>
                        <td class="cms-actions-cell">
                          <button class="cms-btn-edit" @click="editCourseEntry(c)" title="Editar"><i data-lucide="pencil" style="width:13px;height:13px;"></i></button>
                          <button class="cms-btn-delete" @click="deleteCourseEntry(c.id)" title="Eliminar"><i data-lucide="trash-2" style="width:13px;height:13px;"></i></button>
                        </td>
                      </tr>
                      <tr v-if="coursesData.length === 0"><td colspan="5" class="cms-empty">No hay cursos registrados.</td></tr>
                    </tbody>
                  </table>
                </div>

                <!-- ---- TABLA: TRIVIA ---- -->
                <div v-if="adminActiveContentForm === 'trivia'" class="cms-table-wrap">
                  <table class="cms-table">
                    <thead><tr><th>Tema</th><th>Pregunta</th><th>Respuesta correcta</th><th style="width:90px;text-align:center;">Acciones</th></tr></thead>
                    <tbody>
                      <tr v-for="(q, idx) in triviaData.filter(x => !cmsSearch || x.question?.toLowerCase().includes(cmsSearch.toLowerCase()) || x.theme?.toLowerCase().includes(cmsSearch.toLowerCase()))" :key="q.id || idx" :class="{ 'cms-row-active': editingTriviaId === (q.id || idx) }">
                        <td><span class="cms-badge cms-badge-amber">{{ q.theme }}</span></td>
                        <td class="cms-cell-primary" style="max-width:240px;">{{ q.question }}</td>
                        <td class="cms-cell-secondary" style="color:var(--color-success);">✓ {{ q.options && q.options[q.correctIndex] }}</td>
                        <td class="cms-actions-cell">
                          <button class="cms-btn-edit" @click="editTriviaEntry(q)" title="Editar"><i data-lucide="pencil" style="width:13px;height:13px;"></i></button>
                          <button class="cms-btn-delete" @click="deleteTriviaQuestionEntry(q.id)" title="Eliminar"><i data-lucide="trash-2" style="width:13px;height:13px;"></i></button>
                        </td>
                      </tr>
                      <tr v-if="triviaData.length === 0"><td colspan="4" class="cms-empty">No hay preguntas de trivia.</td></tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <!-- ============ PANEL DERECHO: FORMULARIO ============ -->
              <div class="cms-form-panel admin-panel-card border rounded">

                <!-- Cabecera del formulario -->
                <div class="cms-form-header">
                  <div>
                    <h4 style="margin:0;">
                      <span v-if="adminActiveContentForm==='norm'">{{ editingNormId ? '✏️ Editar Normativa' : '+ Nueva Normativa' }}</span>
                      <span v-if="adminActiveContentForm==='video'">{{ editingVideoId ? '✏️ Editar Video' : '+ Nuevo Video' }}</span>
                      <span v-if="adminActiveContentForm==='expert'">{{ editingExpertId ? '✏️ Editar Experto' : '+ Nuevo Experto' }}</span>
                      <span v-if="adminActiveContentForm==='course'">{{ editingCourseId ? '✏️ Editar Curso' : '+ Nuevo Curso' }}</span>
                      <span v-if="adminActiveContentForm==='trivia'">{{ editingTriviaId ? '✏️ Editar Pregunta' : '+ Nueva Pregunta' }}</span>
                    </h4>
                    <p class="text-secondary" style="font-size:0.75rem;margin:2px 0 0 0;" v-if="editingNormId||editingVideoId||editingExpertId||editingCourseId||editingTriviaId">Modificando registro existente</p>
                  </div>
                  <button v-if="editingNormId||editingVideoId||editingExpertId||editingCourseId||editingTriviaId" type="button" @click="clearCmsForm()" title="Cancelar edición" style="background:var(--bg-tertiary);border:none;border-radius:8px;padding:6px 12px;font-size:0.8rem;cursor:pointer;color:var(--text-secondary);">✕ Cancelar</button>
                </div>

                <!-- === FORM: NORMATIVA === -->
                <form v-if="adminActiveContentForm === 'norm'" @submit.prevent="addNewNorm" class="cms-form-body">
                  <div class="form-row">
                    <div class="form-group">
                      <label>Título Breve *</label>
                      <input type="text" v-model="newNormForm.title" required placeholder="Ej: Ley 2300 de 2023" />
                    </div>
                    <div class="form-group">
                      <label>Tipo *</label>
                      <select v-model="newNormForm.type" required>
                        <option value="Ley">Ley</option>
                        <option value="Decreto">Decreto</option>
                        <option value="Resolución">Resolución</option>
                        <option value="Circular">Circular</option>
                        <option value="Sentencia">Sentencia</option>
                        <option value="Acuerdo">Acuerdo</option>
                        <option value="Directiva">Directiva</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group mt-12">
                    <label>Nombre Completo *</label>
                    <input type="text" v-model="newNormForm.fullName" required placeholder="Ej: Ley Estatutaria 2300 de 2023..." />
                  </div>
                  <div class="form-row mt-12">
                    <div class="form-group">
                      <label>Sector</label>
                      <select v-model="newNormForm.sector">
                        <option value="Tecnología">Tecnología</option>
                        <option value="Financiero">Financiero</option>
                        <option value="Salud">Salud</option>
                        <option value="Laboral">Laboral</option>
                        <option value="Ambiental">Ambiental</option>
                        <option value="Contratación">Contratación</option>
                        <option value="Tributario">Tributario</option>
                        <option value="Comercial">Comercial</option>
                      </select>
                    </div>
                    <div class="form-group">
                      <label>Entidad Emisora</label>
                      <input type="text" v-model="newNormForm.entity" placeholder="Ej: MinTIC, SIC" />
                    </div>
                  </div>
                  <div class="form-group mt-12">
                    <label>Resumen Ejecutivo *</label>
                    <textarea v-model="newNormForm.summary" required rows="3" placeholder="Impacto y alcance de la norma..."></textarea>
                  </div>
                  <div class="form-group mt-12">
                    <label>Contenido / Artículos Clave</label>
                    <textarea v-model="newNormForm.content" rows="3" placeholder="Artículos relevantes, sanciones..."></textarea>
                  </div>
                  <div class="form-group mt-12">
                    <label>Palabras Clave (separadas por coma)</label>
                    <input type="text" v-model="newNormForm.keywords" placeholder="habeas data, privacidad, SIC" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Enlace PDF</label>
                    <input type="text" v-model="newNormForm.pdfUrl" placeholder="https://..." />
                  </div>
                  <div class="form-group mt-12">
                    <label>Video Relacionado</label>
                    <select v-model="newNormForm.relatedVideoId" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);">
                      <option value="">-- Ninguno / Sin Video --</option>
                      <option v-for="video in youtubeVideosData" :key="video.id" :value="video.id">{{ video.title }}</option>
                    </select>
                  </div>
                  <div class="cms-form-actions">
                    <button type="submit" class="btn btn-primary">
                      <i data-lucide="save" style="width:14px;height:14px;"></i> {{ editingNormId ? 'Guardar Cambios' : 'Publicar Normativa' }}
                    </button>
                    <button v-if="editingNormId" type="button" @click="deleteNormEntry(editingNormId)" class="btn btn-danger">
                      <i data-lucide="trash-2" style="width:14px;height:14px;"></i> Eliminar
                    </button>
                  </div>
                </form>

                <!-- === FORM: VIDEO === -->
                <form v-if="adminActiveContentForm === 'video'" @submit.prevent="addNewVideo" class="cms-form-body">
                  <div class="form-group" v-if="!editingVideoId">
                    <label>URL o ID de YouTube *</label>
                    <input type="text" v-model="newVideoForm.id" placeholder="https://youtube.com/watch?v=... o ID" />
                  </div>
                  <div class="form-group" :class="editingVideoId ? '' : 'mt-12'">
                    <label>Título *</label>
                    <input type="text" v-model="newVideoForm.title" required placeholder="Título del video" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Descripción *</label>
                    <textarea v-model="newVideoForm.description" required rows="3" placeholder="Descripción del contenido..."></textarea>
                  </div>
                  <div class="form-row mt-12">
                    <div class="form-group">
                      <label>Duración</label>
                      <input type="text" v-model="newVideoForm.duration" placeholder="14:32" />
                    </div>
                    <div class="form-group">
                      <label>Visualizaciones</label>
                      <input type="text" v-model="newVideoForm.views" placeholder="12.5K" />
                    </div>
                  </div>
                  <div class="form-group mt-12">
                    <label>URL de Embed *</label>
                    <input type="text" v-model="newVideoForm.embedUrl" placeholder="https://www.youtube.com/embed/ID" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Categoría</label>
                    <select v-model="newVideoForm.category">
                      <option value="Educativo">Educativo</option>
                      <option value="Análisis">Análisis Normativo</option>
                      <option value="Laboral">Laboral</option>
                      <option value="Tributario">Tributario</option>
                      <option value="Tecnología">Tecnología & Datos</option>
                      <option value="Contratación">Contratación</option>
                    </select>
                  </div>
                  <div class="form-group mt-12">
                    <label>URL de Miniatura</label>
                    <input type="text" v-model="newVideoForm.thumbnail" placeholder="https://img.youtube.com/vi/ID/hqdefault.jpg" />
                    <div v-if="newVideoForm.thumbnail" class="mt-8">
                      <img :src="newVideoForm.thumbnail" style="width:100%;border-radius:8px;max-height:120px;object-fit:cover;" alt="Preview miniatura" />
                    </div>
                  </div>
                  <div class="cms-form-actions">
                    <button type="submit" class="btn btn-primary">
                      <i data-lucide="save" style="width:14px;height:14px;"></i> {{ editingVideoId ? 'Guardar Cambios' : 'Publicar Video' }}
                    </button>
                    <button v-if="editingVideoId" type="button" @click="deleteYoutubeVideoEntry(editingVideoId)" class="btn btn-danger">
                      <i data-lucide="trash-2" style="width:14px;height:14px;"></i> Eliminar
                    </button>
                  </div>
                </form>

                <!-- === FORM: EXPERTO === -->
                <form v-if="adminActiveContentForm === 'expert'" @submit.prevent="addNewExpert" class="cms-form-body">
                  <div class="form-group">
                    <label>Nombre Completo *</label>
                    <input type="text" v-model="newExpertForm.name" required placeholder="Dr. Juan Pérez García" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Especialidad *</label>
                    <input type="text" v-model="newExpertForm.specialty" required placeholder="Ej: Derecho Laboral & Seguridad Social" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Experiencia</label>
                    <input type="text" v-model="newExpertForm.experience" placeholder="Ej: 15 años de experiencia" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Precio por Consulta (USD) *</label>
                    <input type="number" v-model.number="newExpertForm.price" required min="0" step="5" placeholder="150" />
                  </div>
                  <div class="form-group mt-12">
                    <label>URL Foto de Perfil</label>
                    <input type="text" v-model="newExpertForm.photo" placeholder="https://images.unsplash.com/..." />
                    <div v-if="newExpertForm.photo" class="mt-8 text-center">
                      <img :src="newExpertForm.photo" style="width:72px;height:72px;border-radius:50%;object-fit:cover;border:2px solid var(--border-color);" />
                    </div>
                  </div>
                  <div class="cms-form-actions">
                    <button type="submit" class="btn btn-primary">
                      <i data-lucide="save" style="width:14px;height:14px;"></i> {{ editingExpertId ? 'Guardar Cambios' : 'Registrar Experto' }}
                    </button>
                    <button v-if="editingExpertId" type="button" @click="deleteExpertEntry(editingExpertId)" class="btn btn-danger">
                      <i data-lucide="trash-2" style="width:14px;height:14px;"></i> Eliminar
                    </button>
                  </div>
                </form>

                <!-- === FORM: CURSO === -->
                <form v-if="adminActiveContentForm === 'course'" @submit.prevent="addNewCourse" class="cms-form-body">
                  <div class="form-group">
                    <label>Título del Curso *</label>
                    <input type="text" v-model="newCourseForm.title" required placeholder="Ej: Cumplimiento en Datos Personales" />
                  </div>
                  <div class="form-row mt-12">
                    <div class="form-group">
                      <label>Categoría *</label>
                      <input type="text" v-model="newCourseForm.category" required placeholder="Ej: Derecho Digital" />
                    </div>
                    <div class="form-group">
                      <label>Nivel</label>
                      <select v-model="newCourseForm.level">
                        <option value="Básico">Básico</option>
                        <option value="Intermedio">Intermedio</option>
                        <option value="Avanzado">Avanzado</option>
                        <option value="Experto">Experto</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-row mt-12">
                    <div class="form-group">
                      <label>Duración</label>
                      <input type="text" v-model="newCourseForm.duration" placeholder="12 horas" />
                    </div>
                    <div class="form-group">
                      <label>Precio (USD) *</label>
                      <input type="number" v-model.number="newCourseForm.price" required min="0" step="5" />
                    </div>
                  </div>
                  <div class="form-group mt-12">
                    <label>Instructor *</label>
                    <input type="text" v-model="newCourseForm.instructor" required placeholder="Nombre del instructor" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Descripción *</label>
                    <textarea v-model="newCourseForm.description" required rows="3" placeholder="Descripción del curso..."></textarea>
                  </div>
                  <div class="form-group mt-12">
                    <label>URL Imagen Portada</label>
                    <input type="text" v-model="newCourseForm.image" placeholder="https://images.unsplash.com/..." />
                    <div v-if="newCourseForm.image" class="mt-8">
                      <img :src="newCourseForm.image" style="width:100%;border-radius:8px;max-height:100px;object-fit:cover;" />
                    </div>
                  </div>
                  <div class="cms-form-actions">
                    <button type="submit" class="btn btn-primary">
                      <i data-lucide="save" style="width:14px;height:14px;"></i> {{ editingCourseId ? 'Guardar Cambios' : 'Publicar Curso' }}
                    </button>
                    <button v-if="editingCourseId" type="button" @click="deleteCourseEntry(editingCourseId)" class="btn btn-danger">
                      <i data-lucide="trash-2" style="width:14px;height:14px;"></i> Eliminar
                    </button>
                  </div>
                </form>

                <!-- === FORM: TRIVIA === -->
                <form v-if="adminActiveContentForm === 'trivia'" @submit.prevent="addNewTrivia" class="cms-form-body">
                  <div class="form-group">
                    <label>Tema / Categoría *</label>
                    <input type="text" v-model="newTriviaForm.theme" required placeholder="Habeas Data, Contratación..." />
                  </div>
                  <div class="form-group mt-12">
                    <label>Pregunta *</label>
                    <textarea v-model="newTriviaForm.question" required rows="2" placeholder="¿Cuál es el plazo máximo...?"></textarea>
                  </div>
                  <div class="form-group mt-12">
                    <label>Opción A *</label><input type="text" v-model="newTriviaForm.option0" required placeholder="Opción A" />
                  </div>
                  <div class="form-group mt-8">
                    <label>Opción B *</label><input type="text" v-model="newTriviaForm.option1" required placeholder="Opción B" />
                  </div>
                  <div class="form-group mt-8">
                    <label>Opción C *</label><input type="text" v-model="newTriviaForm.option2" required placeholder="Opción C" />
                  </div>
                  <div class="form-group mt-8">
                    <label>Opción D *</label><input type="text" v-model="newTriviaForm.option3" required placeholder="Opción D" />
                  </div>
                  <div class="form-group mt-12">
                    <label>Respuesta Correcta *</label>
                    <select v-model.number="newTriviaForm.correctIndex" required>
                      <option :value="0">A — {{ newTriviaForm.option0 }}</option>
                      <option :value="1">B — {{ newTriviaForm.option1 }}</option>
                      <option :value="2">C — {{ newTriviaForm.option2 }}</option>
                      <option :value="3">D — {{ newTriviaForm.option3 }}</option>
                    </select>
                  </div>
                  <div class="form-group mt-12">
                    <label>Explicación de la Respuesta</label>
                    <textarea v-model="newTriviaForm.explanation" rows="2" placeholder="¿Por qué es correcta?"></textarea>
                  </div>
                  <div class="cms-form-actions">
                    <button type="submit" class="btn btn-primary">
                      <i data-lucide="save" style="width:14px;height:14px;"></i> {{ editingTriviaId ? 'Guardar Cambios' : 'Publicar Pregunta' }}
                    </button>
                    <button v-if="editingTriviaId" type="button" @click="deleteTriviaQuestionEntry(editingTriviaId)" class="btn btn-danger">
                      <i data-lucide="trash-2" style="width:14px;height:14px;"></i> Eliminar
                    </button>
                  </div>
                </form>

              </div>
            </div>
          </div>


          <!-- ===== SUB-PANEL 3: Logo & Branding ===== -->


          <!-- ===== SUB-PANEL 3: Logo & Branding ===== -->
          <div v-if="adminActivePanel === 'logo'">
            <div class="grid grid-two-cols gap-24">
              <div class="admin-panel-card p-24 border rounded">
                <h3 class="mb-4"><i data-lucide="image" style="display:inline;width:18px;height:18px;vertical-align:middle;margin-right:8px;color:var(--color-accent);"></i>Configuración del Logo</h3>
                <p class="text-secondary text-sm mb-20">Personaliza el logo y la identidad visual de la plataforma.</p>
                
                <div class="form-group">
                  <label>URL del Logo (imagen externa)</label>
                  <input type="text" v-model="logoUrl" placeholder="https://miempresa.com/logo.png" />
                </div>
                <div class="form-group mt-12">
                  <label>O Subir Logo desde Archivo</label>
                  <input type="file" accept="image/*" @change="handleLogoUpload" style="width:100%;padding:6px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);" />
                </div>
                <div class="form-group mt-12">
                  <label>Ancho del Logo: {{ logoWidth }}px</label>
                  <input type="range" v-model.number="logoWidth" min="60" max="250" step="5" style="width:100%;accent-color:var(--color-accent);" />
                  <div class="flex justify-between text-xs text-secondary mt-4">
                    <span>60px (Pequeño)</span>
                    <span>250px (Grande)</span>
                  </div>
                </div>
                <div class="flex gap-12 mt-20">
                  <button class="btn btn-primary" @click="saveLogoSettings" style="flex:1;">
                    <i data-lucide="save" style="width:14px;height:14px;"></i> Guardar Logo
                  </button>
                  <button class="btn btn-outline" @click="resetLogoSettings">
                    <i data-lucide="rotate-ccw" style="width:14px;height:14px;"></i> Restaurar
                  </button>
                </div>
              </div>
              <!-- Logo Preview -->
              <div class="admin-panel-card p-24 border rounded">
                <h3 class="mb-16">Vista Previa del Logo</h3>
                <div style="background:var(--bg-secondary);border-radius:var(--radius-md);padding:24px;display:flex;align-items:center;gap:12px;margin-bottom:16px;">
                  <img :src="logoUrl" :style="{ width: logoWidth + 'px', height: 'auto', borderRadius: '4px' }" alt="Logo Preview" style="object-fit:contain;" />
                  <div>
                    <div class="logo-title" style="font-size:1.2rem;">LegalCol</div>
                    <div class="logo-tagline">Biblioteca Inteligente</div>
                  </div>
                </div>
                <div style="background:#1a1a2e;border-radius:var(--radius-md);padding:20px;display:flex;align-items:center;gap:12px;">
                  <img :src="logoUrl" :style="{ width: (logoWidth * 0.8) + 'px', height: 'auto', borderRadius: '4px' }" alt="Logo Dark Preview" style="object-fit:contain;" />
                  <div>
                    <div style="color:#ffffff;font-weight:700;font-size:1rem;">LegalCol</div>
                    <div style="color:rgba(255,255,255,0.6);font-size:0.75rem;">Fondo oscuro</div>
                  </div>
                </div>
                <p class="text-secondary text-xs mt-12">El logo se mostrará en el header de la plataforma y en documentos PDF.</p>
              </div>
            </div>
          </div>

          <!-- ===== SUB-PANEL 4: Home Page Configuration ===== -->
          <div v-if="adminActivePanel === 'home_config'">
            <div class="grid grid-two-cols gap-24">
              <div class="admin-panel-card p-24 border rounded">
                <h3 class="mb-4"><i data-lucide="layout-template" style="display:inline;width:18px;height:18px;vertical-align:middle;margin-right:8px;color:var(--color-accent);"></i>Textos de la Página de Inicio</h3>
                <p class="text-secondary text-sm mb-20">Personaliza los textos y estadísticas del Hero de la página principal.</p>
                
                <div class="form-group">
                  <label>Badge / Etiqueta Hero</label>
                  <input type="text" v-model="homeHeroBadge" placeholder="PREMIUM ECOSYSTEM" />
                  <small class="text-secondary" style="font-size:0.75rem;margin-top:4px;display:block;">Ej: PREMIUM ECOSYSTEM · NUEVO · DESTACADO</small>
                </div>
                <div class="form-group mt-12">
                  <label>Título Principal Hero (HTML permitido)</label>
                  <textarea v-model="homeHeroTitle" rows="3" placeholder='Encuentre cualquier norma en &lt;span class="gradient-text"&gt;segundos&lt;/span&gt;'></textarea>
                  <small class="text-secondary" style="font-size:0.75rem;margin-top:4px;display:block;">Puedes usar &lt;span class="gradient-text"&gt;texto resaltado&lt;/span&gt;</small>
                </div>
                <div class="form-group mt-12">
                  <label>Subtítulo Hero</label>
                  <textarea v-model="homeHeroSubtitle" rows="3" placeholder="Descripción de la plataforma..."></textarea>
                </div>
                
                <h4 class="mt-20 mb-12" style="font-size:0.95rem;font-weight:600;">Estadísticas del Hero</h4>
                <div class="grid" style="grid-template-columns: 1fr 1fr 1fr; gap: 12px;">
                  <div>
                    <label style="font-size:0.75rem;font-weight:600;color:var(--text-secondary);display:block;margin-bottom:4px;">Stat 1 - Valor</label>
                    <input type="text" v-model="homeStat1Value" placeholder="15K+" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);" />
                  </div>
                  <div>
                    <label style="font-size:0.75rem;font-weight:600;color:var(--text-secondary);display:block;margin-bottom:4px;">Stat 1 - Etiqueta</label>
                    <input type="text" v-model="homeStat1Label" placeholder="Documentos" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);" />
                  </div>
                  <div></div>
                  <div>
                    <label style="font-size:0.75rem;font-weight:600;color:var(--text-secondary);display:block;margin-bottom:4px;">Stat 2 - Valor</label>
                    <input type="text" v-model="homeStat2Value" placeholder="99.8%" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);" />
                  </div>
                  <div>
                    <label style="font-size:0.75rem;font-weight:600;color:var(--text-secondary);display:block;margin-bottom:4px;">Stat 2 - Etiqueta</label>
                    <input type="text" v-model="homeStat2Label" placeholder="Precisión IA" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);" />
                  </div>
                  <div></div>
                  <div>
                    <label style="font-size:0.75rem;font-weight:600;color:var(--text-secondary);display:block;margin-bottom:4px;">Stat 3 - Valor</label>
                    <input type="text" v-model="homeStat3Value" placeholder="24/7" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);" />
                  </div>
                  <div>
                    <label style="font-size:0.75rem;font-weight:600;color:var(--text-secondary);display:block;margin-bottom:4px;">Stat 3 - Etiqueta</label>
                    <input type="text" v-model="homeStat3Label" placeholder="Asesoría Activa" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);" />
                  </div>
                </div>

                <h4 class="mt-20 mb-12" style="font-size:0.95rem;font-weight:600;">Video Destacado del Hero</h4>
                <div class="form-group">
                  <label>Seleccionar Video Publicado o URL/ID Personalizado</label>
                  <select v-model="homeFeaturedVideoId" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);margin-bottom:8px;">
                    <option value="">-- Usar último video publicado (Por Defecto) --</option>
                    <option v-for="video in youtubeVideosData" :key="video.id" :value="video.id">{{ video.title }}</option>
                  </select>
                  <input type="text" v-model="homeFeaturedVideoId" placeholder="O pega el ID del video directamente (ej: dQw4w9WgXcQ)" />
                </div>
                <div class="form-group mt-12">
                  <label>Ancho Máximo del Video en Inicio: {{ homeFeaturedVideoWidth }}px</label>
                  <input type="range" v-model.number="homeFeaturedVideoWidth" min="300" max="800" step="10" style="width:100%;accent-color:var(--color-accent);" />
                  <div class="flex justify-between text-xs text-secondary mt-4">
                    <span>300px (Pequeño)</span>
                    <span>550px (Estándar)</span>
                    <span>800px (Grande)</span>
                  </div>
                </div>

                <h4 class="mt-20 mb-12" style="font-size:0.95rem;font-weight:600;">Buscador Principal en Inicio</h4>
                <div class="form-group">
                  <label>Ancho Máximo del Buscador</label>
                  <select v-model="homeSearchWidth" style="width:100%;padding:8px;border:1px solid var(--border-color);border-radius:4px;background:var(--bg-secondary);color:var(--text-primary);">
                    <option value="580px">Estándar (580px)</option>
                    <option value="780px">Grande (780px)</option>
                    <option value="1000px">Muy Grande (1000px)</option>
                    <option value="100%">Extremo a Extremo (100%)</option>
                  </select>
                </div>
                
                <button class="btn btn-primary w-full mt-20" @click="saveHomeSettings">
                  <i data-lucide="save" style="width:14px;height:14px;"></i> Guardar Configuración de Inicio
                </button>
              </div>

              <!-- Home Preview -->
              <div class="admin-panel-card p-24 border rounded">
                <h3 class="mb-16">Vista Previa del Hero</h3>
                <div style="background: linear-gradient(135deg, #0d0d1a 0%, #0a0a1f 100%); border-radius: var(--radius-md); padding: 28px; position: relative; overflow: hidden;">
                  <div style="position:absolute;inset:0;background:radial-gradient(circle at 30% 50%, rgba(66,133,244,0.15) 0%, transparent 60%);pointer-events:none;"></div>
                  <div style="position:relative;z-index:1;">
                    <span style="display:inline-block;background:rgba(66,133,244,0.15);color:#4285f4;border:1px solid rgba(66,133,244,0.3);border-radius:20px;padding:4px 12px;font-size:0.7rem;font-weight:700;letter-spacing:1px;margin-bottom:12px;">{{ homeHeroBadge }}</span>
                    <h2 v-html="homeHeroTitle" style="font-size:1.4rem;color:#ffffff;font-weight:800;line-height:1.3;margin-bottom:10px;"></h2>
                    <p style="color:rgba(255,255,255,0.65);font-size:0.8rem;line-height:1.5;margin-bottom:16px;">{{ homeHeroSubtitle.substring(0, 120) }}...</p>
                    <div style="display:flex;gap:16px;">
                      <div style="text-align:center;">
                        <div style="color:#4285f4;font-weight:800;font-size:1.2rem;">{{ homeStat1Value }}</div>
                        <div style="color:rgba(255,255,255,0.5);font-size:0.7rem;">{{ homeStat1Label }}</div>
                      </div>
                      <div style="text-align:center;">
                        <div style="color:#34a853;font-weight:800;font-size:1.2rem;">{{ homeStat2Value }}</div>
                        <div style="color:rgba(255,255,255,0.5);font-size:0.7rem;">{{ homeStat2Label }}</div>
                      </div>
                      <div style="text-align:center;">
                        <div style="color:#fbbc04;font-weight:800;font-size:1.2rem;">{{ homeStat3Value }}</div>
                        <div style="color:rgba(255,255,255,0.5);font-size:0.7rem;">{{ homeStat3Label }}</div>
                      </div>
                    </div>
                  </div>
                </div>
                <p class="text-secondary text-xs mt-12">Esta es una vista previa simplificada del hero de la página de inicio.</p>
              </div>
            </div>
          </div>

          <!-- ===== SUB-PANEL 5: Supabase Database ===== -->
          <div v-if="adminActivePanel === 'supabase'">
            <div class="grid grid-two-cols gap-24">
              <div class="admin-panel-card p-24 border rounded">
                <h3 class="mb-4"><i data-lucide="database" style="display:inline;width:18px;height:18px;vertical-align:middle;margin-right:8px;color:var(--color-accent);"></i>Conexión a Supabase</h3>
                <p class="text-secondary text-sm mb-20">Configura la conexión a tu base de datos en Supabase para activar el modo cloud de LegalCol.</p>
                
                <div style="padding:12px 16px;border-radius:var(--radius-sm);margin-bottom:16px;display:flex;align-items:center;gap:10px;" :style="isSupabaseConnected ? 'background:rgba(52,168,83,0.1);border:1px solid rgba(52,168,83,0.3);' : 'background:rgba(234,67,53,0.08);border:1px solid rgba(234,67,53,0.2);'">
                  <i :data-lucide="isSupabaseConnected ? 'check-circle' : 'alert-circle'" :style="isSupabaseConnected ? 'color:var(--color-success);width:18px;height:18px;' : 'color:var(--color-danger);width:18px;height:18px;'"></i>
                  <span :style="isSupabaseConnected ? 'color:var(--color-success);font-weight:600;' : 'color:var(--color-danger);font-weight:600;'">
                    {{ isSupabaseConnected ? 'Conectado a Supabase' : 'Sin conexión a Supabase (modo local)' }}
                  </span>
                </div>

                <div class="form-group">
                  <label>URL del Proyecto Supabase</label>
                  <input type="text" v-model="supabaseUrl" placeholder="https://abcxyz.supabase.co" />
                </div>
                <div class="form-group mt-12">
                  <label>Clave Anon / Public Key</label>
                  <input type="password" v-model="supabaseKey" placeholder="eyJhbGci..." />
                </div>
                <div class="flex gap-12 mt-16">
                  <button class="btn btn-primary" @click="saveAndTestSupabase" style="flex:1;" :disabled="isTestingConnection">
                    <i data-lucide="plug" style="width:14px;height:14px;"></i>
                    {{ isTestingConnection ? 'Probando...' : 'Guardar y Conectar' }}
                  </button>
                </div>
                
                <div class="mt-24" style="border-top:1px solid var(--border-color);padding-top:20px;">
                  <h4 style="font-size:0.9rem;font-weight:600;margin-bottom:12px;">Sincronización de Datos</h4>
                  <p class="text-secondary text-sm mb-12">Exporta todos los datos locales a tu base de datos Supabase.</p>
                  <button class="btn btn-outline w-full" @click="syncAllToSupabase" :disabled="!isSupabaseConnected || isSyncingDb">
                    <i data-lucide="upload-cloud" style="width:14px;height:14px;"></i>
                    {{ isSyncingDb ? 'Sincronizando...' : 'Sincronizar Todo a Supabase' }}
                  </button>
                  <p v-if="!isSupabaseConnected" class="text-secondary text-xs mt-8 text-center">Debes estar conectado para sincronizar datos.</p>
                </div>
              </div>

              <!-- Supabase Info Card -->
              <div class="admin-panel-card p-24 border rounded">
                <h3 class="mb-16">Guía de Configuración</h3>
                <div style="display:flex;flex-direction:column;gap:16px;">
                  <div style="display:flex;gap:12px;align-items:flex-start;">
                    <div style="width:28px;height:28px;border-radius:50%;background:var(--color-accent);color:white;display:flex;align-items:center;justify-content:center;font-size:0.75rem;font-weight:700;flex-shrink:0;">1</div>
                    <div>
                      <p style="font-weight:600;font-size:0.9rem;margin-bottom:4px;">Crear proyecto en Supabase</p>
                      <p class="text-secondary text-sm">Visita supabase.com → New Project y crea tu proyecto de base de datos.</p>
                    </div>
                  </div>
                  <div style="display:flex;gap:12px;align-items:flex-start;">
                    <div style="width:28px;height:28px;border-radius:50%;background:var(--color-accent);color:white;display:flex;align-items:center;justify-content:center;font-size:0.75rem;font-weight:700;flex-shrink:0;">2</div>
                    <div>
                      <p style="font-weight:600;font-size:0.9rem;margin-bottom:4px;">Ejecutar el esquema SQL</p>
                      <p class="text-secondary text-sm">Copia el contenido de <code style="background:var(--bg-secondary);padding:1px 6px;border-radius:3px;font-size:0.8rem;">schema.sql</code> y ejecútalo en el SQL Editor de Supabase.</p>
                    </div>
                  </div>
                  <div style="display:flex;gap:12px;align-items:flex-start;">
                    <div style="width:28px;height:28px;border-radius:50%;background:var(--color-accent);color:white;display:flex;align-items:center;justify-content:center;font-size:0.75rem;font-weight:700;flex-shrink:0;">3</div>
                    <div>
                      <p style="font-weight:600;font-size:0.9rem;margin-bottom:4px;">Copiar credenciales</p>
                      <p class="text-secondary text-sm">En Settings → API, copia la URL del proyecto y la clave anon/public.</p>
                    </div>
                  </div>
                  <div style="display:flex;gap:12px;align-items:flex-start;">
                    <div style="width:28px;height:28px;border-radius:50%;background:var(--color-success);color:white;display:flex;align-items:center;justify-content:center;font-size:0.75rem;font-weight:700;flex-shrink:0;">4</div>
                    <div>
                      <p style="font-weight:600;font-size:0.9rem;margin-bottom:4px;">Pega aquí y conecta</p>
                      <p class="text-secondary text-sm">Ingresa las credenciales en el formulario y haz clic en "Guardar y Conectar".</p>
                    </div>
                  </div>
                </div>
                
                <div style="margin-top:20px;padding:12px 16px;background:rgba(66,133,244,0.08);border:1px solid rgba(66,133,244,0.2);border-radius:var(--radius-sm);">
                  <p class="text-xs" style="color:var(--color-accent);font-weight:600;margin-bottom:4px;"><i data-lucide="info" style="width:12px;height:12px;display:inline;vertical-align:middle;"></i> Modo Local Activo</p>
                  <p class="text-secondary text-xs">Sin conexión, todos los datos se guardan en memoria y se pierden al recargar. Conecta Supabase para persistencia completa.</p>
                </div>
              </div>
            </div>
          </div>

        </div>
      </section>

    </main>

    <!-- AUTHENTICATION DIALOG / MODAL (SUPABASE SIGNIN & REGISTER) -->
    <div v-if="showAuthModal" class="visor-backdrop" @click.self="showAuthModal = false">
      <div class="auth-modal-card animate-slide-up">
        <!-- Modal Header con logo -->
        <div class="auth-modal-header">
          <div style="display:flex;align-items:center;gap:8px;margin-bottom:4px;">
            <span style="font-size:1.5rem;font-weight:800;letter-spacing:-0.04em;color:var(--text-primary);">LegalCol</span>
            <span style="background:var(--color-accent);color:white;font-size:0.6rem;font-weight:700;padding:2px 6px;border-radius:999px;letter-spacing:0.04em;">PRO</span>
          </div>
          <p style="color:var(--text-secondary);font-size:0.85rem;">{{ authTab === 'login' ? 'Bienvenido de vuelta' : 'Crea tu cuenta gratuita' }}</p>
          <button @click="showAuthModal = false" style="position:absolute;top:20px;right:20px;background:none;border:none;cursor:pointer;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;color:var(--text-secondary);transition:background 0.2s;" onmouseover="this.style.background='var(--bg-tertiary)'" onmouseout="this.style.background='none'">
            <i data-lucide="x" style="width:16px;height:16px;"></i>
          </button>
        </div>

        <!-- Tabs -->
        <div style="display:flex;background:var(--bg-tertiary);border-radius:8px;padding:3px;margin-bottom:24px;">
          <button type="button" @click="authTab = 'login'" :style="authTab==='login' ? 'flex:1;padding:8px;border:none;border-radius:6px;background:white;font-weight:600;font-size:0.85rem;cursor:pointer;box-shadow:0 1px 3px rgba(0,0,0,0.1);color:var(--text-primary);' : 'flex:1;padding:8px;border:none;background:none;font-size:0.85rem;cursor:pointer;color:var(--text-secondary);'">Ingresar</button>
          <button type="button" @click="authTab = 'register'" :style="authTab==='register' ? 'flex:1;padding:8px;border:none;border-radius:6px;background:white;font-weight:600;font-size:0.85rem;cursor:pointer;box-shadow:0 1px 3px rgba(0,0,0,0.1);color:var(--text-primary);' : 'flex:1;padding:8px;border:none;background:none;font-size:0.85rem;cursor:pointer;color:var(--text-secondary);'">Registrarse</button>
        </div>

        <form @submit.prevent="handleAuthSubmit">
          <div v-if="authTab === 'register'" class="auth-field">
            <label>Nombre Completo</label>
            <input type="text" v-model="authFullName" required placeholder="Ej: Ana López Vargas" />
          </div>

          <div class="auth-field" :style="authTab==='register' ? 'margin-top:12px;' : ''">
            <label>Correo Electrónico</label>
            <input type="email" v-model="authEmail" required placeholder="correo@empresa.com" />
          </div>

          <div class="auth-field" style="margin-top:12px;">
            <label>Contraseña</label>
            <input type="password" v-model="authPassword" required placeholder="Mínimo 6 caracteres" />
          </div>

          <div v-if="authTab === 'register'" class="auth-field" style="margin-top:12px;">
            <label>Perfil de Acceso</label>
            <select v-model="authRoleSelection" required>
              <option value="user">👤 Usuario — Lectura y Consultas</option>
              <option value="expert">⚖️ Experto Legal — Asesorías y Cursos</option>
              <option value="admin">🛠️ Administrador — Gestor de Contenidos</option>
            </select>
          </div>

          <button type="submit" :disabled="isAuthLoading" style="width:100%;margin-top:20px;padding:13px;border:none;border-radius:10px;background:var(--color-accent);color:white;font-size:0.95rem;font-weight:700;cursor:pointer;display:flex;align-items:center;justify-content:center;gap:8px;transition:opacity 0.2s;" :style="isAuthLoading ? 'opacity:0.7;cursor:not-allowed;' : 'opacity:1;'">
            <svg v-if="isAuthLoading" style="width:16px;height:16px;animation:spin 1s linear infinite;" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="10" stroke="rgba(255,255,255,0.3)" stroke-width="3"/><path d="M12 2a10 10 0 0 1 10 10" stroke="white" stroke-width="3" stroke-linecap="round"/></svg>
            {{ isAuthLoading ? 'Procesando...' : (authTab === 'login' ? 'Ingresar' : 'Crear Cuenta') }}
          </button>
        </form>

        <!-- Hint demo admin -->
        <div v-if="authTab === 'login' && !isSupabaseConnected" style="margin-top:16px;padding:10px 14px;background:var(--bg-secondary);border-radius:8px;border:1px solid var(--border-color);">
          <p style="font-size:0.75rem;color:var(--text-secondary);margin:0;"><strong style="color:var(--text-primary);">Modo Demo:</strong> Usa <code style="background:var(--bg-tertiary);padding:1px 5px;border-radius:4px;">admin@legalcol.com</code> / <code style="background:var(--bg-tertiary);padding:1px 5px;border-radius:4px;">AdminLegalCol2026!</code></p>
        </div>
      </div>
    </div>

    <!-- FLOATING CONSULTANCY MODULE (LATERAL RIGHT / TRIGGER CARD) -->
    <div class="floating-consultancy-tab" @click="openConsultancyModal">
      <div class="pulse-ring"></div>
      <i data-lucide="headset"></i>
      <span>¿Ayuda especializada?</span>
    </div>

    <!-- CONSULTANCY INTEGRATION MODAL -->
    <div v-if="showConsultancyModal" class="visor-backdrop" @click.self="showConsultancyModal = false">
      <div class="visor-container consultancy-modal-container animate-slide-up">
        <div class="visor-header">
          <div class="flex align-center gap-8">
            <i data-lucide="headset" class="text-blue"></i>
            <div>
              <h3>Centro de Soporte Normativo & Consultoría</h3>
              <p class="text-secondary text-sm">Reciba acompañamiento de nuestros expertos.</p>
            </div>
          </div>
          <button class="close-visor" @click="showConsultancyModal = false">
            <i data-lucide="x"></i>
          </button>
        </div>

        <div class="consultancy-modal-body">
          <div class="consult-options-grid">
            <!-- WhatsApp -->
            <a href="https://wa.me/1234567890" target="_blank" class="consult-opt hover-lift">
              <i data-lucide="message-circle" class="text-success font-xl"></i>
              <h4>Contacto de WhatsApp</h4>
              <p>Hable de inmediato con un asesor legal de guardia.</p>
              <span class="action-hint">Chatear Ahora <i data-lucide="arrow-right"></i></span>
            </a>

            <!-- Google Meet / Zoom Appointment -->
            <div class="consult-opt hover-lift" @click="simulateCalendly">
              <i data-lucide="video" class="text-blue font-xl"></i>
              <h4>Agendar Videollamada</h4>
              <p>Programe una sesión de 15 minutos vía Google Meet o Zoom.</p>
              <span class="action-hint">Elegir Horario <i data-lucide="arrow-right"></i></span>
            </div>

            <!-- Free Diagnosis Form -->
            <div class="consult-opt hover-lift" @click="openDiagnosisForm">
              <i data-lucide="shield-alert" class="text-warning font-xl"></i>
              <h4>Diagnóstico Gratuito</h4>
              <p>Envíe sus requerimientos y analizaremos su nivel de cumplimiento legal sin costo.</p>
              <span class="action-hint">Completar Formulario <i data-lucide="arrow-right"></i></span>
            </div>
          </div>

          <!-- Quick Lead Form -->
          <div class="diagnosis-form mt-24 p-24 border rounded bg-secondary" v-if="showDiagnosisForm">
            <h4>Formulario de Diagnóstico Inicial</h4>
            <form @submit.prevent="submitDiagnosis">
              <div class="form-group mt-12">
                <label>Nombre de la Empresa / Persona</label>
                <input type="text" placeholder="Ej: Importaciones del Caribe" required v-model="diagnosisData.companyName" />
              </div>
              <div class="form-group mt-12">
                <label>Correo Electrónico</label>
                <input type="email" placeholder="ejemplo@correo.com" required v-model="diagnosisData.email" />
              </div>
              <div class="form-group mt-12">
                <label>Describa brevemente su necesidad o consulta</label>
                <textarea rows="3" placeholder="Necesito saber si debo registrar bases de datos ante la SIC..." required v-model="diagnosisData.description"></textarea>
              </div>
              <button type="submit" class="btn btn-primary mt-16 w-full">
                Enviar Diagnóstico Gratuito
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- YOUTUBE VIDEO PLAYER SCREEN (FULL OVERLAY SIMULATOR) -->
    <div v-if="selectedVideo" class="yt-player-overlay animate-fade">
      <div class="yt-player-header">
        <div class="logo" @click="selectedVideo = null">
          <i data-lucide="youtube" class="text-danger"></i>
          <span class="logo-title text-white">LegalCol TV</span>
        </div>
        <button class="btn btn-sm btn-outline text-white border-white" @click="selectedVideo = null">
          <i data-lucide="arrow-left"></i> Volver
        </button>
      </div>

      <div class="yt-player-content-layout">
        <!-- Left Panel: Large Video & Comments -->
        <div class="yt-player-left-col">
          <div class="yt-video-wrapper-aspect">
            <iframe 
              :src="selectedVideo.embedUrl" 
              title="YouTube video player" 
              frameborder="0" 
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
              allowfullscreen
            ></iframe>
          </div>

          <h2 class="yt-player-title mt-16">{{ selectedVideo.title }}</h2>
          
          <!-- Video Channel bar & Actions -->
          <div class="yt-player-meta-action-row mt-12 pb-16 border-bottom">
            <div class="flex align-center gap-12">
              <div class="yt-channel-avatar-small">L</div>
              <div>
                <h4 class="text-white">LegalCol TV <i data-lucide="check-circle" class="check-verified-icon"></i></h4>
                <span class="text-xs text-muted">24.5 K suscriptores</span>
              </div>
              <a href="https://www.youtube.com/@LegalCol/videos" target="_blank" class="btn btn-xs btn-youtube-red ml-12">
                Suscribirse
              </a>
            </div>

            <div class="yt-actions-buttons">
              <button class="btn btn-xs btn-secondary-dark"><i data-lucide="thumbs-up"></i> 1.2K</button>
              <button class="btn btn-xs btn-secondary-dark"><i data-lucide="share-2"></i> Compartir</button>
              <button class="btn btn-xs btn-secondary-dark" @click="downloadPDF({ title: selectedVideo.title })"><i data-lucide="download"></i> PDF Norma</button>
            </div>
          </div>

          <!-- Comments Section Simulation -->
          <div class="yt-comments-section mt-24">
            <h3>3 comentarios</h3>
            
            <div class="flex gap-12 mt-16">
              <div class="yt-user-avatar">U</div>
              <div class="flex-grow">
                <input type="text" placeholder="Añade un comentario público..." class="yt-comment-input w-full" />
              </div>
            </div>

            <!-- Comment 1 -->
            <div class="yt-comment-item mt-24 flex gap-12">
              <div class="yt-user-avatar">CR</div>
              <div>
                <div class="flex align-center gap-8">
                  <span class="comment-author text-white">Carlos Restrepo</span>
                  <span class="comment-time text-muted text-xs">Hace 3 semanas</span>
                </div>
                <p class="comment-text text-sm text-secondary-light mt-4">Excelente resumen. La explicación del Artículo 15 de la Constitución y la correlación con la Superintendencia aclara mucho las obligaciones.</p>
              </div>
            </div>

            <!-- Comment 2 -->
            <div class="yt-comment-item mt-16 flex gap-12">
              <div class="yt-user-avatar">MV</div>
              <div>
                <div class="flex align-center gap-8">
                  <span class="comment-author text-white">María Vargas</span>
                  <span class="comment-time text-muted text-xs">Hace 1 mes</span>
                </div>
                <p class="comment-text text-sm text-secondary-light mt-4">¿Esta circular única de la SIC aplica para empresas extranjeras que capten datos de colombianos en el exterior?</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Right Panel: Related / Suggested Video Sidebar -->
        <div class="yt-player-right-col">
          <h3 class="text-white text-sm mb-12">Siguiente Video</h3>
          
          <div class="yt-related-list">
            <div 
              v-for="relVideo in youtubeVideosData.filter(v => v.id !== selectedVideo.id)" 
              :key="relVideo.id"
              class="yt-related-item flex gap-12 cursor-pointer"
              @click="selectedVideo = relVideo"
            >
              <img :src="relVideo.thumbnail" alt="Miniatura" class="yt-related-thumb" />
              <div class="yt-related-info">
                <h4 class="text-white text-xs font-bold line-clamp-2">{{ relVideo.title }}</h4>
                <span class="text-muted text-xs block mt-4">LegalCol TV</span>
                <span class="text-muted text-xs block">{{ relVideo.views }} vistas</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
      <div class="container footer-grid">
        <div class="footer-col">
          <div class="logo" style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px;">
            <img :src="logoUrl" :style="{ width: (logoWidth * 0.8) + 'px', height: 'auto', borderRadius: '4px' }" alt="LeyesYa Logo" />
            <span class="logo-title">LeyesYa</span>
          </div>
          <p class="footer-desc mt-12">La biblioteca inteligente de consulta normativa de clase mundial para el mercado de habla hispana.</p>
        </div>
        <div class="footer-col">
          <h4>Plataforma</h4>
          <ul class="footer-links">
            <li><a href="#" @click.prevent="currentTab = 'library'">Biblioteca Legal</a></li>
            <li><a href="#" @click.prevent="currentTab = 'ia'">Asistente de IA</a></li>
            <li><a href="#" @click.prevent="currentTab = 'marketplace'">Marketplace de Expertos</a></li>
            <li><a href="#" @click.prevent="currentTab = 'academy'">Academia Virtual</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4>Ayuda & Contacto</h4>
          <ul class="footer-links">
            <li><a href="#" @click.prevent="openConsultancyModal">Agendar Reunión</a></li>
            <li><a href="#" @click.prevent="openConsultancyModal">Diagnóstico Gratuito</a></li>
            <li><a href="https://wa.me/1234567890" target="_blank">Soporte WhatsApp</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom border-top mt-24 pt-24 text-center text-sm text-secondary">
        <p>&copy; 2026 LegalCol. Todos los derechos reservados. Diseñado con altos estándares de innovación legal.</p>
      </div>
    </footer>
  </div>
</template>

<script>
import { norms, experts, courses, triviaQuestions, youtubeVideos } from './data.js';
import { 
  getSavedCredentials, 
  saveCredentials, 
  initSupabaseClient, 
  testConnection,
  fetchNorms, 
  fetchExperts, 
  fetchCourses, 
  fetchTriviaQuestions, 
  fetchYoutubeVideos,
  insertNorms, 
  insertExperts, 
  insertCourses, 
  insertTriviaQuestions, 
  insertYoutubeVideos,
  signUpUser,
  signInUser,
  signOutUser,
  getCurrentUserSession,
  deleteNorm,
  deleteExpert,
  deleteCourse,
  deleteTriviaQuestion,
  deleteYoutubeVideo,
  fetchSystemSettings,
  saveSystemSetting,
  insertDefaultSystemSettings
} from './supabase.js';

export default {
  name: 'App',
  data() {
    return {
      showAuthModal: false,
      currentTab: 'home',
      normsData: norms,
      expertsData: experts,
      coursesData: courses,
      triviaData: triviaQuestions,
      youtubeVideosData: youtubeVideos,
      logoUrl: localStorage.getItem('legalcol_logo_url') || '/Logo.jpg',
      logoWidth: parseInt(localStorage.getItem('legalcol_logo_width') || '120'),
      homeHeroBadge: localStorage.getItem('legalcol_home_hero_badge') || 'PREMIUM ECOSYSTEM',
      homeHeroTitle: localStorage.getItem('legalcol_home_hero_title') || 'Encuentre cualquier norma, ley o regulación <span class="gradient-text">en segundos</span>',
      homeHeroSubtitle: localStorage.getItem('legalcol_home_hero_subtitle') || 'La plataforma inteligente de clase mundial que combina una biblioteca jurídica digital con análisis de Inteligencia Artificial, academia de cumplimiento y consultoría especializada.',
      homeStat1Value: localStorage.getItem('legalcol_home_stat1_val') || '15K+',
      homeStat1Label: localStorage.getItem('legalcol_home_stat1_lbl') || 'Documentos',
      homeStat2Value: localStorage.getItem('legalcol_home_stat2_val') || '99.8%',
      homeStat2Label: localStorage.getItem('legalcol_home_stat2_lbl') || 'Precisión IA',
      homeStat3Value: localStorage.getItem('legalcol_home_stat3_val') || '24/7',
      homeStat3Label: localStorage.getItem('legalcol_home_stat3_lbl') || 'Asesoría Activa',
      // Home page featured video customization
      homeFeaturedVideoId: localStorage.getItem('legalcol_home_featured_videoid') || '',
      homeFeaturedVideoWidth: parseInt(localStorage.getItem('legalcol_home_featured_videowidth') || '550'),
      homeSearchWidth: localStorage.getItem('legalcol_home_search_width') || '780px',

      // Supabase connection state
      supabaseUrl: '',
      supabaseKey: '',
      isSupabaseConnected: false,
      isTestingConnection: false,
      isSyncingDb: false,
      connectionStatusText: 'Desconectado',

      // Authentication and Role-based state
      currentUserSession: null,
      currentUserRole: 'guest', // 'guest' | 'user' | 'expert' | 'admin'
      authEmail: '',
      authPassword: '',
      authFullName: '',
      authRoleSelection: 'user', // default registration role
      isAuthLoading: false,
      authTab: 'login',
      adminActivePanel: 'kpi', // 'kpi' | 'supabase' | 'content_crud'
      adminActiveContentForm: 'norm',
      
      // Editing State
      editingNormId: '',
      editingVideoId: '',
      editingExpertId: '',
      editingCourseId: '',
      editingTriviaId: '',
      // CMS Module state
      cmsSearch: '',
      // Mobile Responsive Menu State
      mobileMenuOpen: false,
      // Favorites list
      favorites: [],

      // Centralized / Library search & filters
      searchQuery: '',
      librarySearchQuery: '',
      filterType: '',
      filterSector: '',
      filterStatus: '',
      filterYear: '',
      filterCountry: '',

      // Document Visor Selection
      selectedNorm: null,

      // AI Juridical Assistant Chat State
      chatContextNorm: null,
      chatInput: '',
      isBotTyping: false,
      chatHistory: [
        {
          sender: 'assistant',
          text: '¡Hola! Soy su Asistente Legal con IA de LegalCol. ¿En qué norma o regulación específica le gustaría profundizar hoy? Puedo explicar vigencias, resumir artículos o identificar obligaciones corporativas.',
          time: 'Ahora'
        }
      ],

      // Shopping Cart
      cart: [],
      couponCode: '',
      couponApplied: '',
      discount: 0,

      // User Profile / Gamification
      userPoints: 0,
      userBadges: [],
      currentMembership: 'Gratuito',

      // Expert Modals
      activeExpertProfile: null,

      // Kahoot Trivia Module State
      quizState: 'idle', // 'idle' | 'running' | 'finished'
      currentQuestionIndex: 0,
      quizTimer: 15,
      quizTimerInterval: null,
      quizAnswers: [],
      quizScore: 0,

      // Help Modal & diagnosis
      showConsultancyModal: false,
      showDiagnosisForm: false,
      diagnosisData: {
        companyName: '',
        email: '',
        description: ''
      },

      // Admin Forms
      newNormForm: {
        title: '',
        type: 'Ley',
        fullName: '',
        summary: '',
        content: '',
        sector: 'Tecnología',
        entity: 'Congreso',
        keywords: '',
        relatedVideoId: '',
        pdfUrl: ''
      },
      newExpertForm: {
        id: '',
        name: '',
        photo: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=256&auto=format&fit=crop',
        specialty: '',
        experience: '',
        price: 100
      },
      newCourseForm: {
        id: '',
        title: '',
        category: '',
        duration: '',
        level: 'Básico',
        instructor: '',
        price: 150,
        description: '',
        image: 'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=400&auto=format&fit=crop'
      },
      newVideoForm: {
        id: '',
        title: '',
        description: '',
        duration: '10:00',
        views: '1K',
        embedUrl: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        category: 'Educativo',
        thumbnail: 'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?q=80&w=400&auto=format&fit=crop'
      },
      newTriviaForm: {
        theme: '',
        question: '',
        option0: '',
        option1: '',
        option2: '',
        option3: '',
        correctIndex: 0,
        explanation: ''
      },

      // Video Hub modal select state
      selectedVideo: null,

      // Premium Dashboard extra data
      selectedMapNodeInfo: null,
      compliancePercent: 40,
      complianceQuestions: [
        { text: '¿Cuenta con un Manual Interno de Políticas y Procedimientos de Datos?', checked: true },
        { text: '¿Posee un Oficial de Protección de Datos (DPO) designado?', checked: false },
        { text: '¿Tiene implementados Avisos de Privacidad en sus puntos de captura?', checked: true },
        { text: '¿Ha registrado sus bases de datos ante la SIC (RNBD)?', checked: false },
        { text: '¿Cuenta con un protocolo de respuesta y reporte de brechas de seguridad?', checked: false }
      ],
      customAlertTopics: [
        { name: 'Protección de Datos', icon: 'shield', enabled: true },
        { name: 'Gobierno de Datos', icon: 'database', enabled: false },
        { name: 'Inteligencia Artificial', icon: 'sparkles', enabled: true },
        { name: 'Contratación Estatal', icon: 'gavel', enabled: false }
      ]
    };
  },
  computed: {
    hasFiltersActive() {
      return this.filterType || this.filterSector || this.filterStatus || this.filterYear || this.filterCountry;
    },
    filteredNorms() {
      return this.normsData.filter(norm => {
        // Query search
        const query = this.librarySearchQuery ? this.librarySearchQuery.toLowerCase().trim() : '';
        if (query) {
          const matchTitle = norm.title ? norm.title.toLowerCase().includes(query) : false;
          const matchFull = norm.fullName ? norm.fullName.toLowerCase().includes(query) : false;
          const matchSummary = norm.summary ? norm.summary.toLowerCase().includes(query) : false;
          
          let matchKeywords = false;
          if (norm.keywords) {
            if (Array.isArray(norm.keywords)) {
              matchKeywords = norm.keywords.some(k => k.toLowerCase().includes(query));
            } else if (typeof norm.keywords === 'string') {
              matchKeywords = norm.keywords.toLowerCase().includes(query);
            }
          }

          if (!matchTitle && !matchFull && !matchSummary && !matchKeywords) {
            return false;
          }
        }

        // Dropdown filters
        if (this.filterType && norm.type !== this.filterType) return false;
        if (this.filterSector && norm.sector !== this.filterSector) return false;
        if (this.filterStatus && norm.status !== this.filterStatus) return false;
        if (this.filterYear && norm.year && norm.year.toString() !== this.filterYear) return false;
        if (this.filterCountry && norm.country !== this.filterCountry) return false;

        return true;
      });
    },
    cartSubtotal() {
      return this.cart.reduce((sum, item) => sum + item.price, 0);
    },
    cartTotal() {
      return Math.max(0, this.cartSubtotal - this.discount);
    },
    currentQuestion() {
      return this.triviaData[this.currentQuestionIndex];
    }
  },
  watch: {
    currentTab() {
      // Re-trigger icon compilation on tab changes
      this.recompileIcons();
    },
    selectedNorm() {
      this.recompileIcons();
    },
    activeExpertProfile() {
      this.recompileIcons();
    },
    showConsultancyModal() {
      this.recompileIcons();
    },
    selectedVideo() {
      this.recompileIcons();
    },
    adminActivePanel() {
      this.recompileIcons();
    },
    adminActiveContentForm() {
      this.recompileIcons();
    }
  },
  mounted() {
    this.loadAllData();
    this.recompileIcons();
    this.checkUserSession();
  },
  methods: {
    recompileIcons() {
      this.$nextTick(() => {
        if (window.lucide) {
          window.lucide.createIcons();
        }
      });
    },

    loadNormToEdit() {
      if (!this.editingNormId) {
        this.newNormForm = { title: '', type: 'Ley', fullName: '', summary: '', content: '', sector: 'Tecnología', entity: 'Congreso', keywords: '', relatedVideoId: '' };
        return;
      }
      const norm = this.normsData.find(n => n.id === this.editingNormId);
      if (norm) {
        this.newNormForm = { ...norm, keywords: norm.keywords ? norm.keywords.join(', ') : '' };
      }
    },
    loadVideoToEdit() {
      if (!this.editingVideoId) {
        this.newVideoForm = { id: '', title: '', description: '', duration: '', views: '', embedUrl: '', category: 'Educativo', thumbnail: '' };
        return;
      }
      const video = this.youtubeVideosData.find(v => v.id === this.editingVideoId);
      if (video) this.newVideoForm = { ...video };
    },
    loadExpertToEdit() {
      if (!this.editingExpertId) {
        this.newExpertForm = { name: '', photo: '', specialty: '', experience: '', certifications: '', successCases: '', publications: '', videoUrl: '', price: '', rating: 5.0, reviews: 0 };
        return;
      }
      const expert = this.expertsData.find(e => e.id === this.editingExpertId);
      if (expert) this.newExpertForm = { ...expert, certifications: expert.certifications ? expert.certifications.join(', ') : '', publications: expert.publications ? expert.publications.join(', ') : '' };
    },
    loadCourseToEdit() {
      if (!this.editingCourseId) {
        this.newCourseForm = { title: '', category: '', duration: '', level: 'Básico', instructor: '', price: '', description: '', modulesCount: 4, badge: '', image: '' };
        return;
      }
      const course = this.coursesData.find(c => c.id === this.editingCourseId);
      if (course) this.newCourseForm = { ...course };
    },
    loadTriviaToEdit() {
      if (!this.editingTriviaId) {
        this.newTriviaForm = { theme: '', question: '', option0: '', option1: '', option2: '', option3: '', correctIndex: 0, explanation: '' };
        return;
      }
      const trivia = this.triviaData.find(t => t.id === this.editingTriviaId);
      if (trivia) {
        this.newTriviaForm = {
          theme: trivia.theme,
          question: trivia.question,
          option0: trivia.options[0] || '',
          option1: trivia.options[1] || '',
          option2: trivia.options[2] || '',
          option3: trivia.options[3] || '',
          correctIndex: trivia.correctIndex,
          explanation: trivia.explanation
        };
      }
    },

    async saveLogoSettings() {
      localStorage.setItem('legalcol_logo_url', this.logoUrl);
      localStorage.setItem('legalcol_logo_width', this.logoWidth.toString());
      if (this.isSupabaseConnected) {
        try {
          await saveSystemSetting('logo_url', this.logoUrl);
          await saveSystemSetting('logo_width', this.logoWidth.toString());
        } catch (e) {
          console.error('Error al guardar logo en Supabase:', e);
        }
      }
    },
    async resetLogoSettings() {
      this.logoUrl = '/Logo.jpg';
      this.logoWidth = 120;
      await this.saveLogoSettings();
      alert('Logo restaurado por defecto.');
    },
    handleLogoUpload(event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = async (e) => {
          this.logoUrl = e.target.result;
          await this.saveLogoSettings();
        };
        reader.readAsDataURL(file);
      }
    },

    async saveHomeSettings() {
      localStorage.setItem('legalcol_home_hero_badge', this.homeHeroBadge);
      localStorage.setItem('legalcol_home_hero_title', this.homeHeroTitle);
      localStorage.setItem('legalcol_home_hero_subtitle', this.homeHeroSubtitle);
      localStorage.setItem('legalcol_home_stat1_val', this.homeStat1Value);
      localStorage.setItem('legalcol_home_stat1_lbl', this.homeStat1Label);
      localStorage.setItem('legalcol_home_stat2_val', this.homeStat2Value);
      localStorage.setItem('legalcol_home_stat2_lbl', this.homeStat2Label);
      localStorage.setItem('legalcol_home_stat3_val', this.homeStat3Value);
      localStorage.setItem('legalcol_home_stat3_lbl', this.homeStat3Label);
      localStorage.setItem('legalcol_home_featured_videoid', this.homeFeaturedVideoId);
      localStorage.setItem('legalcol_home_featured_videowidth', this.homeFeaturedVideoWidth.toString());
      localStorage.setItem('legalcol_home_search_width', this.homeSearchWidth);

      if (this.isSupabaseConnected) {
        try {
          await saveSystemSetting('home_hero_badge', this.homeHeroBadge);
          await saveSystemSetting('home_hero_title', this.homeHeroTitle);
          await saveSystemSetting('home_hero_subtitle', this.homeHeroSubtitle);
          await saveSystemSetting('home_stat1_val', this.homeStat1Value);
          await saveSystemSetting('home_stat1_lbl', this.homeStat1Label);
          await saveSystemSetting('home_stat2_val', this.homeStat2Value);
          await saveSystemSetting('home_stat2_lbl', this.homeStat2Label);
          await saveSystemSetting('home_stat3_val', this.homeStat3Value);
          await saveSystemSetting('home_stat3_lbl', this.homeStat3Label);
          await saveSystemSetting('home_featured_videoid', this.homeFeaturedVideoId);
          await saveSystemSetting('home_featured_videowidth', this.homeFeaturedVideoWidth.toString());
          await saveSystemSetting('home_search_width', this.homeSearchWidth);
        } catch (e) {
          console.error('Error al guardar inicio en Supabase:', e);
        }
      }
      alert('Configuración de inicio guardada con éxito.');
    },
    async resetHomeSettings() {
      this.homeHeroBadge = 'PREMIUM ECOSYSTEM';
      this.homeHeroTitle = 'Encuentre cualquier norma, ley o regulación <span class="gradient-text">en segundos</span>';
      this.homeHeroSubtitle = 'La plataforma inteligente de clase mundial que combina una biblioteca jurídica digital con análisis de Inteligencia Artificial, academia de cumplimiento y consultoría especializada.';
      this.homeStat1Value = '15K+';
      this.homeStat1Label = 'Documentos';
      this.homeStat2Value = '99.8%';
      this.homeStat2Label = 'Precisión IA';
      this.homeStat3Value = '24/7';
      this.homeStat3Label = 'Asesoría Activa';
      this.homeFeaturedVideoId = '';
      this.homeFeaturedVideoWidth = 550;
      this.homeSearchWidth = '780px';
      await this.saveHomeSettings();
    },

    // Session and Auth management
    async checkUserSession() {
      if (!this.isSupabaseConnected) return;
      try {
        const session = await getCurrentUserSession();
        if (session) {
          this.currentUserSession = session;
          this.currentUserRole = session.profile.role || 'user';
        } else {
          this.currentUserSession = null;
          this.currentUserRole = 'guest';
        }
      } catch (e) {
        console.error('Error verificando sesión:', e);
      }
    },

    async handleAuthSubmit() {
      if (this.authTab === 'login') {
        await this.handleLogin();
      } else {
        await this.handleRegister();
      }
    },

    async handleRegister() {
      this.isAuthLoading = true;
      try {
        // Si no hay Supabase conectado, registrar localmente
        if (!this.isSupabaseConnected) {
          throw new Error('Supabase offline — usando registro local');
        }
        await signUpUser(this.authEmail, this.authPassword, this.authFullName, this.authRoleSelection);
        // Automáticamente iniciar sesión después del registro exitoso
        await signInUser(this.authEmail, this.authPassword);
        await this.checkUserSession();
        this.showAuthModal = false;
        this.authEmail = '';
        this.authPassword = '';
        this.authFullName = '';
      } catch (e) {
        // Fallback: registrar y loguear localmente en modo demo
        if (!this.isSupabaseConnected || e.message.includes('offline') || e.message.includes('registro local')) {
          this.currentUserSession = {
            auth: { id: 'local-' + Date.now(), email: this.authEmail, user_metadata: { role: this.authRoleSelection, full_name: this.authFullName || this.authEmail } },
            profile: { id: 'local-' + Date.now(), email: this.authEmail, full_name: this.authFullName || this.authEmail, role: this.authRoleSelection }
          };
          this.currentUserRole = this.authRoleSelection;
          this.showAuthModal = false;
          this.authEmail = '';
          this.authPassword = '';
          this.authFullName = '';
        } else {
          console.error(e);
          alert('Error al registrar: ' + e.message);
        }
      } finally {
        this.isAuthLoading = false;
      }
    },

    async handleLogin() {
      this.isAuthLoading = true;
      try {
        // Shortcut local para admin sin Supabase
        if (!this.isSupabaseConnected && this.authEmail === 'admin@legalcol.com' && this.authPassword === 'AdminLegalCol2026!') {
          throw new Error('shortcut-local-admin');
        }

        await signInUser(this.authEmail, this.authPassword);
        await this.checkUserSession();
        this.showAuthModal = false;
        this.authEmail = '';
        this.authPassword = '';
        this.authFullName = '';
      } catch (e) {
        // Fallback admin local
        if (this.authEmail === 'admin@legalcol.com' && this.authPassword === 'AdminLegalCol2026!') {
          this.currentUserSession = {
            auth: { id: 'mock-admin-id', email: 'admin@legalcol.com', user_metadata: { role: 'admin', full_name: 'Administrador Local (Demo)' } },
            profile: { id: 'mock-admin-id', email: 'admin@legalcol.com', full_name: 'Administrador Local (Demo)', role: 'admin' }
          };
          this.currentUserRole = 'admin';
          this.showAuthModal = false;
          this.authEmail = '';
          this.authPassword = '';
          this.authFullName = '';
        } else {
          console.error(e);
          alert('Credenciales incorrectas. Por favor verifica tu correo y contraseña.');
        }
      } finally {
        this.isAuthLoading = false;
      }
    },

    async handleLogout() {
      try {
        await signOutUser();
        this.currentUserSession = null;
        this.currentUserRole = 'guest';
        alert('Sesión cerrada correctamente.');
        this.currentTab = 'home';
      } catch (e) {
        console.error(e);
      }
    },

    // Dynamic Deletions (CRUD for Admins)
    async deleteNormEntry(id) {
      if (!id || !confirm('¿Eliminar esta normativa permanentemente?')) return;
      if (this.isSupabaseConnected) {
        try { await deleteNorm(id); await this.loadAllData(); }
        catch (e) { alert('Error: ' + e.message); }
      } else {
        this.normsData = this.normsData.filter(n => n.id !== id);
      }
      this.clearCmsForm();
    },

    async deleteExpertEntry(id) {
      if (!id || !confirm('¿Eliminar este experto permanentemente?')) return;
      if (this.isSupabaseConnected) {
        try { await deleteExpert(id); await this.loadAllData(); }
        catch (e) { alert('Error: ' + e.message); }
      } else {
        this.expertsData = this.expertsData.filter(e => e.id !== id);
      }
      this.clearCmsForm();
    },

    async deleteCourseEntry(id) {
      if (!id || !confirm('¿Eliminar este curso permanentemente?')) return;
      if (this.isSupabaseConnected) {
        try { await deleteCourse(id); await this.loadAllData(); }
        catch (e) { alert('Error: ' + e.message); }
      } else {
        this.coursesData = this.coursesData.filter(c => c.id !== id);
      }
      this.clearCmsForm();
    },

    async deleteTriviaQuestionEntry(id) {
      if (!id || !confirm('¿Eliminar esta pregunta de trivia permanentemente?')) return;
      if (this.isSupabaseConnected) {
        try { await deleteTriviaQuestion(id); await this.loadAllData(); }
        catch (e) { alert('Error: ' + e.message); }
      } else {
        this.triviaData = this.triviaData.filter(q => q.id !== id);
      }
      this.clearCmsForm();
    },

    async deleteYoutubeVideoEntry(id) {
      if (!id || !confirm('¿Eliminar este video permanentemente?')) return;
      if (this.isSupabaseConnected) {
        try { await deleteYoutubeVideo(id); await this.loadAllData(); }
        catch (e) { alert('Error: ' + e.message); }
      } else {
        this.youtubeVideosData = this.youtubeVideosData.filter(v => v.id !== id);
      }
      this.clearCmsForm();
    },

    async loadAllData() {
      const credentials = getSavedCredentials();
      this.supabaseUrl = credentials.url;
      this.supabaseKey = credentials.key;
      
      const connected = await testConnection();
      if (connected === true) {
        this.isSupabaseConnected = true;
        this.connectionStatusText = 'Conectado';
        try {
          const dbNorms = await fetchNorms();
          if (dbNorms) this.normsData = dbNorms;
          
          const dbExperts = await fetchExperts();
          if (dbExperts) this.expertsData = dbExperts;
          
          const dbCourses = await fetchCourses();
          if (dbCourses) this.coursesData = dbCourses;
          
          const dbTrivia = await fetchTriviaQuestions();
          if (dbTrivia) this.triviaData = dbTrivia;
          
          const dbVideos = await fetchYoutubeVideos();
          if (dbVideos) this.youtubeVideosData = dbVideos;

          // Cargar configuraciones del sistema desde la base de datos
          const dbSettings = await fetchSystemSettings();
          if (dbSettings && dbSettings.length > 0) {
            dbSettings.forEach(s => {
              if (s.key === 'logo_url') this.logoUrl = s.value;
              if (s.key === 'logo_width') this.logoWidth = parseInt(s.value);
              if (s.key === 'home_hero_badge') this.homeHeroBadge = s.value;
              if (s.key === 'home_hero_title') this.homeHeroTitle = s.value;
              if (s.key === 'home_hero_subtitle') this.homeHeroSubtitle = s.value;
              if (s.key === 'home_stat1_val') this.homeStat1Value = s.value;
              if (s.key === 'home_stat1_lbl') this.homeStat1Label = s.value;
              if (s.key === 'home_stat2_val') this.homeStat2Value = s.value;
              if (s.key === 'home_stat2_lbl') this.homeStat2Label = s.value;
              if (s.key === 'home_stat3_val') this.homeStat3Value = s.value;
              if (s.key === 'home_stat3_lbl') this.homeStat3Label = s.value;
              if (s.key === 'home_featured_videoid') this.homeFeaturedVideoId = s.value;
              if (s.key === 'home_featured_videowidth') this.homeFeaturedVideoWidth = parseInt(s.value);
              if (s.key === 'home_search_width') this.homeSearchWidth = s.value;
            });
          }
        } catch (e) {
          console.error('Error al cargar datos desde Supabase:', e);
        }
      } else if (connected === 'table_missing') {
        this.isSupabaseConnected = true;
        this.connectionStatusText = 'Conectado (Faltan Tablas)';
      } else {
        this.isSupabaseConnected = false;
        this.connectionStatusText = 'Desconectado / Error de credenciales';
        // Fallback a los datos locales y localStorage
        this.logoUrl = localStorage.getItem('legalcol_logo_url') || '/Logo.jpg';
        this.logoWidth = parseInt(localStorage.getItem('legalcol_logo_width') || '120');
        this.homeHeroBadge = localStorage.getItem('legalcol_home_hero_badge') || 'PREMIUM ECOSYSTEM';
        this.homeHeroTitle = localStorage.getItem('legalcol_home_hero_title') || 'Encuentre cualquier norma, ley o regulación <span class="gradient-text">en segundos</span>';
        this.homeHeroSubtitle = localStorage.getItem('legalcol_home_hero_subtitle') || 'La plataforma inteligente de clase mundial que combina una biblioteca jurídica digital con análisis de Inteligencia Artificial, academia de cumplimiento y consultoría especializada.';
        this.homeStat1Value = localStorage.getItem('legalcol_home_stat1_val') || '15K+';
        this.homeStat1Label = localStorage.getItem('legalcol_home_stat1_lbl') || 'Documentos';
        this.homeStat2Value = localStorage.getItem('legalcol_home_stat2_val') || '99.8%';
        this.homeStat2Label = localStorage.getItem('legalcol_home_stat2_lbl') || 'Precisión IA';
        this.homeStat3Value = localStorage.getItem('legalcol_home_stat3_val') || '24/7';
        this.homeStat3Label = localStorage.getItem('legalcol_home_stat3_lbl') || 'Asesoría Activa';
        this.homeFeaturedVideoId = localStorage.getItem('legalcol_home_featured_videoid') || '';
        this.homeFeaturedVideoWidth = parseInt(localStorage.getItem('legalcol_home_featured_videowidth') || '550');
        this.homeSearchWidth = localStorage.getItem('legalcol_home_search_width') || '780px';

        this.normsData = [];
        this.expertsData = [];
        this.coursesData = [];
        this.triviaData = [];
        this.youtubeVideosData = [];
      }
      this.recompileIcons();
    },

    async updateSupabaseConfig() {
      this.isTestingConnection = true;
      saveCredentials(this.supabaseUrl, this.supabaseKey);
      await this.loadAllData();
      this.isTestingConnection = false;
      this.recompileIcons();
    },

    async saveAndTestSupabase() {
      await this.updateSupabaseConfig();
      if (this.isSupabaseConnected) {
        alert('Supabase conectado y credenciales guardadas exitosamente.');
      } else {
        alert('Error al conectar. Verifica las credenciales e inténtalo de nuevo.');
      }
    },

    async syncMockDataToSupabase() {
      if (!this.isSupabaseConnected) {
        alert('Conéctese primero a Supabase.');
        return;
      }
      this.isSyncingDb = true;
      try {
        await insertNorms(norms);
        await insertExperts(experts);
        await insertCourses(courses);
        await insertTriviaQuestions(triviaQuestions);
        await insertYoutubeVideos(youtubeVideos);

        // Poblado inicial de las configuraciones de marca e inicio
        await insertDefaultSystemSettings([
          { key: 'logo_url', value: this.logoUrl },
          { key: 'logo_width', value: this.logoWidth.toString() },
          { key: 'home_hero_badge', value: this.homeHeroBadge },
          { key: 'home_hero_title', value: this.homeHeroTitle },
          { key: 'home_hero_subtitle', value: this.homeHeroSubtitle },
          { key: 'home_stat1_val', value: this.homeStat1Value },
          { key: 'home_stat1_lbl', value: this.homeStat1Label },
          { key: 'home_stat2_val', value: this.homeStat2Value },
          { key: 'home_stat2_lbl', value: this.homeStat2Label },
          { key: 'home_stat3_val', value: this.homeStat3Value },
          { key: 'home_stat3_lbl', value: this.homeStat3Label },
          { key: 'home_featured_videoid', value: this.homeFeaturedVideoId || '' },
          { key: 'home_featured_videowidth', value: this.homeFeaturedVideoWidth.toString() },
          { key: 'home_search_width', value: this.homeSearchWidth }
        ]);

        alert('Base de datos de Supabase inicializada y configuraciones guardadas.');
        await this.loadAllData();
      } catch (e) {
        console.error(e);
        alert('Error al inicializar datos: ' + e.message);
      } finally {
        this.isSyncingDb = false;
      }
    },
    
    // Quick search from Home page Hero
    triggerQuickSearch() {
      this.librarySearchQuery = this.searchQuery;
      this.currentTab = 'library';
    },

    // Interactive Knowledge Map
    selectMapNode(nodeId) {
      const found = this.normsData.find(n => n.id === nodeId);
      if (found) {
        this.selectedMapNodeInfo = found;
      }
    },
    resetKnowledgeMap() {
      this.selectedMapNodeInfo = null;
    },

    // Compliance module
    recalculateCompliance() {
      const checkedCount = this.complianceQuestions.filter(q => q.checked).length;
      this.compliancePercent = Math.round((checkedCount / this.complianceQuestions.length) * 100);
    },
    generateActionPlanDocument() {
      alert(`[Descarga Simulada] Generando reporte oficial de Cumplimiento en PDF...\n\nNivel de cumplimiento: ${this.compliancePercent}%\n\nPendientes:\n` + 
        this.complianceQuestions.filter(q => !q.checked).map(q => `• ${q.text}`).join('\n')
      );
    },

    // Alerts customization
    saveAlertPreferences() {
      // Auto-save message helper
      console.log('Preferencia de alerta guardada:', this.customAlertTopics);
    },

    // Contract analysis simulation
    simulateContractAnalysis(event) {
      const file = event.target.files[0];
      if (file) {
        alert(`Analizando archivo "${file.name}" con Inteligencia Artificial...\n\nResultados en 3 segundos.`);
        setTimeout(() => {
          this.chatContextNorm = null;
          this.currentTab = 'ia';
          this.chatHistory.push({
            sender: 'assistant',
            text: `<strong>Análisis de Contrato (${file.name}):</strong><br/>` +
              `⚠️ <strong>Riesgos Críticos:</strong> Cláusula de indemnidad desequilibrada (Sección 8.2), Jurisdicción no favorable en caso de litigio (Sección 12).<br/>` +
              `💡 <strong>Recomendación:</strong> Negociar límite de responsabilidad al 100% del valor del contrato y cambiar foro a Bogotá, Colombia.`,
            time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          });
          this.scrollToChatBottom();
        }, 1500);
      }
    },
    
    selectCategoryFilter(type) {
      this.resetFilters();
      this.filterType = type;
      this.currentTab = 'library';
    },

    resetFilters() {
      this.filterType = '';
      this.filterSector = '';
      this.filterStatus = '';
      this.filterYear = '';
      this.filterCountry = '';
      this.librarySearchQuery = '';
      this.searchQuery = '';
    },

    // Visor options
    viewNormDetails(norm) {
      this.selectedNorm = norm;
    },

    downloadPDF(norm) {
      if (!norm) return;
      let targetNorm = norm;
      if (!norm.pdfUrl && norm.title && this.normsData) {
        const found = this.normsData.find(n => n.title === norm.title || (this.selectedVideo && n.relatedVideoId === this.selectedVideo.id));
        if (found) {
          targetNorm = found;
        }
      }
      if (targetNorm && targetNorm.pdfUrl) {
        window.open(targetNorm.pdfUrl, '_blank');
      } else {
        alert(`No hay un archivo PDF oficial asociado para la norma "${targetNorm ? targetNorm.title : 'seleccionada'}". Puede asignarle un enlace PDF editando la norma en el panel de administración.`);
      }
    },

    toggleFavorite(norm) {
      const idx = this.favorites.indexOf(norm.id);
      if (idx > -1) {
        this.favorites.splice(idx, 1);
        alert(`Norma eliminada de Favoritos.`);
      } else {
        this.favorites.push(norm.id);
        alert(`Norma agregada con éxito a sus Favoritos.`);
      }
    },

    isFavorite(id) {
      return this.favorites.includes(id);
    },

    shareNorm(norm) {
      navigator.clipboard.writeText(window.location.href);
      alert(`¡Enlace copiado al portapapeles para compartir la norma: ${norm.title}!`);
    },

    printNorm() {
      window.print();
    },

    consultExpertFromVisor(norm) {
      this.selectedNorm = null;
      this.currentTab = 'marketplace';
      alert(`Consulte a continuación con nuestros expertos sobre la aplicabilidad de la norma: ${norm.title}`);
    },

    // AI Chat Panel
    openAIConversationForNorm(norm) {
      this.selectedNorm = null;
      this.chatContextNorm = norm;
      this.currentTab = 'ia';
      
      this.chatHistory.push({
        sender: 'assistant',
        text: `He fijado el contexto de análisis en la norma <strong>${norm.fullName}</strong>. ¿Qué duda legal o técnica tiene al respecto de su aplicación?`,
        time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
      });
      this.scrollToChatBottom();
    },

    applySuggestion(text) {
      this.chatInput = text;
      this.sendChatMessage();
    },

    sendChatMessage() {
      if (!this.chatInput.trim()) return;

      const userText = this.chatInput;
      this.chatHistory.push({
        sender: 'user',
        text: userText,
        time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
      });

      this.chatInput = '';
      this.isBotTyping = true;
      this.scrollToChatBottom();

      // Simulate IA thinking and responding
      setTimeout(() => {
        this.isBotTyping = false;
        let responseText = '';

        if (this.chatContextNorm) {
          // Response based on norm context
          if (userText.toLowerCase().includes('obligaci') || userText.toLowerCase().includes('debo') || userText.toLowerCase().includes('cumplir')) {
            responseText = `Bajo el marco de la norma <strong>${this.chatContextNorm.title}</strong>, las obligaciones críticas de cumplimiento son:<br/>` + 
              this.chatContextNorm.aiObligations.map(o => `• ${o}`).join('<br/>') + 
              `<br/><br/>¿Desea que simulemos un diagnóstico del estado actual de su empresa?`;
          } else {
            responseText = `Con relación a su pregunta sobre <strong>${this.chatContextNorm.title}</strong>, le informo que esta disposición regula ${this.chatContextNorm.summary.toLowerCase()}<br/><br/>` + 
              `<strong>Análisis de IA:</strong> ${this.chatContextNorm.aiSummary}`;
          }
        } else {
          // General AI query
          responseText = `Entiendo su consulta. A nivel general en Latinoamérica, los estándares regulatorios vigentes exigen altos controles. ` +
            `Por ejemplo, en materia de <strong>Protección de Datos</strong> la Ley 1581 establece auditorías periódicas y respuesta de brechas de seguridad obligatorias. ` +
            `¿Le gustaría profundizar en alguna de estas normas o hablar con uno de nuestros expertos en Ciberderecho?`;
        }

        this.chatHistory.push({
          sender: 'assistant',
          text: responseText,
          time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        });
        this.scrollToChatBottom();
      }, 1200);
    },

    clearChat() {
      this.chatHistory = [
        {
          sender: 'assistant',
          text: '¡Hola! Soy su Asistente Legal con IA. ¿En qué norma o regulación específica le gustaría profundizar hoy?',
          time: 'Ahora'
        }
      ];
    },

    scrollToChatBottom() {
      this.$nextTick(() => {
        const container = this.$refs.chatMessagesContainer;
        if (container) {
          container.scrollTop = container.scrollHeight;
        }
      });
    },

    // Marketplace / Services
    viewExpertProfile(expert) {
      this.activeExpertProfile = expert;
    },

    bookExpertAppointment(expert) {
      alert(`[Integración Calendly] Abriendo agenda de ${expert.name}. Sesión de Diagnóstico gratuito reservada.`);
    },

    hireExpertConsulting(expert) {
      this.addToCart(`Consultoría Especializada - ${expert.name}`, expert.price);
    },

    addToCart(name, price) {
      this.cart.push({ name, price });
      alert(`"${name}" ha sido agregado al carrito de compras.`);
    },

    removeFromCart(index) {
      this.cart.splice(index, 1);
    },

    applyCoupon() {
      if (this.couponCode.trim().toUpperCase() === 'DESCUENTO10') {
        this.discount = 10;
        this.couponApplied = 'DESCUENTO10';
        alert('Cupón de descuento aplicado con éxito.');
      } else {
        alert('Código de cupón no válido.');
      }
    },

    triggerCheckout() {
      alert(`[Pago en línea Stripe/PayU] Redirigiendo a pasarela segura de pago por un total de $${this.cartTotal} USD. ¡Gracias por confiar en LegalCol!`);
      this.cart = [];
      this.discount = 0;
      this.couponCode = '';
      this.couponApplied = '';
    },

    // Academy & Cursos
    buyCourse(course) {
      this.addToCart(`Curso: ${course.title}`, course.price);
      this.currentTab = 'marketplace';
    },

    // Quiz Kahoot-like Game
    startQuiz() {
      this.quizState = 'running';
      this.currentQuestionIndex = 0;
      this.quizScore = 0;
      this.quizAnswers = [];
      this.startTimer();
    },

    startTimer() {
      this.quizTimer = 15;
      if (this.quizTimerInterval) clearInterval(this.quizTimerInterval);
      
      this.quizTimerInterval = setInterval(() => {
        this.quizTimer--;
        if (this.quizTimer <= 0) {
          this.submitQuizAnswer(-1); // timeout
        }
      }, 1000);
    },

    submitQuizAnswer(selectedIndex) {
      clearInterval(this.quizTimerInterval);
      
      const correct = this.currentQuestion.correctIndex;
      const isCorrect = selectedIndex === correct;
      
      if (isCorrect) {
        this.quizScore++;
        this.userPoints += 50;
      }
      
      // Next or finish
      if (this.currentQuestionIndex + 1 < this.triviaData.length) {
        this.currentQuestionIndex++;
        this.startTimer();
      } else {
        this.quizState = 'finished';
        if (this.quizScore === this.triviaData.length) {
          this.userBadges.push("Cumplimiento Perfecto");
        }
      }
    },

    resetQuiz() {
      this.quizState = 'idle';
      if (this.quizTimerInterval) clearInterval(this.quizTimerInterval);
    },

    downloadQuizCertificate() {
      alert(`[Descarga PDF] Su certificado oficial emitido por la Academia LegalCol con código único de verificación ha sido generado.`);
    },

    // Membresías
    changeMembershipPlan(plan) {
      this.currentMembership = plan;
      alert(`¡Membresía actualizada con éxito al plan: ${plan}!`);
    },

    simulateInvoiceDownload() {
      alert('Descargando factura en formato PDF de la última renovación del plan.');
    },

    cancelSubscription() {
      if (confirm('¿Está seguro de que desea cancelar la renovación de su membresía? Perderá el acceso prioritario al finalizar el ciclo.')) {
        this.currentMembership = 'Gratuito';
        alert('Su renovación ha sido cancelada correctamente.');
      }
    },

    // Consultancy / Help Modal
    openConsultancyModal() {
      this.showConsultancyModal = true;
      this.showDiagnosisForm = false;
    },

    simulateCalendly() {
      alert('Abriendo ventana flotante integrada de Calendly... Seleccione su hora para la videollamada de asesoría.');
    },

    openDiagnosisForm() {
      this.showDiagnosisForm = true;
    },

    submitDiagnosis() {
      alert(`¡Gracias! Su solicitud de Diagnóstico Gratuito para "${this.diagnosisData.companyName}" ha sido recibida. Un consultor se contactará al correo ${this.diagnosisData.email} en menos de 2 horas.`);
      this.showDiagnosisForm = false;
      this.showConsultancyModal = false;
      this.diagnosisData = { companyName: '', email: '', description: '' };
    },

    // Admin Panel Actions
    async addNewNorm() {
      const id = this.editingNormId ? this.editingNormId : this.newNormForm.title.toLowerCase().replace(/ /g, '-').replace(/[^a-z0-9-]/g, '');
      const keywordsArray = this.newNormForm.keywords ? this.newNormForm.keywords.split(',').map(k => k.trim()) : ["Norma", "Regulación"];
      const mockNorm = {
        id,
        type: this.newNormForm.type,
        title: this.newNormForm.title,
        fullName: this.newNormForm.fullName,
        summary: this.newNormForm.summary,
        date: this.editingNormId && this.newNormForm.date ? this.newNormForm.date : new Date().toISOString().split('T')[0],
        year: this.editingNormId && this.newNormForm.year ? Number(this.newNormForm.year) : new Date().getFullYear(),
        status: this.editingNormId && this.newNormForm.status ? this.newNormForm.status : "Vigente",
        sector: this.newNormForm.sector || "Tecnología y Telecomunicaciones",
        entity: this.newNormForm.entity || "Superintendencia",
        keywords: keywordsArray,
        country: this.editingNormId && this.newNormForm.country ? this.newNormForm.country : "Colombia",
        content: this.newNormForm.content || "Texto oficial de la norma...",
        pdfUrl: this.newNormForm.pdfUrl || null,
        aiSummary: this.editingNormId && this.newNormForm.aiSummary ? this.newNormForm.aiSummary : "Resumen IA generado de forma automática.",
        aiObligations: this.editingNormId && this.newNormForm.aiObligations ? this.newNormForm.aiObligations : [
          "Cumplir con las directrices normativas.",
          "Garantizar la actualización de los manuales de cumplimiento corporativo."
        ],
        relatedVideoId: this.newNormForm.relatedVideoId || null
      };
      
      if (this.isSupabaseConnected) {
        try {
          await insertNorms([mockNorm]);
          alert(this.editingNormId ? `Normativa actualizada de forma persistente.` : `Normativa registrada de forma persistente en la Base de Datos.`);
        } catch (e) {
          console.error(e);
          alert(`Error al guardar en base de datos: ` + e.message);
        }
      } else {
        if (this.editingNormId) {
          const idx = this.normsData.findIndex(n => n.id === this.editingNormId);
          if (idx !== -1) this.normsData.splice(idx, 1, mockNorm);
          alert(`Normativa actualizada temporalmente en memoria.`);
        } else {
          this.normsData.unshift(mockNorm);
          alert(`Normativa registrada temporalmente en memoria (modo local).`);
        }
      }
      
      await this.loadAllData();
      this.editingNormId = '';
      this.newNormForm = { title: '', type: 'Ley', fullName: '', summary: '', content: '', sector: 'Tecnología', entity: 'Congreso', keywords: '', relatedVideoId: '' };
      this.currentTab = 'library';
    },

    async addNewExpert() {
      const mockExpert = {
        id: this.editingExpertId ? this.editingExpertId : this.newExpertForm.id.toLowerCase().replace(/ /g, '-'),
        name: this.newExpertForm.name,
        photo: this.newExpertForm.photo,
        specialty: this.newExpertForm.specialty,
        experience: this.newExpertForm.experience,
        certifications: ["Certificación Profesional LegalCol"],
        successCases: "Caso de éxito registrado en el panel administrativo.",
        publications: ["Publicaciones e Informes de Cumplimiento"],
        videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ",
        price: Number(this.newExpertForm.price),
        rating: 5.0,
        reviews: 1
      };

      if (this.isSupabaseConnected) {
        try {
          await insertExperts([mockExpert]);
          alert(this.editingExpertId ? 'Experto actualizado en la Base de Datos.' : 'Experto registrado de forma persistente en la Base de Datos.');
        } catch (e) {
          console.error(e);
          alert('Error al guardar experto: ' + e.message);
        }
      } else {
        if (this.editingExpertId) {
          const idx = this.expertsData.findIndex(e => e.id === this.editingExpertId);
          if (idx !== -1) this.expertsData.splice(idx, 1, mockExpert);
          alert('Experto actualizado temporalmente en memoria.');
        } else {
          this.expertsData.unshift(mockExpert);
          alert('Experto registrado temporalmente en memoria.');
        }
      }
      await this.loadAllData();
      this.editingExpertId = '';
      this.newExpertForm = { id: '', name: '', photo: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=256&auto=format&fit=crop', specialty: '', experience: '', price: 100 };
      this.currentTab = 'marketplace';
    },

    async addNewCourse() {
      const mockCourse = {
        id: this.newCourseForm.id.toLowerCase().replace(/ /g, '-'),
        title: this.newCourseForm.title,
        category: this.newCourseForm.category,
        duration: this.newCourseForm.duration,
        level: this.newCourseForm.level,
        instructor: this.newCourseForm.instructor,
        price: Number(this.newCourseForm.price),
        description: this.newCourseForm.description,
        modulesCount: 5,
        badge: "Insignia Academia",
        image: this.newCourseForm.image
      };

      if (this.isSupabaseConnected) {
        try {
          await insertCourses([mockCourse]);
          alert('Curso registrado de forma persistente en la Base de Datos.');
        } catch (e) {
          console.error(e);
          alert('Error al guardar curso: ' + e.message);
        }
      } else {
        this.coursesData.unshift(mockCourse);
        alert('Curso registrado en memoria.');
      }
      this.newCourseForm = { id: '', title: '', category: '', duration: '', level: 'Básico', instructor: '', price: 150, description: '', image: 'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=400&auto=format&fit=crop' };
      this.currentTab = 'academy';
    },
    async addNewVideo() {
      let extractedId = '';
      let urlInput = this.newVideoForm.id ? this.newVideoForm.id.trim() : '';
      let embedInput = this.newVideoForm.embedUrl ? this.newVideoForm.embedUrl.trim() : '';

      // 1. Intentar obtener el ID del campo URL/ID
      if (urlInput) {
        const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        const match = urlInput.match(regExp);
        if (match && match[2].length === 11) {
          extractedId = match[2];
        } else if (urlInput.includes('youtube.com/shorts/')) {
          const parts = urlInput.split('youtube.com/shorts/');
          if (parts[1]) extractedId = parts[1].split(/[?#&]/)[0];
        } else if (urlInput.length === 11) {
          extractedId = urlInput;
        }
      }

      // 2. Si no se pudo y hay URL de Embed, intentar extraer de ahí
      if (!extractedId && embedInput) {
        const regExpEmbed = /^.*(embed\/|watch\?v=)([^#\&\?]*).*/;
        const matchEmbed = embedInput.match(regExpEmbed);
        if (matchEmbed && matchEmbed[2].length === 11) {
          extractedId = matchEmbed[2];
        } else {
          // fallback buscar cualquier secuencia de 11 caracteres al final de la URL
          const parts = embedInput.split('/');
          const lastPart = parts[parts.length - 1];
          if (lastPart && lastPart.length === 11) {
            extractedId = lastPart;
          }
        }
      }

      // 3. Si sigue sin ID, usar fallback temporal
      if (!extractedId) {
        extractedId = 'dQw4w9WgXcQ';
      }

      // 4. Formatear adecuadamente
      const finalEmbedUrl = `https://www.youtube.com/embed/${extractedId}`;
      const finalThumbnail = `https://img.youtube.com/vi/${extractedId}/hqdefault.jpg`;
      const idToUse = this.editingVideoId ? this.editingVideoId : extractedId;

      const mockVideo = {
        id: idToUse,
        title: this.newVideoForm.title,
        description: this.newVideoForm.description,
        duration: this.newVideoForm.duration || '10:00',
        views: this.newVideoForm.views || '100',
        embedUrl: finalEmbedUrl,
        category: this.newVideoForm.category || 'Educativo',
        thumbnail: finalThumbnail
      };

      if (this.isSupabaseConnected) {
        try {
          await insertYoutubeVideos([mockVideo]);
          alert(this.editingVideoId ? 'Video actualizado en la Base de Datos.' : 'Video registrado en la Base de Datos.');
          await this.loadAllData();
        } catch (e) {
          console.error(e);
          alert('Error al guardar video: ' + e.message);
        }
      } else {
        if (this.editingVideoId) {
          const idx = this.youtubeVideosData.findIndex(v => v.id === this.editingVideoId);
          if (idx !== -1) this.youtubeVideosData.splice(idx, 1, mockVideo);
          alert('Video actualizado temporalmente en memoria.');
        } else {
          this.youtubeVideosData.unshift(mockVideo);
          alert('Video registrado temporalmente en memoria.');
        }
      }
      this.editingVideoId = '';
      this.newVideoForm = { id: '', title: '', description: '', duration: '10:00', views: '1K', embedUrl: '', category: 'Educativo', thumbnail: '' };
      this.currentTab = 'youtube';
    },

    editNormEntry(norm) {
      this.editingNormId = norm.id;
      this.newNormForm = {
        title: norm.title,
        type: norm.type,
        fullName: norm.fullName,
        summary: norm.summary,
        content: norm.content,
        sector: norm.sector,
        entity: norm.entity,
        keywords: norm.keywords ? (Array.isArray(norm.keywords) ? norm.keywords.join(', ') : norm.keywords) : '',
        relatedVideoId: norm.relatedVideoId || '',
        pdfUrl: norm.pdfUrl || '',
        date: norm.date || '',
        year: norm.year || new Date().getFullYear(),
        status: norm.status || 'Vigente',
        country: norm.country || 'Colombia'
      };
      this.adminActiveContentForm = 'norm';
      this.$nextTick(() => {
        const el = document.querySelector('.admin-panel-card');
        if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    },

    editExpertEntry(expert) {
      this.editingExpertId = expert.id;
      this.newExpertForm = {
        id: expert.id,
        name: expert.name,
        photo: expert.photo,
        specialty: expert.specialty,
        experience: expert.experience,
        price: expert.price
      };
      this.adminActiveContentForm = 'expert';
      this.$nextTick(() => {
        const el = document.querySelector('.admin-panel-card');
        if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    },

    editCourseEntry(course) {
      this.editingCourseId = course.id;
      this.newCourseForm = {
        id: course.id,
        title: course.title,
        category: course.category,
        duration: course.duration,
        level: course.level,
        instructor: course.instructor,
        price: course.price,
        description: course.description,
        image: course.image
      };
      this.adminActiveContentForm = 'course';
      this.$nextTick(() => {
        const el = document.querySelector('.admin-panel-card');
        if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    },

    editVideoEntry(video) {
      this.editingVideoId = video.id;
      this.newVideoForm = {
        id: video.id,
        title: video.title,
        description: video.description,
        duration: video.duration,
        views: video.views,
        embedUrl: video.embedUrl,
        category: video.category,
        thumbnail: video.thumbnail
      };
      this.adminActiveContentForm = 'video';
      this.$nextTick(() => {
        const el = document.querySelector('.admin-panel-card');
        if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    },

    editTriviaEntry(q) {
      this.editingTriviaId = q.id || q;
      this.newTriviaForm = {
        theme: q.theme,
        question: q.question,
        option0: q.options?.[0] || '',
        option1: q.options?.[1] || '',
        option2: q.options?.[2] || '',
        option3: q.options?.[3] || '',
        correctIndex: q.correctIndex ?? 0,
        explanation: q.explanation || ''
      };
      this.adminActiveContentForm = 'trivia';
    },

    clearCmsForm() {
      this.editingNormId = '';
      this.editingVideoId = '';
      this.editingExpertId = '';
      this.editingCourseId = '';
      this.editingTriviaId = '';
      // Reset forms
      this.newNormForm = { title: '', type: 'Ley', fullName: '', summary: '', content: '', sector: 'Tecnología', entity: 'Congreso', keywords: '', relatedVideoId: '', pdfUrl: '' };
      this.newVideoForm = { id: '', title: '', description: '', duration: '10:00', views: '1K', embedUrl: '', category: 'Educativo', thumbnail: '' };
      this.newExpertForm = { id: '', name: '', photo: '', specialty: '', experience: '', price: 100 };
      this.newCourseForm = { id: '', title: '', category: '', duration: '', level: 'Intermedio', instructor: '', price: 0, description: '', image: '' };
      this.newTriviaForm = { theme: '', question: '', option0: '', option1: '', option2: '', option3: '', correctIndex: 0, explanation: '' };
    },

    async addNewTrivia() {
      const mockTrivia = {
        theme: this.newTriviaForm.theme,
        question: this.newTriviaForm.question,
        options: [
          this.newTriviaForm.option0,
          this.newTriviaForm.option1,
          this.newTriviaForm.option2,
          this.newTriviaForm.option3
        ],
        correctIndex: Number(this.newTriviaForm.correctIndex),
        explanation: this.newTriviaForm.explanation
      };

      if (this.isSupabaseConnected) {
        try {
          await insertTriviaQuestions([mockTrivia]);
          alert('Pregunta de trivia registrada de forma persistente en la Base de Datos.');
        } catch (e) {
          console.error(e);
          alert('Error al guardar trivia: ' + e.message);
        }
      } else {
        this.triviaData.unshift({
          id: Date.now(),
          ...mockTrivia
        });
        alert('Pregunta de trivia registrada temporalmente en memoria.');
      }
      await this.loadAllData();
      this.newTriviaForm = { theme: '', question: '', option0: '', option1: '', option2: '', option3: '', correctIndex: 0, explanation: '' };
    }
  }
}
</script>

<style>
/* 
=========================================
CSS Styles for Biblioteca Inteligente App 
=========================================
*/

/* App layout */
.app-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background-color: var(--bg-primary);
}

/* TOP NAVIGATION BAR */
.header {
  border-bottom: 1px solid var(--border-color);
  padding: 16px 0;
}

.header-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.logo-icon {
  background-color: var(--text-primary);
  color: var(--bg-primary);
  width: 36px;
  height: 36px;
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
}

.logo-icon i {
  width: 20px;
  height: 20px;
}

.logo-text {
  display: flex;
  flex-direction: column;
}

.logo-title {
  font-family: var(--font-display);
  font-weight: 800;
  font-size: 1.25rem;
  letter-spacing: -0.5px;
}

.logo-tagline {
  font-size: 0.65rem;
  text-transform: uppercase;
  color: var(--text-secondary);
  letter-spacing: 1px;
}

.nav-links {
  display: flex;
  gap: 20px;
}

.nav-links a {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.88rem;
  font-weight: 500;
  color: var(--text-secondary);
  padding: 6px 12px;
  border-radius: var(--radius-sm);
  transition: var(--transition-smooth);
}

.nav-links a:hover, .nav-links a.active {
  color: var(--text-primary);
  background-color: var(--bg-tertiary);
}

.nav-links a i {
  width: 16px;
  height: 16px;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 16px;
}

.cart-btn {
  position: relative;
  cursor: pointer;
  padding: 8px;
  color: var(--text-secondary);
}

.cart-btn:hover {
  color: var(--text-primary);
}

.cart-badge {
  position: absolute;
  top: -2px;
  right: -2px;
  background-color: var(--color-danger);
  color: #fff;
  font-size: 0.65rem;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}

/* BUTTONS */
.btn {
  font-weight: 600;
  padding: 10px 20px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: var(--transition-smooth);
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-size: 0.9rem;
}

.btn-primary {
  background-color: var(--color-primary);
  color: var(--bg-primary);
}

.btn-primary:hover {
  background-color: #1e293b;
}

.btn-secondary {
  background-color: var(--bg-secondary);
  color: var(--text-primary);
  border: 1px solid var(--border-color);
}

.btn-secondary:hover {
  background-color: var(--bg-tertiary);
}

.btn-outline {
  border: 1px solid var(--border-color);
  background: transparent;
  color: var(--text-secondary);
}

.btn-outline:hover {
  background-color: var(--bg-secondary);
  color: var(--text-primary);
}

.btn-danger {
  background-color: var(--color-danger-light);
  color: var(--color-danger);
}

.btn-danger:hover {
  background-color: var(--color-danger);
  color: white;
}

.btn-xs {
  padding: 6px 12px;
  font-size: 0.75rem;
}

.w-full {
  width: 100%;
  justify-content: center;
}

/* TAB ANIMATIONS */
.animate-fade {
  animation: fadeIn 0.4s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(5px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 1. HERO & HOME PAGE */
.badge-new {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background-color: var(--bg-secondary);
  border: 1px solid var(--border-color);
  padding: 6px 14px;
  border-radius: var(--radius-full);
  font-size: 0.78rem;
  font-weight: 500;
  color: var(--text-secondary);
  margin-bottom: 24px;
}

.badge-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: var(--color-accent);
}

.section-margin {
  margin-top: 60px;
  margin-bottom: 60px;
}

.section-title {
  font-size: 1.5rem;
  margin-bottom: 24px;
}

/* Category Grid */
.grid-categories {
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 20px;
}

.category-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  padding: 24px;
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: var(--transition-smooth);
}

.category-card:hover {
  border-color: var(--text-primary);
  box-shadow: var(--shadow-md);
}

.cat-icon {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
}

.cat-icon i {
  width: 24px;
  height: 24px;
}

.bg-blue { background-color: #eff6ff; color: #1d4ed8; }
.bg-purple { background-color: #faf5ff; color: #7e22ce; }
.bg-green { background-color: #ecfdf5; color: #047857; }
.bg-amber { background-color: #fffbeb; color: #b45309; }

.category-card h3 {
  font-size: 1.15rem;
  margin-bottom: 6px;
}

.category-card p {
  font-size: 0.85rem;
  color: var(--text-secondary);
}

/* Grid splits */
.grid-two-cols {
  grid-template-columns: 1.2fr 0.8fr;
  gap: 40px;
}

.norms-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.norm-list-item {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 20px;
  cursor: pointer;
}

.norm-item-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.norm-type-badge {
  font-size: 0.72rem;
  font-weight: 700;
  text-transform: uppercase;
  color: var(--color-accent);
  background-color: var(--color-accent-light);
  padding: 4px 8px;
  border-radius: var(--radius-sm);
}

.norm-item-desc {
  font-size: 0.88rem;
  color: var(--text-secondary);
  margin-top: 8px;
  margin-bottom: 12px;
}

.norm-item-footer {
  display: flex;
  gap: 20px;
  font-size: 0.78rem;
  color: var(--text-muted);
}

.norm-item-footer span {
  display: flex;
  align-items: center;
  gap: 6px;
}

/* Communities & experts right side home panel */
.highlight-box {
  background-color: var(--bg-secondary);
  border: 1px solid var(--border-color);
  padding: 20px;
  border-radius: var(--radius-md);
  position: relative;
}

.box-badge {
  position: absolute;
  top: 16px;
  right: 16px;
  font-size: 0.68rem;
  font-weight: 700;
  text-transform: uppercase;
  background-color: var(--color-primary);
  color: var(--bg-primary);
  padding: 2px 8px;
  border-radius: var(--radius-sm);
}

.expert-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.expert-name-title {
  font-size: 1.05rem;
}

.expert-specialty-subtitle {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.rating {
  font-size: 0.8rem;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 4px;
}

.mb-24 { margin-bottom: 24px; }
.mt-12 { margin-top: 12px; }
.mt-16 { margin-top: 16px; }
.mt-24 { margin-top: 24px; }
.mt-32 { margin-top: 32px; }
.mt-48 { margin-top: 48px; }
.pt-12 { padding-top: 12px; }
.pt-16 { padding-top: 16px; }
.pb-16 { padding-bottom: 16px; }
.border-top { border-top: 1px solid var(--border-color); }

.youtube-hub-box {
  background-color: var(--bg-secondary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 20px;
}

.youtube-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.youtube-header h4 {
  font-size: 1.05rem;
}

.text-danger {
  color: #ea4335;
}

.youtube-subscribers {
  font-size: 0.72rem;
  font-weight: 600;
  color: var(--text-secondary);
}

.youtube-pitch {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-top: 6px;
}

.youtube-video-container {
  position: relative;
  padding-bottom: 56.25%; /* 16:9 Aspect Ratio */
  height: 0;
  border-radius: var(--radius-sm);
  overflow: hidden;
  border: 1px solid var(--border-color);
}

.youtube-video-container iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.btn-youtube-subscribe {
  color: #ea4335;
  border-color: #ea4335;
}

.btn-youtube-subscribe:hover {
  background-color: #fef2f2;
}

/* 2. TAB: LIBRARY */
.library-layout {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 32px;
}

.library-sidebar {
  background-color: var(--bg-secondary);
  border: 1px solid var(--border-color);
  padding: 24px;
  border-radius: var(--radius-md);
  height: fit-content;
  position: sticky;
  top: 90px;
}

.sidebar-title {
  font-size: 1.15rem;
  margin-bottom: 20px;
}

.clear-filters-btn {
  display: flex;
  align-items: center;
  justify-content: space-between;
  background-color: var(--bg-tertiary);
  font-size: 0.78rem;
  font-weight: 600;
  padding: 6px 12px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  margin-bottom: 16px;
}

.filter-group {
  margin-bottom: 16px;
}

.filter-group label {
  display: block;
  font-size: 0.78rem;
  font-weight: 600;
  color: var(--text-secondary);
  margin-bottom: 6px;
  text-transform: uppercase;
}

.filter-group select {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  background-color: var(--bg-primary);
  color: var(--text-primary);
}

.library-search-box {
  display: flex;
  align-items: center;
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  padding: 8px 16px;
}

.library-search-box input {
  flex: 1;
  border: none;
  font-size: 0.95rem;
}

.norms-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 20px;
}

.norm-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 24px;
  cursor: pointer;
  display: flex;
  flex-direction: column;
}

.norm-card.selected {
  border-color: var(--color-accent);
}

.norm-card-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.norm-card h3 {
  font-size: 1.25rem;
  margin-bottom: 8px;
}

.norm-card-summary {
  font-size: 0.88rem;
  color: var(--text-secondary);
  flex-grow: 1;
  margin-bottom: 16px;
}

.norm-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-bottom: 12px;
}

.tag {
  background-color: var(--bg-tertiary);
  font-size: 0.72rem;
  padding: 2px 8px;
  border-radius: var(--radius-sm);
  color: var(--text-secondary);
}

.norm-card-footer {
  display: flex;
  justify-content: space-between;
  font-size: 0.75rem;
  color: var(--text-muted);
}

.empty-state {
  text-align: center;
  padding: 60px 24px;
  border: 2px dashed var(--border-color);
  border-radius: var(--radius-md);
}

/* VISOR DOCUMENTAL MODAL */
.visor-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(15, 23, 42, 0.4);
  backdrop-filter: blur(4px);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
}

.visor-container {
  background-color: var(--bg-primary);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-premium);
  width: 100%;
  max-width: 1100px;
  max-height: 85vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.animate-slide-up {
  animation: slideUp 0.3s ease-out;
}

@keyframes slideUp {
  from { transform: translateY(40px); opacity: 0; }
  to { transform: translateY(0); opacity: 1; }
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* Auth Modal Premium */
.auth-modal-card {
  background: var(--bg-primary);
  border-radius: 16px;
  box-shadow: 0 24px 48px rgba(15, 23, 42, 0.18), 0 0 0 1px rgba(226, 232, 240, 0.8);
  width: 100%;
  max-width: 400px;
  padding: 28px;
  position: relative;
}

.auth-modal-header {
  margin-bottom: 24px;
  position: relative;
}

.auth-field {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.auth-field label {
  font-size: 0.78rem;
  font-weight: 600;
  color: var(--text-secondary);
  text-transform: uppercase;
  letter-spacing: 0.04em;
}

.auth-field input,
.auth-field select {
  width: 100%;
  padding: 11px 14px;
  border: 1.5px solid var(--border-color);
  border-radius: 8px;
  background: var(--bg-secondary);
  color: var(--text-primary);
  font-size: 0.9rem;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.auth-field input:focus,
.auth-field select:focus {
  outline: none;
  border-color: var(--color-accent);
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
  background: white;
}

.visor-header {
  padding: 24px;
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.visor-header h2 {
  font-size: 1.6rem;
  margin-top: 8px;
}

.close-visor {
  background: transparent;
  border: none;
  cursor: pointer;
  color: var(--text-secondary);
  padding: 6px;
}

.visor-body {
  display: grid;
  grid-template-columns: 1.2fr 0.8fr;
  flex-grow: 1;
  overflow: hidden;
}

.visor-doc-text {
  padding: 24px;
  overflow-y: auto;
  border-right: 1px solid var(--border-color);
}

.visor-toolbar {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.bg-blue-light {
  background-color: var(--color-accent-light);
}

.text-blue {
  color: var(--color-accent);
}

.visor-section-title {
  margin-top: 24px;
  margin-bottom: 12px;
  font-size: 1.1rem;
}

.document-content-view {
  font-family: var(--font-sans);
  font-size: 1.02rem;
  line-height: 1.7;
  color: var(--text-primary);
}

.document-scaffold-text {
  margin-top: 16px;
  padding: 16px;
  background-color: var(--bg-secondary);
  border-left: 4px solid var(--text-muted);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
  color: var(--text-secondary);
}

.visor-ai-panel {
  padding: 24px;
  background-color: var(--bg-secondary);
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

.ai-box-header {
  display: flex;
  align-items: center;
  gap: 8px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--border-color);
}

.ai-box-header h4 {
  font-size: 1.1rem;
}

.ai-box-content {
  margin-top: 16px;
}

.ai-box-content h5 {
  font-size: 0.88rem;
  font-weight: 700;
  text-transform: uppercase;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.ai-box-content p {
  font-size: 0.88rem;
  color: var(--text-secondary);
}

.ai-obligations-block {
  margin-top: 20px;
}

.ai-obligations-block ul {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.ai-obligations-block li {
  display: flex;
  gap: 8px;
  font-size: 0.85rem;
}

.ai-obligations-block li i {
  flex-shrink: 0;
  width: 16px;
  height: 16px;
  margin-top: 2px;
}

.fill-danger {
  fill: var(--color-danger);
  color: var(--color-danger);
}

/* 3. TAB: AI ASSISTANT */
.ai-chat-layout {
  display: grid;
  grid-template-columns: 320px 1fr;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  overflow: hidden;
  height: 70vh;
}

.ai-chat-sidebar {
  background-color: var(--bg-secondary);
  border-right: 1px solid var(--border-color);
  padding: 24px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

.norm-selector-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.norm-selector-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  transition: var(--transition-smooth);
}

.norm-selector-item:hover, .norm-selector-item.active {
  border-color: var(--color-accent);
  background-color: var(--color-accent-light);
}

.norm-selector-item h5 {
  font-size: 0.85rem;
}

.norm-selector-item span {
  color: var(--text-muted);
}

.text-xs { font-size: 0.72rem; }

.disclaimer-box {
  margin-top: auto;
  background-color: var(--color-danger-light);
  border: 1px solid #fee2e2;
  padding: 12px;
  border-radius: var(--radius-sm);
}

.disclaimer-header {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--color-danger);
  font-weight: bold;
  font-size: 0.75rem;
  margin-bottom: 4px;
}

.disclaimer-box p {
  font-size: 0.72rem;
  color: #7f1d1d;
  line-height: 1.4;
}

.ai-chat-main {
  display: flex;
  flex-direction: column;
  background-color: var(--bg-primary);
}

.chat-header {
  padding: 18px 24px;
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.bot-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background-color: var(--color-primary);
  color: var(--bg-primary);
  display: flex;
  align-items: center;
  justify-content: center;
}

.bot-avatar i {
  width: 18px;
  height: 18px;
}

.bot-status {
  font-size: 0.75rem;
  color: var(--text-secondary);
}

.chat-messages {
  flex-grow: 1;
  padding: 24px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 16px;
  background-color: #fafbfc;
}

.chat-msg-wrapper {
  display: flex;
  width: 100%;
}

.chat-msg-wrapper.user {
  justify-content: flex-end;
}

.chat-msg {
  max-width: 75%;
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  padding: 14px 18px;
  border-radius: var(--radius-md);
}

.chat-msg-wrapper.user .chat-msg {
  background-color: var(--color-accent);
  color: white;
  border-color: var(--color-accent);
}

.msg-sender-name {
  font-size: 0.7rem;
  font-weight: 700;
  margin-bottom: 4px;
  color: var(--text-secondary);
}

.chat-msg-wrapper.user .msg-sender-name {
  color: rgba(255, 255, 255, 0.85);
  text-align: right;
}

.msg-content {
  font-size: 0.92rem;
}

.msg-time {
  font-size: 0.65rem;
  color: var(--text-muted);
  text-align: right;
  margin-top: 4px;
}

.chat-msg-wrapper.user .msg-time {
  color: rgba(255, 255, 255, 0.7);
}

.chat-suggestions {
  display: flex;
  gap: 8px;
  padding: 12px 24px;
  background-color: #fafbfc;
}

.suggestion-tag {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  padding: 6px 12px;
  border-radius: var(--radius-full);
  font-size: 0.78rem;
  color: var(--text-secondary);
  cursor: pointer;
  transition: var(--transition-smooth);
}

.suggestion-tag:hover {
  border-color: var(--color-accent);
  color: var(--color-accent);
}

.chat-input-bar {
  padding: 16px 24px;
  border-top: 1px solid var(--border-color);
  display: flex;
  gap: 12px;
}

.chat-input-bar input {
  flex: 1;
  border: 1px solid var(--border-color);
  padding: 10px 16px;
  border-radius: var(--radius-sm);
}

.typing-dots {
  display: flex;
  gap: 4px;
  align-items: center;
  padding: 6px 0;
}

.typing-dots span {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background-color: var(--text-muted);
  animation: typing 1s infinite alternate;
}

.typing-dots span:nth-child(2) { animation-delay: 0.2s; }
.typing-dots span:nth-child(3) { animation-delay: 0.4s; }

@keyframes typing {
  from { opacity: 0.3; transform: translateY(0); }
  to { opacity: 1; transform: translateY(-3px); }
}

/* 4. EXPERTS & MARKETPLACE */
.marketplace-header-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.help-box-quick {
  display: flex;
  align-items: center;
  gap: 12px;
  background-color: #eff6ff;
  border: 1px solid #bfdbfe;
  padding: 12px 18px;
  border-radius: var(--radius-md);
  cursor: pointer;
}

.help-box-quick i {
  color: var(--color-accent);
}

.experts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
  gap: 20px;
}

.expert-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.expert-card-body {
  padding: 24px;
  display: flex;
  gap: 16px;
  flex-grow: 1;
}

.expert-card-photo {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  object-fit: cover;
}

.expert-card-info {
  flex: 1;
}

.expert-badge-specialty {
  display: inline-block;
  background-color: var(--bg-secondary);
  font-size: 0.72rem;
  font-weight: 700;
  padding: 2px 8px;
  border-radius: var(--radius-sm);
  color: var(--text-secondary);
  margin-top: 4px;
}

.expert-bio {
  font-size: 0.82rem;
  color: var(--text-secondary);
  margin-top: 10px;
  line-height: 1.5;
}

.expert-certifications-list {
  margin-top: 12px;
  font-size: 0.75rem;
}

.expert-certifications-list ul {
  padding-left: 14px;
  color: var(--text-secondary);
}

.expert-card-actions {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8px;
  padding: 16px 24px 24px;
  border-top: 1px solid var(--border-color);
}

.expert-card-actions button:first-child {
  grid-column: span 2;
  margin-bottom: 4px;
}

/* Marketplace Products */
.marketplace-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 24px;
}

.service-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.service-card-body {
  padding: 24px;
  flex-grow: 1;
}

.service-badge {
  display: inline-block;
  font-size: 0.65rem;
  font-weight: 700;
  text-transform: uppercase;
  background-color: var(--color-accent-light);
  color: var(--color-accent);
  padding: 2px 6px;
  border-radius: var(--radius-sm);
  margin-bottom: 12px;
}

.service-card h4 {
  font-size: 1.2rem;
  margin-bottom: 8px;
}

.service-desc {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-bottom: 16px;
}

.service-price-row {
  display: flex;
  align-items: baseline;
  gap: 8px;
}

.price {
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--text-primary);
}

.price-original {
  font-size: 0.88rem;
  text-decoration: line-through;
  color: var(--text-muted);
}

.service-card-footer {
  padding: 16px 24px 24px;
}

/* Cart Drawer */
.cart-drawer {
  position: fixed;
  top: 90px;
  right: 24px;
  width: 380px;
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-premium);
  padding: 24px;
  z-index: 500;
  animation: slideUp 0.25s ease-out;
}

.cart-drawer-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.close-drawer {
  background: transparent;
  cursor: pointer;
}

.cart-items-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
  max-height: 200px;
  overflow-y: auto;
}

.cart-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: var(--bg-secondary);
  padding: 10px 12px;
  border-radius: var(--radius-sm);
}

.cart-item h5 {
  font-size: 0.85rem;
}

.cart-item-price {
  font-size: 0.78rem;
  color: var(--text-secondary);
}

.remove-item-btn {
  background: transparent;
  color: var(--color-danger);
  cursor: pointer;
}

.coupon-box {
  display: flex;
  gap: 8px;
}

.coupon-box input {
  flex: 1;
  border: 1px solid var(--border-color);
  padding: 6px 12px;
  border-radius: var(--radius-sm);
  font-size: 0.8rem;
}

.cart-summary span {
  font-size: 0.88rem;
  color: var(--text-secondary);
}

.font-bold { font-weight: 700; }
.text-lg { font-size: 1.15rem; }

/* Expert Profile modal inner */
.expert-profile-layout {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 32px;
  padding: 24px;
  overflow-y: auto;
}

.profile-left {
  text-align: center;
  border-right: 1px solid var(--border-color);
  padding-right: 32px;
}

.profile-photo-large {
  width: 140px;
  height: 140px;
  border-radius: 50%;
  object-fit: cover;
  margin-bottom: 16px;
}

.profile-subtitle {
  font-size: 1rem;
  font-weight: 700;
  text-transform: uppercase;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.cert-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 8px;
  font-size: 0.88rem;
}

.cert-list li {
  display: flex;
  align-items: center;
  gap: 8px;
}

.cert-list i {
  color: var(--color-accent);
}

.success-case-box {
  background-color: var(--color-accent-light);
  border-left: 4px solid var(--color-accent);
  padding: 16px;
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
  font-size: 0.88rem;
  color: var(--text-secondary);
}

.profile-action-buttons {
  display: flex;
  gap: 16px;
}

/* 5. ACADEMY & GAMIFICATION */
.gamification-banner {
  background: linear-gradient(135deg, var(--color-accent-light) 0%, transparent 100%);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  padding: 24px;
}

.gamification-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.user-stats {
  display: flex;
  gap: 16px;
}

.stat-badge {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  padding: 8px 16px;
  border-radius: var(--radius-full);
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 700;
}

.badges-row {
  display: flex;
  gap: 10px;
}

.badge-item {
  background-color: var(--color-success-light);
  color: var(--color-success);
  font-size: 0.75rem;
  font-weight: 700;
  padding: 4px 10px;
  border-radius: var(--radius-full);
  display: flex;
  align-items: center;
  gap: 4px;
}

.courses-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 24px;
}

.course-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.course-img {
  width: 100%;
  height: 180px;
  object-fit: cover;
}

.course-body {
  padding: 20px;
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

.course-category-badge {
  font-size: 0.65rem;
  font-weight: 700;
  text-transform: uppercase;
  background-color: var(--bg-secondary);
  color: var(--text-secondary);
  padding: 2px 6px;
  border-radius: var(--radius-sm);
  align-self: flex-start;
  margin-bottom: 8px;
}

.course-card h4 {
  font-size: 1.15rem;
  margin-bottom: 8px;
}

.course-desc-text {
  font-size: 0.85rem;
  color: var(--text-secondary);
  flex-grow: 1;
}

.course-meta {
  display: flex;
  gap: 16px;
  font-size: 0.75rem;
  color: var(--text-muted);
}

.course-meta span {
  display: flex;
  align-items: center;
  gap: 4px;
}

.course-price {
  font-weight: 800;
  font-size: 1.15rem;
}

/* Trivia section */
.trivia-banner {
  background-color: var(--color-primary);
  color: var(--bg-primary);
  border-radius: var(--radius-lg);
  padding: 32px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 24px;
}

.trivia-banner h3 {
  color: white;
  font-size: 1.8rem;
  margin-top: 8px;
}

.badge-trivia {
  background-color: var(--color-warning);
  color: var(--text-primary);
  font-size: 0.68rem;
  font-weight: 800;
  text-transform: uppercase;
  padding: 2px 8px;
  border-radius: var(--radius-sm);
}

.trivia-banner-img i {
  width: 80px;
  height: 80px;
  color: var(--color-warning);
}

.quiz-box {
  background-color: var(--bg-secondary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  padding: 32px;
}

.quiz-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.quiz-timer {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  padding: 6px 14px;
  border-radius: var(--radius-full);
  display: flex;
  align-items: center;
  gap: 6px;
}

.quiz-timer.warning-timer {
  background-color: var(--color-danger-light);
  color: var(--color-danger);
  border-color: #fecaca;
  animation: pulse 1s infinite alternate;
}

@keyframes pulse {
  from { opacity: 0.8; }
  to { opacity: 1; }
}

.quiz-question-body h4 {
  font-size: 1.4rem;
}

.quiz-theme-badge {
  display: inline-block;
  background-color: var(--color-accent-light);
  color: var(--color-accent);
  font-size: 0.75rem;
  font-weight: bold;
  padding: 4px 8px;
  border-radius: var(--radius-sm);
}

.quiz-options-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.quiz-option-btn {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  padding: 16px 20px;
  border-radius: var(--radius-md);
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 12px;
  text-align: left;
  transition: var(--transition-smooth);
}

.quiz-option-btn:hover {
  border-color: var(--color-accent);
  background-color: var(--color-accent-light);
}

.option-letter {
  background-color: var(--bg-secondary);
  color: var(--text-secondary);
  width: 28px;
  height: 28px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 0.88rem;
}

.option-text {
  font-weight: 500;
}

.finished-layout {
  text-align: center;
}

.success-trophy {
  width: 64px;
  height: 64px;
  color: var(--color-warning);
  margin-bottom: 16px;
}

.score-text {
  font-size: 1.15rem;
  margin-top: 8px;
}

.xp-added {
  color: var(--color-success);
  font-weight: bold;
  margin-top: 8px;
}

/* 6. MEMBERSHIPS */
.pricing-header {
  text-align: center;
}

.pricing-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
  max-width: 1000px;
  margin-left: auto;
  margin-right: auto;
}

.pricing-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  padding: 32px;
  display: flex;
  flex-direction: column;
  position: relative;
}

.pricing-card.active {
  border-color: var(--text-primary);
  box-shadow: var(--shadow-md);
}

.pricing-card.professional {
  border-color: var(--color-accent);
  box-shadow: var(--shadow-lg);
}

.ribbon {
  position: absolute;
  top: 16px;
  right: 16px;
  background-color: var(--color-accent);
  color: white;
  font-size: 0.65rem;
  font-weight: 800;
  text-transform: uppercase;
  padding: 2px 8px;
  border-radius: var(--radius-sm);
}

.card-header-pricing h4 {
  font-size: 1.3rem;
  margin-bottom: 12px;
}

.price-box {
  display: flex;
  align-items: baseline;
  gap: 4px;
  margin-bottom: 24px;
}

.price-val {
  font-size: 2.2rem;
  font-weight: 800;
  line-height: 1;
}

.price-period {
  font-size: 0.88rem;
  color: var(--text-secondary);
}

.card-body-pricing {
  flex-grow: 1;
}

.card-body-pricing ul {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 32px;
}

.card-body-pricing li {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.88rem;
}

.card-body-pricing li i {
  color: var(--color-success);
  width: 16px;
  height: 16px;
}

.card-body-pricing li.muted-feature {
  color: var(--text-muted);
}

.card-body-pricing li.muted-feature i {
  color: var(--text-muted);
}

/* Subscriber dashboard */
.grid-three-cols {
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

.dash-stat span {
  font-size: 0.78rem;
  color: var(--text-secondary);
}

/* 7. ADMIN PANEL */
.kpi-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 20px;
  display: flex;
  align-items: center;
  gap: 16px;
}

.kpi-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.kpi-content span {
  font-size: 0.78rem;
  color: var(--text-secondary);
}

.kpi-content h4 {
  font-size: 1.4rem;
}

.text-success {
  color: var(--color-success);
}

.text-xs { font-size: 0.72rem; }

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 0.8rem;
  font-weight: 600;
  color: var(--text-secondary);
}

.form-group input, .form-group select, .form-group textarea {
  border: 1px solid var(--border-color);
  padding: 8px 12px;
  border-radius: var(--radius-sm);
  background-color: var(--bg-primary);
}

.form-row {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

.system-logs-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.log-item {
  display: flex;
  gap: 12px;
  font-size: 0.82rem;
  padding: 8px 12px;
  background-color: var(--bg-secondary);
  border-radius: var(--radius-sm);
}

.log-time {
  color: var(--text-muted);
  font-weight: bold;
}

/* Admin Panel Sub-Navigation */
.admin-subnav-tabs {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  background: var(--bg-secondary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 8px;
}

.admin-subnav-btn {
  display: flex;
  align-items: center;
  gap: 7px;
  padding: 9px 18px;
  border: none;
  border-radius: var(--radius-sm);
  background: transparent;
  color: var(--text-secondary);
  font-size: 0.85rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  font-family: var(--font-sans);
}

.admin-subnav-btn i {
  width: 16px;
  height: 16px;
}

.admin-subnav-btn:hover {
  background: var(--bg-primary);
  color: var(--text-primary);
}

.admin-subnav-btn.active {
  background: var(--color-accent);
  color: #ffffff;
  box-shadow: 0 2px 8px rgba(66,133,244,0.3);
}

/* ===== CMS MODULE STYLES ===== */
.cms-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
  flex-wrap: wrap;
}

.cms-type-pills {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.cms-pill {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 7px 14px;
  border: 1.5px solid var(--border-color);
  border-radius: 999px;
  background: transparent;
  color: var(--text-secondary);
  font-size: 0.8rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.18s ease;
  font-family: var(--font-sans);
}

.cms-pill i { width: 13px; height: 13px; }

.cms-pill:hover {
  background: var(--bg-secondary);
  color: var(--text-primary);
  border-color: var(--color-accent);
}

.cms-pill.active {
  background: var(--color-accent);
  color: white;
  border-color: var(--color-accent);
}

.cms-pill-count {
  background: rgba(255,255,255,0.25);
  color: inherit;
  font-size: 0.7rem;
  font-weight: 700;
  padding: 1px 6px;
  border-radius: 999px;
}

.cms-pill:not(.active) .cms-pill-count {
  background: var(--bg-tertiary);
  color: var(--text-muted);
}

.cms-layout {
  display: grid;
  grid-template-columns: 1fr 380px;
  gap: 20px;
  align-items: start;
}

@media (max-width: 1100px) {
  .cms-layout { grid-template-columns: 1fr; }
}

.cms-table-panel {
  padding: 0;
  overflow: hidden;
}

.cms-toolbar {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 14px 16px;
  border-bottom: 1px solid var(--border-color);
  background: var(--bg-secondary);
}

.cms-search-box {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 8px;
  background: var(--bg-primary);
  border: 1.5px solid var(--border-color);
  border-radius: 8px;
  padding: 7px 12px;
}

.cms-search-box input {
  border: none;
  background: none;
  outline: none;
  font-size: 0.85rem;
  color: var(--text-primary);
  width: 100%;
  font-family: var(--font-sans);
}

.cms-table-wrap {
  overflow-x: auto;
  max-height: 520px;
  overflow-y: auto;
}

.cms-table-wrap::-webkit-scrollbar { width: 4px; height: 4px; }
.cms-table-wrap::-webkit-scrollbar-thumb { background: var(--border-color); border-radius: 2px; }

.cms-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.83rem;
}

.cms-table thead th {
  position: sticky;
  top: 0;
  background: var(--bg-secondary);
  z-index: 1;
  padding: 10px 12px;
  text-align: left;
  font-size: 0.72rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  color: var(--text-muted);
  border-bottom: 1px solid var(--border-color);
}

.cms-table tbody tr {
  border-bottom: 1px solid var(--border-color);
  transition: background 0.15s;
}

.cms-table tbody tr:hover { background: var(--bg-secondary); }

.cms-table tbody tr.cms-row-active {
  background: rgba(37, 99, 235, 0.06);
  border-left: 3px solid var(--color-accent);
}

.cms-table td {
  padding: 10px 12px;
  vertical-align: middle;
}

.cms-cell-primary {
  font-weight: 600;
  color: var(--text-primary);
  max-width: 200px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.cms-cell-secondary {
  color: var(--text-secondary);
  font-size: 0.8rem;
  white-space: nowrap;
}

.cms-actions-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
}

.cms-btn-edit, .cms-btn-delete {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: 6px;
  border: 1px solid transparent;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: var(--shadow-sm);
}

.cms-btn-edit {
  background: var(--color-accent, #2563eb);
  color: white !important;
}

.cms-btn-edit:hover {
  background: #1d4ed8;
  transform: translateY(-1px);
  box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
}

.cms-btn-delete {
  background: #dc2626;
  color: white !important;
}

.cms-btn-delete:hover {
  background: #b91c1c;
  transform: translateY(-1px);
  box-shadow: 0 4px 6px rgba(220, 38, 38, 0.2);
}

.cms-empty {
  text-align: center;
  padding: 32px 16px;
  color: var(--text-muted);
  font-size: 0.85rem;
}

.cms-badge {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 999px;
  font-size: 0.7rem;
  font-weight: 700;
  white-space: nowrap;
}

.cms-badge-blue { background: rgba(37,99,235,0.1); color: #2563eb; }
.cms-badge-red { background: rgba(239,68,68,0.1); color: #ef4444; }
.cms-badge-green { background: rgba(34,197,94,0.1); color: #16a34a; }
.cms-badge-amber { background: rgba(245,158,11,0.1); color: #d97706; }

/* CMS Form Panel */
.cms-form-panel {
  padding: 0;
  overflow: hidden;
  position: sticky;
  top: 80px;
}

.cms-form-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 20px;
  border-bottom: 1px solid var(--border-color);
  background: var(--bg-secondary);
}

.cms-form-body {
  padding: 20px;
  max-height: 560px;
  overflow-y: auto;
}

.cms-form-body::-webkit-scrollbar { width: 4px; }
.cms-form-body::-webkit-scrollbar-thumb { background: var(--border-color); border-radius: 2px; }

.cms-form-actions {
  display: flex;
  gap: 10px;
  margin-top: 20px;
  padding-top: 16px;
  border-top: 1px solid var(--border-color);
  flex-wrap: wrap;
}

.btn-danger {
  background: rgba(239,68,68,0.1);
  color: #ef4444;
  border: 1.5px solid rgba(239,68,68,0.25);
  padding: 9px 16px;
  border-radius: 8px;
  font-size: 0.85rem;
  font-weight: 600;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  transition: all 0.18s;
}

.btn-danger:hover {
  background: #ef4444;
  color: white;
  border-color: #ef4444;
}

/* Content Type Sub-Tabs */

.content-type-tabs {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  border-bottom: 2px solid var(--border-color);
  padding-bottom: 12px;
}

.content-type-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 7px 14px;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  background: transparent;
  color: var(--text-secondary);
  font-size: 0.82rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  font-family: var(--font-sans);
}

.content-type-btn i {
  width: 14px;
  height: 14px;
}

.content-type-btn:hover {
  background: var(--bg-secondary);
  color: var(--text-primary);
  border-color: var(--color-accent);
}

.content-type-btn.active {
  background: var(--bg-secondary);
  color: var(--color-accent);
  border-color: var(--color-accent);
}

/* Admin Content Lists */
.admin-list-scroll {
  max-height: 480px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.admin-list-scroll::-webkit-scrollbar {
  width: 4px;
}

.admin-list-scroll::-webkit-scrollbar-thumb {
  background: var(--border-color);
  border-radius: 2px;
}

.admin-list-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding: 10px 12px;
  background: var(--bg-secondary);
  border-radius: var(--radius-sm);
  border: 1px solid transparent;
  transition: border-color 0.15s ease;
}

.admin-list-item:hover {
  border-color: var(--border-color);
}

.admin-list-item-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  flex: 1;
  min-width: 0;
}

.admin-list-title {
  font-size: 0.85rem;
  font-weight: 500;
  color: var(--text-primary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.admin-list-badge {
  display: inline-flex;
  align-items: center;
  padding: 2px 8px;
  border-radius: 10px;
  font-size: 0.68rem;
  font-weight: 700;
  background: rgba(66,133,244,0.1);
  color: var(--color-accent);
  border: 1px solid rgba(66,133,244,0.2);
  width: fit-content;
  text-transform: uppercase;
  letter-spacing: 0.3px;
}


.floating-consultancy-tab {
  position: fixed;
  bottom: 24px;
  right: 24px;
  background-color: var(--color-primary);
  color: var(--bg-primary);
  border-radius: var(--radius-full);
  padding: 12px 20px;
  display: flex;
  align-items: center;
  gap: 8px;
  box-shadow: var(--shadow-premium);
  cursor: pointer;
  z-index: 800;
  transition: var(--transition-smooth);
}

.floating-consultancy-tab:hover {
  transform: scale(1.05);
}

.pulse-ring {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border-radius: var(--radius-full);
  border: 2px solid var(--color-primary);
  animation: pulse-animation 2s infinite;
  opacity: 0;
}

@keyframes pulse-animation {
  0% { transform: scale(0.95); opacity: 0.5; }
  100% { transform: scale(1.2); opacity: 0; }
}

.floating-consultancy-tab span {
  font-size: 0.82rem;
  font-weight: 700;
}

.consultancy-modal-container {
  max-width: 800px;
}

.consultancy-modal-body {
  padding: 24px;
  overflow-y: auto;
}

.consult-options-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 16px;
}

.consult-opt {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  padding: 24px;
  border-radius: var(--radius-md);
  cursor: pointer;
  display: flex;
  flex-direction: column;
}

.consult-opt h4 {
  font-size: 1.1rem;
  margin-top: 12px;
  margin-bottom: 6px;
}

.consult-opt p {
  font-size: 0.82rem;
  color: var(--text-secondary);
  flex-grow: 1;
  margin-bottom: 12px;
}

.action-hint {
  font-size: 0.78rem;
  font-weight: 700;
  color: var(--color-accent);
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.font-xl {
  font-size: 2rem;
}

/* FOOTER */
.footer {
  background-color: var(--bg-secondary);
  border-top: 1px solid var(--border-color);
  padding: 48px 0 24px;
  margin-top: auto;
}

.footer-grid {
  display: grid;
  grid-template-columns: 1.5fr 1fr 1fr;
  gap: 40px;
}

.footer-desc {
  font-size: 0.88rem;
  color: var(--text-secondary);
}

.footer-col h4 {
  font-size: 1rem;
  margin-bottom: 16px;
}

.footer-links {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.footer-links a {
  font-size: 0.88rem;
  color: var(--text-secondary);
}

.footer-links a:hover {
  color: var(--text-primary);
}

/* RESPONSIVE DESIGN */
@media (max-width: 1024px) {
  .grid-two-cols, .library-layout, .ai-chat-layout, .expert-profile-layout {
    grid-template-columns: 1fr;
  }
  
  .library-sidebar {
    position: static;
    width: 100%;
  }
  
  .profile-left {
    border-right: none;
    border-bottom: 1px solid var(--border-color);
    padding-right: 0;
    padding-bottom: 24px;
  }
}

@media (max-width: 768px) {
  .hero h1 {
    font-size: 2.2rem;
  }
  
  .header-container {
    flex-direction: column;
    gap: 16px;
    align-items: stretch !important;
  }

  .mobile-menu-toggle {
    display: block !important;
    padding: 8px;
    font-size: 1.6rem !important;
    line-height: 1;
  }
  
  .nav-links {
    display: none !important;
    flex-direction: column;
    width: 100%;
    gap: 8px;
    background: var(--bg-secondary);
    padding: 12px;
    border-radius: var(--radius-md);
    border: 1px solid var(--border-color);
  }

  .nav-links-mobile-open {
    display: flex !important;
  }
  
  .nav-links a {
    width: 100%;
    justify-content: flex-start;
  }

  .header-actions {
    display: none !important;
    width: 100%;
    flex-direction: column;
    gap: 12px;
    align-items: stretch;
    background: var(--bg-secondary);
    padding: 12px;
    border-radius: var(--radius-md);
    border: 1px solid var(--border-color);
  }

  .header-actions-mobile-open {
    display: flex !important;
  }

  .header-actions .btn {
    width: 100%;
    justify-content: center;
  }
  
  .quiz-options-grid {
    grid-template-columns: 1fr;
  }
  
  .grid-three-cols {
    grid-template-columns: 1fr;
  }
  
  .footer-grid {
    grid-template-columns: 1fr;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
}
/* YOUTUBE HUB STYLING */
.youtube-hub-header {
  border-bottom: 1px solid var(--border-color);
  padding-bottom: 24px;
}

.youtube-stats-block {
  align-items: center;
}

.youtube-video-card {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.video-thumbnail-container {
  position: relative;
  width: 100%;
  padding-bottom: 56.25%;
  background-color: #000;
  cursor: pointer;
  overflow: hidden;
}

.video-thumbnail-container img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.youtube-video-card:hover .video-thumbnail-container img {
  transform: scale(1.05);
}

.play-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(15, 23, 42, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.25s ease;
}

.video-thumbnail-container:hover .play-overlay {
  opacity: 1;
}

.play-overlay i {
  color: #fff;
  width: 48px;
  height: 48px;
  background-color: #ea4335;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 12px;
  box-shadow: 0 4px 10px rgba(234, 67, 53, 0.4);
}

.video-duration {
  position: absolute;
  bottom: 8px;
  right: 8px;
  background-color: rgba(15, 23, 42, 0.85);
  color: #fff;
  font-size: 0.72rem;
  font-weight: 600;
  padding: 2px 6px;
  border-radius: var(--radius-sm);
}

.video-info-body {
  padding: 16px 20px 20px;
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

.video-category {
  font-size: 0.65rem;
  font-weight: 700;
  text-transform: uppercase;
  color: #ea4335;
  background-color: #fef2f2;
  padding: 2px 8px;
  border-radius: var(--radius-sm);
  align-self: flex-start;
  margin-bottom: 8px;
}

.video-info-body h4 {
  font-size: 1.05rem;
  cursor: pointer;
  line-height: 1.4;
  margin-bottom: 6px;
}

.video-info-body h4:hover {
  color: var(--color-accent);
}

.video-desc {
  font-size: 0.82rem;
  color: var(--text-secondary);
  flex-grow: 1;
  line-height: 1.4;
}

.video-meta-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.75rem;
  color: var(--text-muted);
}

.youtube-player-modal .youtube-video-container {
  padding-bottom: 56.25%;
  border-radius: 0;
  border: none;
}

.p-24 {
  padding: 24px;
}

/* SPECTACULAR HERO STYLING (STRIPE & NIKE-LIKE GLOWS & CURVES) */
.hero-spectacular {
  position: relative;
  overflow: hidden;
  background-color: #ffffff;
  padding: 30px 0 80px 0;
  border-bottom: 1px solid var(--border-color);
}

.hero-bg-shapes {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

/* Background glows */
.shape-glow {
  position: absolute;
  border-radius: 50%;
  filter: blur(120px);
  opacity: 0.12;
}

.shape-1 {
  top: -10%;
  right: 5%;
  width: 500px;
  height: 500px;
  background: radial-gradient(circle, var(--color-accent) 0%, transparent 80%);
}

.shape-2 {
  bottom: -20%;
  left: -10%;
  width: 600px;
  height: 600px;
  background: radial-gradient(circle, #7e22ce 0%, transparent 80%);
}

/* Curved layout shape inspired by Nike Store / Stripe */
.shape-clip-bg {
  position: absolute;
  bottom: 0;
  right: 0;
  width: 100%;
  height: 100%;
  background-color: var(--bg-secondary);
  clip-path: ellipse(80% 45% at 50% 115%);
  z-index: 0;
}

.hero-inner {
  position: relative;
  z-index: 10;
}

.hero-grid-split {
  display: grid;
  grid-template-columns: 1.2fr 0.8fr;
  gap: 60px;
  align-items: center;
}

.hero-left-col {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

/* Premium micro-pill */
.badge-premium-pill {
  display: flex;
  align-items: center;
  gap: 8px;
  background-color: var(--color-primary);
  color: var(--bg-primary);
  padding: 6px 14px;
  border-radius: var(--radius-full);
  font-size: 0.72rem;
  font-weight: 700;
  letter-spacing: 1px;
  margin-bottom: 24px;
  box-shadow: 0 4px 12px rgba(15, 23, 42, 0.15);
}

.pulse-dot {
  width: 6px;
  height: 6px;
  background-color: var(--color-success);
  border-radius: 50%;
  animation: pulse-dot-anim 1.5s infinite alternate;
}

@keyframes pulse-dot-anim {
  from { transform: scale(0.8); opacity: 0.5; }
  to { transform: scale(1.3); opacity: 1; }
}

/* Nike style gradient headlines */
.hero-headline {
  font-size: 3.5rem;
  line-height: 1.1;
  font-weight: 800;
  letter-spacing: -2px;
  margin-bottom: 20px;
}

.gradient-text {
  background: linear-gradient(135deg, var(--color-accent) 0%, #7e22ce 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subheadline {
  font-size: 1.12rem;
  color: var(--text-secondary);
  line-height: 1.6;
  margin-bottom: 36px;
  max-width: 640px;
}

/* Spectacular search bar layout - Optimized for Premium UX */
.search-bar-spectacular {
  display: flex;
  background-color: #ffffff;
  border: 2px solid rgba(139, 92, 246, 0.2);
  padding: 8px;
  border-radius: 16px;
  box-shadow: 0 25px 50px -12px rgba(139, 92, 246, 0.15), 0 0 0 1px rgba(139, 92, 246, 0.05);
  width: 100%;
  max-width: 780px;
  margin-bottom: 30px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.search-bar-spectacular:focus-within {
  border-color: #8b5cf6;
  box-shadow: 0 25px 50px -12px rgba(139, 92, 246, 0.25), 0 0 0 4px rgba(139, 92, 246, 0.15);
  transform: translateY(-2px);
}

.search-input-wrapper {
  display: flex;
  align-items: center;
  flex: 1;
  padding-left: 20px;
}

.search-icon-spec {
  color: #8b5cf6;
  width: 24px;
  height: 24px;
  margin-right: 14px;
}

.search-input-wrapper input {
  flex: 1;
  border: none;
  font-size: 1.15rem;
  font-weight: 500;
  color: var(--text-primary);
  background: transparent;
  outline: none;
}

.search-input-wrapper input::placeholder {
  color: var(--text-muted);
  opacity: 0.8;
}

.btn-search-spec {
  background: linear-gradient(135deg, var(--color-primary) 0%, #4f46e5 100%);
  color: white;
  padding: 16px 32px;
  border-radius: 12px;
  font-weight: 700;
  font-size: 1rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  border: none;
  transition: all 0.2s ease-in-out;
  box-shadow: 0 4px 12px rgba(79, 70, 229, 0.2);
}

.btn-search-spec:hover {
  background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
  transform: translateY(-1px);
  box-shadow: 0 6px 20px rgba(15, 23, 42, 0.25);
}

/* Stats */
.hero-stats-row {
  display: flex;
  gap: 40px;
}

.hero-stat-item h3 {
  font-size: 1.8rem;
  font-weight: 800;
  line-height: 1;
}

.hero-stat-item span {
  font-size: 0.78rem;
  color: var(--text-muted);
  text-transform: uppercase;
  font-weight: 600;
}

/* Right side Glassmorphism widget previews */
.hero-right-col {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 24px;
  justify-content: center;
  align-items: center;
}

.hero-glass-card {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  border-radius: var(--radius-lg);
  padding: 24px;
  box-shadow: 0 30px 60px -15px rgba(15, 23, 42, 0.08);
  width: 100%;
  max-width: 380px;
}

.secondary-card {
  max-width: 320px;
  align-self: flex-end;
  margin-right: 40px;
  background: rgba(255, 255, 255, 0.85);
  box-shadow: 0 20px 40px -10px rgba(15, 23, 42, 0.05);
}

.card-glass-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.pill-red-dot {
  width: 8px;
  height: 8px;
  background-color: var(--color-danger);
  border-radius: 50%;
  animation: pulse-dot-anim 1s infinite alternate;
}

.badge-icon-bg {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

@media (max-width: 1024px) {
  .hero-grid-split {
    grid-template-columns: 1fr;
    gap: 40px;
  }
  .hero-headline {
    font-size: 2.5rem;
  }
  .secondary-card {
    align-self: center;
    margin-right: 0;
  }
}

/* GOOGLE-LIKE MINIMALIST SEARCH STYLING */
.google-search-container {
  max-width: 1350px;
  margin: 30px auto;
  padding: 0 24px;
}

.google-header-row {
  display: flex;
  align-items: center;
  gap: 24px;
  margin-bottom: 16px;
}

.google-logo-mini {
  font-family: 'Outfit', sans-serif;
  font-weight: 800;
  font-size: 1.8rem;
  letter-spacing: -1px;
  cursor: pointer;
  user-select: none;
}

.g-blue { color: #4285f4; }
.g-red { color: #ea4335; }
.g-yellow { color: #fbbc05; }
.g-green { color: #34a853; }

.google-input-box-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  flex: 1;
  max-width: 780px;
}

.google-search-input {
  width: 100%;
  padding: 12px 48px 12px 20px;
  font-size: 0.98rem;
  color: var(--text-primary);
  background-color: #ffffff;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-full);
  box-shadow: 0 1px 6px rgba(32, 33, 36, 0.08);
  transition: var(--transition-smooth);
}

.google-search-input:focus {
  box-shadow: 0 1px 6px rgba(32, 33, 36, 0.2);
  border-color: rgba(223, 225, 229, 0);
}

.google-search-icon-right {
  position: absolute;
  right: 18px;
  color: #4285f4;
  width: 20px;
  height: 20px;
  cursor: pointer;
}

/* Google Tabs Bar */
.google-tabs-bar {
  display: flex;
  gap: 24px;
  border-bottom: 1px solid var(--border-color);
  padding-left: 20px;
  margin-bottom: 12px;
}

.google-tab-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.85rem;
  color: var(--text-secondary);
  padding: 10px 0;
  cursor: pointer;
  border-bottom: 3px solid transparent;
  transition: var(--transition-smooth);
}

.google-tab-item:hover, .google-tab-item.active {
  color: #1a0dab;
  border-color: #1a0dab;
}

.google-tab-item i {
  width: 16px;
  height: 16px;
}

/* Results metadata */
.google-results-meta {
  padding-left: 20px;
  font-size: 0.8rem;
  color: var(--text-muted);
}

/* Main Layout split */
.google-results-layout {
  display: grid;
  grid-template-columns: 1fr 320px;
  gap: 32px;
  padding-left: 20px;
}

.google-results-main {
  min-width: 0;
}

.google-results-list {
  display: flex;
  flex-direction: column;
  gap: 28px;
}

/* Result Card */
.google-result-card {
  display: flex;
  flex-direction: column;
}

.google-result-breadcrumb {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 0.75rem;
  color: var(--text-secondary);
}

.google-result-breadcrumb i {
  width: 12px;
  height: 12px;
  color: var(--text-muted);
}

.google-result-title {
  font-family: var(--font-sans);
  font-size: 1.25rem;
  font-weight: 500;
  color: #1a0dab;
  cursor: pointer;
  margin-top: 4px;
  letter-spacing: normal;
}

.google-result-title:hover {
  text-decoration: underline;
}

.google-result-snippet {
  font-size: 0.88rem;
  color: #4d5156;
  line-height: 1.58;
  margin-top: 4px;
}

.google-result-date {
  color: #70757a;
}

.google-action-link {
  color: #1a0dab;
  cursor: pointer;
}

.google-action-link:hover {
  text-decoration: underline;
}

.google-empty-state {
  font-size: 0.95rem;
  color: var(--text-secondary);
}

.google-empty-state ul {
  margin-top: 8px;
  padding-left: 20px;
}

/* Sidebar Box styles */
.google-results-sidebar {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.google-sidebar-box {
  background-color: #ffffff;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 18px;
}

.google-sidebar-box h4 {
  font-size: 0.9rem;
  text-transform: uppercase;
  color: var(--text-secondary);
  letter-spacing: 0.5px;
}

.google-filter-item label {
  display: block;
  font-size: 0.72rem;
  font-weight: bold;
  color: var(--text-muted);
  text-transform: uppercase;
  margin-bottom: 4px;
}

.google-filter-item select {
  width: 100%;
  padding: 6px 10px;
  font-size: 0.82rem;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  background-color: var(--bg-primary);
}

.border-blue {
  border-color: #bfdbfe;
}

@media (max-width: 1024px) {
  .google-tabs-bar, .google-results-meta, .google-results-layout {
    padding-left: 0;
  }
  .google-results-layout {
    grid-template-columns: 1fr;
    gap: 32px;
  }
  .google-header-row {
    flex-direction: column;
    align-items: flex-start;
  }
}

/* ==========================================================================
   YOUTUBE CLONE PLATFORM (LEGALCOL TV) - PREMIUM STYLE SYSTEM (LIGHT THEME)
   ========================================================================== */
.youtube-app-wrapper {
  display: flex;
  background-color: var(--bg-secondary); /* Light grey/slate background */
  color: var(--text-primary);
  min-height: 100vh;
  font-family: 'Inter', sans-serif;
  margin-top: -24px; /* Align with tab content padding */
  margin-left: -24px;
  margin-right: -24px;
  border-bottom-left-radius: var(--radius-lg);
  border-bottom-right-radius: var(--radius-lg);
  overflow: hidden;
}

/* Sidebar Styling */
.yt-sidebar {
  width: 240px;
  background-color: var(--bg-primary); /* Pure white sidebar */
  padding: 16px 8px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  border-right: 1px solid var(--border-color);
}

.yt-sidebar-group {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.yt-sidebar-title {
  color: var(--text-muted);
  font-size: 0.85rem;
  font-weight: 700;
  padding: 8px 12px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.yt-sidebar-item {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 10px 16px;
  font-size: 0.9rem;
  font-weight: 500;
  border-radius: 10px;
  color: var(--text-secondary);
  cursor: pointer;
  transition: var(--transition-smooth);
}

.yt-sidebar-item:hover {
  background-color: var(--bg-secondary);
  color: var(--text-primary);
}

.yt-sidebar-item.active {
  background-color: var(--color-accent-light);
  color: var(--color-accent);
  font-weight: 600;
}

.yt-sidebar-item.active i {
  color: var(--color-accent);
}

.yt-sidebar-item i {
  width: 20px;
  height: 20px;
  color: var(--text-secondary);
}

/* Feed Container */
.yt-feed-container {
  flex-grow: 1;
  padding: 24px;
  background-color: var(--bg-secondary);
  overflow-y: auto;
}

/* Channel Banner & Identity Header */
.yt-channel-banner {
  position: relative;
  border-radius: 16px;
  height: 220px;
  background: linear-gradient(135deg, #ffffff 0%, var(--bg-tertiary) 100%);
  overflow: hidden;
  display: flex;
  align-items: flex-end;
  padding: 24px;
  border: 1px solid var(--border-color);
  box-shadow: var(--shadow-sm);
}

.yt-banner-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(circle at 80% 20%, rgba(37, 99, 235, 0.08) 0%, transparent 60%);
  pointer-events: none;
}

.yt-channel-info-row {
  position: relative;
  display: flex;
  align-items: center;
  gap: 24px;
  z-index: 2;
  width: 100%;
}

.yt-channel-avatar-big {
  width: 90px;
  height: 90px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ea4335 0%, #c5221f 100%);
  color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-display);
  font-size: 2.5rem;
  font-weight: 800;
  box-shadow: 0 8px 24px rgba(234, 67, 53, 0.2);
  border: 3px solid #ffffff;
}

.yt-channel-meta-text {
  flex-grow: 1;
}

.yt-channel-meta-text h2 {
  color: var(--text-primary);
  font-size: 1.8rem;
  font-weight: 800;
  letter-spacing: -0.5px;
}

.text-secondary-light {
  color: var(--text-secondary);
}

.yt-channel-bio {
  color: var(--text-muted);
  max-width: 600px;
}

.btn-youtube-red {
  background-color: var(--color-danger);
  color: #ffffff;
  font-weight: 700;
  border-radius: 20px;
  padding: 8px 18px;
  transition: var(--transition-smooth);
}

.btn-youtube-red:hover {
  background-color: #d32f2f;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
}

/* Tags Bar */
.yt-tags-bar {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  padding-bottom: 8px;
}

.yt-tag-pill {
  background-color: var(--bg-primary);
  color: var(--text-secondary);
  padding: 6px 14px;
  border-radius: 8px;
  font-size: 0.85rem;
  font-weight: 500;
  white-space: nowrap;
  cursor: pointer;
  border: 1px solid var(--border-color);
  transition: var(--transition-smooth);
}

.yt-tag-pill:hover {
  background-color: var(--bg-tertiary);
  color: var(--text-primary);
}

.yt-tag-pill.active {
  background-color: var(--color-primary);
  color: var(--bg-primary);
  border-color: var(--color-primary);
  font-weight: 600;
}

/* Video Grid layout */
.yt-video-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 24px;
}

.yt-video-card {
  display: flex;
  flex-direction: column;
  cursor: pointer;
  background-color: var(--bg-primary);
  border-radius: 12px;
  padding: 12px;
  border: 1px solid var(--border-color);
  transition: var(--transition-smooth);
}

.yt-video-card:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow-md);
  border-color: rgba(37, 99, 235, 0.2);
}

.yt-video-thumbnail {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
  border-radius: 8px;
  overflow: hidden;
  background-color: #1e1e1e;
}

.yt-video-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.yt-video-time {
  position: absolute;
  bottom: 8px;
  right: 8px;
  background-color: rgba(0, 0, 0, 0.8);
  color: #fff;
  font-size: 0.75rem;
  font-weight: 600;
  padding: 2px 6px;
  border-radius: 4px;
}

.yt-thumbnail-hover-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.yt-video-thumbnail:hover .yt-thumbnail-hover-overlay {
  opacity: 1;
}

.play-icon-yt {
  width: 48px;
  height: 48px;
  color: #ffffff;
}

.yt-video-details {
  display: flex;
  gap: 12px;
}

.yt-channel-avatar-small {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ea4335 0%, #c5221f 100%);
  color: #ffffff;
  font-weight: 800;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  font-size: 0.9rem;
}

.yt-video-meta {
  flex-grow: 1;
}

.yt-video-title {
  color: var(--text-primary);
  font-size: 0.95rem;
  font-weight: 600;
  line-height: 1.4;
  margin-bottom: 4px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.yt-channel-name {
  color: var(--text-secondary);
  font-size: 0.8rem;
  display: flex;
  align-items: center;
  gap: 4px;
}

.check-verified-icon {
  width: 12px;
  height: 12px;
  color: var(--text-muted);
  fill: var(--text-muted);
}

.yt-video-stats {
  color: var(--text-muted);
  font-size: 0.8rem;
  display: flex;
  gap: 4px;
}

/* YouTube Video Player Full Overlay Simulator (Light Theme) */
.yt-player-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: var(--bg-secondary);
  z-index: 1000;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.yt-player-header {
  height: 56px;
  background-color: var(--bg-primary);
  border-bottom: 1px solid var(--border-color);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  position: sticky;
  top: 0;
  z-index: 10;
}

.yt-player-header .logo-title {
  color: var(--text-primary) !important;
}

.yt-player-content-layout {
  display: grid;
  grid-template-columns: 1fr 400px;
  gap: 24px;
  padding: 24px;
  max-width: 1600px;
  margin: 0 auto;
  width: 100%;
}

.yt-player-left-col {
  min-width: 0;
}

.yt-video-wrapper-aspect {
  width: 100%;
  aspect-ratio: 16 / 9;
  background-color: #000;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: var(--shadow-lg);
}

.yt-video-wrapper-aspect iframe {
  width: 100%;
  height: 100%;
}

.yt-player-title {
  color: var(--text-primary);
  font-size: 1.4rem;
  font-weight: 700;
  margin-top: 16px;
}

.yt-player-meta-action-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.yt-actions-buttons {
  display: flex;
  gap: 8px;
}

.btn-secondary-dark {
  background-color: var(--bg-primary);
  color: var(--text-secondary);
  font-weight: 600;
  border-radius: 18px;
  padding: 6px 14px;
  border: 1px solid var(--border-color);
  display: inline-flex;
  align-items: center;
  gap: 6px;
  transition: var(--transition-smooth);
}

.btn-secondary-dark:hover {
  background-color: var(--bg-tertiary);
  color: var(--text-primary);
}

/* Comments Section */
.yt-comments-section {
  color: var(--text-primary);
}

.yt-comments-section h3 {
  font-size: 1.2rem;
  font-weight: 700;
  margin-bottom: 16px;
}

.yt-user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--color-accent);
  color: #ffffff;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.yt-comment-input {
  background-color: transparent;
  border-bottom: 1px solid var(--border-color);
  color: var(--text-primary);
  padding: 8px 0;
  width: 100%;
  font-size: 0.9rem;
  transition: border-bottom-color 0.2s;
}

.yt-comment-input:focus {
  border-bottom-color: var(--text-primary);
}

.yt-comment-item {
  display: flex;
  gap: 12px;
  background-color: var(--bg-primary);
  padding: 16px;
  border-radius: var(--radius-md);
  border: 1px solid var(--border-color);
}

.comment-author {
  font-weight: 600;
  font-size: 0.85rem;
  color: var(--text-primary);
}

.comment-time {
  color: var(--text-muted);
}

.comment-text {
  color: var(--text-secondary);
  line-height: 1.4;
}

/* Related Sidebar */
.yt-player-right-col {
  display: flex;
  flex-direction: column;
}

.yt-related-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.yt-related-item {
  display: flex;
  gap: 12px;
  background-color: var(--bg-primary);
  padding: 8px;
  border-radius: var(--radius-md);
  border: 1px solid var(--border-color);
  transition: var(--transition-smooth);
}

.yt-related-item:hover {
  border-color: var(--color-accent);
  transform: translateX(2px);
}

.yt-related-thumb {
  width: 120px;
  aspect-ratio: 16 / 9;
  border-radius: 6px;
  object-fit: cover;
  flex-shrink: 0;
}

.yt-related-info {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.yt-related-info h4 {
  color: var(--text-primary) !important;
}

/* LIVE PULSE BADGE STYLING */
.live-pulse-badge {
  background-color: var(--color-danger-light);
  color: var(--color-danger);
  font-size: 0.72rem;
  font-weight: 700;
  text-transform: uppercase;
  padding: 4px 10px;
  border-radius: var(--radius-full);
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

.live-pulse-badge::before {
  content: '';
  display: inline-block;
  width: 6px;
  height: 6px;
  background-color: var(--color-danger);
  border-radius: 50%;
  animation: pulse-dot-anim 1s infinite alternate;
}

/* Home page highlight norm card additions */
.highlight-norm-day {
  border: 2px solid var(--color-accent-light) !important;
  background-color: var(--bg-primary) !important;
  position: relative;
  overflow: hidden;
}

.highlight-norm-day::after {
  content: 'TV';
  position: absolute;
  top: -10px;
  right: -10px;
  background-color: rgba(37, 99, 235, 0.05);
  font-size: 4rem;
  font-weight: 900;
  color: rgba(37, 99, 235, 0.1);
  pointer-events: none;
  font-family: var(--font-display);
}

/* Responsive adjustment for player */
@media (max-width: 1024px) {
  .yt-player-content-layout {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .youtube-app-wrapper {
    flex-direction: column;
  }
  .yt-sidebar {
    width: 100%;
    overflow-x: auto;
    flex-direction: row;
    padding: 8px;
  }
  .yt-sidebar-group {
    flex-direction: row;
  }
  .yt-sidebar-title {
    display: none;
  }
}
</style>
