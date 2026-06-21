import { createClient } from '@supabase/supabase-js';

let supabaseClient = null;

/**
 * Obtiene las credenciales guardadas en localStorage
 */
export function getSavedCredentials() {
  const url = localStorage.getItem('legalcol_supabase_url') || import.meta.env.VITE_SUPABASE_URL || 'https://xyfadsowrgobwqdgeyuu.supabase.co';
  const key = localStorage.getItem('legalcol_supabase_key') || import.meta.env.VITE_SUPABASE_ANON_KEY || 'sb_publishable_H-fDeFRBfB1ErHMl7RJffQ_2AMJ6ijZ';
  return { url, key };
}

/**
 * Guarda las credenciales en localStorage
 */
export function saveCredentials(url, key) {
  localStorage.setItem('legalcol_supabase_url', url || '');
  localStorage.setItem('legalcol_supabase_key', key || '');
  initSupabaseClient();
}

/**
 * Inicializa el cliente de Supabase
 */
export function initSupabaseClient() {
  const { url, key } = getSavedCredentials();
  if (url && key) {
    try {
      supabaseClient = createClient(url, key);
    } catch (e) {
      console.error('Error al inicializar cliente de Supabase:', e);
      supabaseClient = null;
    }
  } else {
    supabaseClient = null;
  }
  return supabaseClient;
}

/**
 * Verifica si hay conexión activa
 */
export async function testConnection() {
  const client = initSupabaseClient();
  if (!client) return false;
  try {
    // Intentamos consultar la tabla norms con límite de 1 fila
    const { data, error } = await client.from('norms').select('id').limit(1);
    if (error) {
      console.warn('Conexión iniciada pero error de tabla/permisos:', error);
      // Si el error es de tabla no encontrada, pero responde, consideramos credenciales correctas
      if (error.code === 'PGRST116' || error.code === '42P01') {
        return 'table_missing';
      }
      return false;
    }
    return true;
  } catch (e) {
    return false;
  }
}

// Inicialización inmediata
initSupabaseClient();

/**
 * MÉTODOS DE LECTURA (SELECT)
 */
export async function fetchNorms() {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient.from('norms').select('*');
  if (error) throw error;
  // Convertimos snake_case a camelCase para el frontend
  return data.map(item => ({
    id: item.id,
    type: item.type,
    title: item.title,
    fullName: item.full_name,
    summary: item.summary,
    date: item.date,
    year: item.year,
    status: item.status,
    sector: item.sector,
    entity: item.entity,
    keywords: item.keywords || [],
    country: item.country,
    content: item.content,
    aiSummary: item.ai_summary,
    aiObligations: item.ai_obligations || [],
    relatedVideoId: item.related_video_id,
    pdfUrl: item.pdf_url
  }));
}

export async function fetchExperts() {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient.from('experts').select('*');
  if (error) throw error;
  return data.map(item => ({
    id: item.id,
    name: item.name,
    photo: item.photo,
    specialty: item.specialty,
    experience: item.experience,
    certifications: item.certifications || [],
    successCases: item.success_cases,
    publications: item.publications || [],
    videoUrl: item.video_url,
    price: Number(item.price),
    rating: Number(item.rating),
    reviews: Number(item.reviews)
  }));
}

export async function fetchCourses() {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient.from('courses').select('*');
  if (error) throw error;
  return data.map(item => ({
    id: item.id,
    title: item.title,
    category: item.category,
    duration: item.duration,
    level: item.level,
    instructor: item.instructor,
    price: Number(item.price),
    description: item.description,
    modulesCount: item.modules_count,
    badge: item.badge,
    image: item.image
  }));
}

export async function fetchTriviaQuestions() {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient.from('trivia_questions').select('*');
  if (error) throw error;
  return data.map(item => ({
    id: item.id,
    theme: item.theme,
    question: item.question,
    options: item.options || [],
    correctIndex: item.correct_index,
    explanation: item.explanation
  }));
}

export async function fetchYoutubeVideos() {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient.from('youtube_videos').select('*');
  if (error) throw error;
  return data.map(item => ({
    id: item.id,
    title: item.title,
    description: item.description,
    duration: item.duration,
    views: item.views,
    embedUrl: item.embed_url,
    category: item.category,
    thumbnail: item.thumbnail
  }));
}

/**
 * MÉTODOS DE INSERCIÓN (Para poblar datos de prueba desde Admin)
 */
export async function insertNorms(normsList) {
  if (!supabaseClient) return;
  const payload = normsList.map(item => ({
    id: item.id,
    type: item.type,
    title: item.title,
    full_name: item.fullName,
    summary: item.summary,
    date: item.date,
    year: Number(item.year),
    status: item.status,
    sector: item.sector,
    entity: item.entity,
    keywords: item.keywords,
    country: item.country,
    content: item.content,
    ai_summary: item.aiSummary,
    ai_obligations: item.aiObligations,
    related_video_id: item.relatedVideoId,
    pdf_url: item.pdfUrl
  }));
  const { error } = await supabaseClient.from('norms').upsert(payload, { onConflict: 'id' });
  if (error) throw error;
}

export async function insertExperts(expertsList) {
  if (!supabaseClient) return;
  const payload = expertsList.map(item => ({
    id: item.id,
    name: item.name,
    photo: item.photo,
    specialty: item.specialty,
    experience: item.experience,
    certifications: item.certifications,
    success_cases: item.successCases,
    publications: item.publications,
    video_url: item.videoUrl,
    price: Number(item.price),
    rating: Number(item.rating),
    reviews: Number(item.reviews)
  }));
  const { error } = await supabaseClient.from('experts').upsert(payload, { onConflict: 'id' });
  if (error) throw error;
}

export async function insertCourses(coursesList) {
  if (!supabaseClient) return;
  const payload = coursesList.map(item => ({
    id: item.id,
    title: item.title,
    category: item.category,
    duration: item.duration,
    level: item.level,
    instructor: item.instructor,
    price: Number(item.price),
    description: item.description,
    modules_count: Number(item.modulesCount),
    badge: item.badge,
    image: item.image
  }));
  const { error } = await supabaseClient.from('courses').upsert(payload, { onConflict: 'id' });
  if (error) throw error;
}

export async function insertTriviaQuestions(triviaList) {
  if (!supabaseClient) return;
  const payload = triviaList.map(item => ({
    theme: item.theme,
    question: item.question,
    options: item.options,
    correct_index: Number(item.correctIndex),
    explanation: item.explanation
  }));
  const { error } = await supabaseClient.from('trivia_questions').insert(payload);
  if (error) throw error;
}

export async function insertYoutubeVideos(videosList) {
  if (!supabaseClient) return;
  const payload = videosList.map(item => ({
    id: item.id,
    title: item.title,
    description: item.description,
    duration: item.duration,
    views: item.views,
    embed_url: item.embedUrl,
    category: item.category,
    thumbnail: item.thumbnail
  }));
  const { error } = await supabaseClient.from('youtube_videos').upsert(payload, { onConflict: 'id' });
  if (error) throw error;
}

/**
 * AUTENTICACIÓN Y GESTIÓN DE ROLES / USUARIOS
 */

export async function signUpUser(email, password, fullName, role = 'user') {
  if (!supabaseClient) throw new Error('Cliente Supabase no inicializado');
  
  // Registro de usuario en Auth
  const { data: authData, error: authError } = await supabaseClient.auth.signUp({
    email,
    password,
    options: {
      data: {
        full_name: fullName,
        role: role
      }
    }
  });
  if (authError) throw authError;

  if (authData.user) {
    // Crear el perfil correspondiente en user_profiles
    const { error: profileError } = await supabaseClient.from('user_profiles').upsert({
      id: authData.user.id,
      email: email,
      full_name: fullName,
      membership_status: 'active'
    });
    if (profileError) console.error("Error al crear perfil de usuario:", profileError);
  }
  return authData;
}

export async function signInUser(email, password) {
  if (!supabaseClient) throw new Error('Cliente Supabase no inicializado');
  const { data, error } = await supabaseClient.auth.signInWithPassword({
    email,
    password
  });
  if (error) throw error;
  return data;
}

export async function signOutUser() {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.auth.signOut();
  if (error) throw error;
}

export async function getCurrentUserSession() {
  if (!supabaseClient) return null;
  const { data: { session }, error } = await supabaseClient.auth.getSession();
  if (error) return null;
  if (!session) return null;

  // Cargar perfil adicional de user_profiles para obtener rol
  const user = session.user;
  let { data: profile } = await supabaseClient
    .from('user_profiles')
    .select('*, membership_plans(*)')
    .eq('id', user.id)
    .single();

  // Si no existe el perfil (por ejemplo, por RLS durante la creación inicial), se crea al vuelo
  if (!profile) {
    try {
      const { data: newProfile, error: insertError } = await supabaseClient
        .from('user_profiles')
        .insert({
          id: user.id,
          email: user.email,
          full_name: user.user_metadata?.full_name || 'Administrador General',
          membership_status: 'active'
        })
        .select()
        .single();
      
      if (!insertError) {
        profile = newProfile;
      }
    } catch (e) {
      console.error('Error al crear perfil al vuelo:', e);
    }
  }

  return {
    auth: user,
    profile: {
      ...(profile || {}),
      full_name: profile?.full_name || user.user_metadata?.full_name || 'Usuario',
      role: profile?.role || user.user_metadata?.role || 'user'
    }
  };
}

/**
 * OPERACIONES CRUD INDIVIDUALES: BORRADOS (DELETE)
 */

export async function deleteNorm(id) {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from('norms').delete().eq('id', id);
  if (error) throw error;
}

export async function deleteExpert(id) {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from('experts').delete().eq('id', id);
  if (error) throw error;
}

export async function deleteCourse(id) {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from('courses').delete().eq('id', id);
  if (error) throw error;
}

export async function deleteTriviaQuestion(id) {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from('trivia_questions').delete().eq('id', id);
  if (error) throw error;
}

export async function deleteYoutubeVideo(id) {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from('youtube_videos').delete().eq('id', id);
  if (error) throw error;
}

/**
 * CONFIGURACIONES DEL SISTEMA (DATABASE SETTINGS)
 */
export async function fetchSystemSettings() {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient.from('system_settings').select('*');
  if (error) throw error;
  return data;
}

export async function saveSystemSetting(key, value) {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from('system_settings').upsert({ key, value }, { onConflict: 'key' });
  if (error) throw error;
}

export async function insertDefaultSystemSettings(settingsArray) {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from('system_settings').upsert(settingsArray, { onConflict: 'key' });
  if (error) throw error;
}

