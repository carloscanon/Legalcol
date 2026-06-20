-- =============================================================================
-- ESQUEMA DE BASE DE DATOS MAESTRO - PROYECTO ENTERPRISE LEGALCOL
-- Optimizado para PostgreSQL y compatible con Supabase (RLS y UUID)
-- Con soporte para IDs de texto en Normas, Expertos y Cursos
-- =============================================================================

-- Habilitar extensiones requeridas
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Limpiar tablas previas para asegurar una instalación limpia sin conflictos de tipos
DROP TABLE IF EXISTS video_likes CASCADE;
DROP TABLE IF EXISTS video_comments CASCADE;
DROP TABLE IF EXISTS youtube_videos CASCADE;
DROP TABLE IF EXISTS trivia_leaderboard CASCADE;
DROP TABLE IF EXISTS trivia_questions CASCADE;
DROP TABLE IF EXISTS user_certificates CASCADE;
DROP TABLE IF EXISTS course_enrollments CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS discount_coupons CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS expert_reviews CASCADE;
DROP TABLE IF EXISTS experts CASCADE;
DROP TABLE IF EXISTS chat_messages CASCADE;
DROP TABLE IF EXISTS chat_conversations CASCADE;
DROP TABLE IF EXISTS user_favorites CASCADE;
DROP TABLE IF EXISTS norm_relations CASCADE;
DROP TABLE IF EXISTS norm_obligations CASCADE;
DROP TABLE IF EXISTS norms CASCADE;
DROP TABLE IF EXISTS user_profiles CASCADE;
DROP TABLE IF EXISTS membership_plans CASCADE;

-- =============================================================================
-- SECCIÓN 1: CAPA DE USUARIOS Y MEMBRESÍAS
-- =============================================================================

-- 1. Planes de Membresía
CREATE TABLE membership_plans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE, -- 'Gratuito', 'Profesional', 'Corporativo'
    price NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    billing_period TEXT NOT NULL DEFAULT 'mes', -- 'mes', 'año', 'gratis'
    features JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Insertar planes por defecto
INSERT INTO membership_plans (name, price, billing_period, features) VALUES
('Gratuito', 0.00, 'gratis', '{"consultas_basicas": true, "descargas_limite": 5, "asistente_ia": false}'),
('Profesional', 29.00, 'mes', '{"consultas_basicas": true, "descargas_ilimitadas": true, "asistente_ia_ilimitado": true, "alertas_correo": true}'),
('Corporativo', 149.00, 'mes', '{"consultas_basicas": true, "descargas_ilimitadas": true, "asistente_ia_ilimitado": true, "soporte_premium": true, "capacitaciones_mensuales": 1, "dashboard_multiusuario": true}')
ON CONFLICT (name) DO NOTHING;

-- 2. Perfiles de Usuario (Extiende auth.users de Supabase)
CREATE TABLE user_profiles (
    id UUID PRIMARY KEY, -- Debe coincidir con auth.users.id
    email TEXT NOT NULL UNIQUE,
    full_name TEXT,
    avatar_url TEXT,
    bio TEXT,
    company_name TEXT,
    points_xp INTEGER DEFAULT 0,
    badges TEXT[] DEFAULT '{}',
    current_membership_id UUID REFERENCES membership_plans(id),
    membership_status TEXT DEFAULT 'active', -- 'active', 'suspended', 'cancelled'
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- =============================================================================
-- SECCIÓN 2: BIBLIOTECA JURÍDICA / CONSULTA NORMATIVA
-- =============================================================================

-- 3. Normas (Leyes, Decretos, Sentencias, etc.)
CREATE TABLE norms (
    id TEXT PRIMARY KEY, -- Código identificador ej: 'ley-1581-2012'
    type TEXT NOT NULL, -- 'Ley', 'Decreto', 'Resolución', 'Circular', 'Sentencia'
    title TEXT NOT NULL, -- Ej: 'Ley 1581 de 2012'
    full_name TEXT NOT NULL, -- Nombre oficial completo
    summary TEXT NOT NULL, -- Resumen general
    date DATE NOT NULL, -- Fecha de expedición
    year INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'Vigente', -- 'Vigente', 'Derogado', 'Modificado', 'Inexequible'
    sector TEXT NOT NULL, -- 'Tecnología', 'Salud', 'Justicia', etc.
    entity TEXT NOT NULL, -- Congreso de la República, SIC, MinSalud, etc.
    keywords TEXT[] DEFAULT '{}',
    country TEXT NOT NULL DEFAULT 'Colombia',
    content TEXT NOT NULL, -- Texto completo de la norma
    ai_summary TEXT NOT NULL, -- Resumen explicativo generado por IA
    ai_obligations TEXT[] DEFAULT '{}', -- Obligaciones resumidas por IA
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 4. Obligaciones Específicas Derivadas de las Normas (Para Auditorías / Cumplimiento)
CREATE TABLE norm_obligations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    norm_id TEXT REFERENCES norms(id) ON DELETE CASCADE NOT NULL,
    obligation_text TEXT NOT NULL,
    priority TEXT DEFAULT 'Media', -- 'Alta', 'Media', 'Baja'
    entity_responsible TEXT, -- Oficial de Privacidad, Representante Legal, etc.
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 5. Historial de Modificaciones y Relación entre Leyes
CREATE TABLE norm_relations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    source_norm_id TEXT REFERENCES norms(id) ON DELETE CASCADE NOT NULL,
    target_norm_id TEXT REFERENCES norms(id) ON DELETE CASCADE NOT NULL,
    relation_type TEXT NOT NULL, -- 'Modifica a', 'Deroga a', 'Reglamenta a', 'Adiciona a'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 6. Favoritos de los Usuarios (Biblioteca Personal)
CREATE TABLE user_favorites (
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    norm_id TEXT REFERENCES norms(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    PRIMARY KEY (user_id, norm_id)
);

-- =============================================================================
-- SECCIÓN 3: CENTRO DE CONOCIMIENTO Y CHAT CON ASISTENTE LEGAL IA
-- =============================================================================

-- 7. Conversaciones del Chat de Asistencia
CREATE TABLE chat_conversations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT DEFAULT 'Nueva Consulta Legal',
    context_norm_id TEXT REFERENCES norms(id) ON DELETE SET NULL, -- Si el chat consulta una ley específica
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 8. Mensajes del Chat
CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    conversation_id UUID REFERENCES chat_conversations(id) ON DELETE CASCADE NOT NULL,
    sender TEXT NOT NULL, -- 'user', 'assistant'
    message_text TEXT NOT NULL,
    tokens_used INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- =============================================================================
-- SECCIÓN 4: DIRECTORIO DE EXPERTOS Y SERVICIOS PROFESIONALES
-- =============================================================================

-- 9. Perfiles de Abogados / Expertos Asociados
CREATE TABLE experts (
    id TEXT PRIMARY KEY, -- ID de texto para mapear con mock data, ej: 'dra-sofia-restrepo'
    user_id UUID REFERENCES user_profiles(id) ON DELETE SET NULL, -- Vinculación opcional a perfil de usuario real
    name TEXT NOT NULL,
    photo TEXT NOT NULL,
    specialty TEXT NOT NULL,
    experience TEXT NOT NULL,
    certifications TEXT[] DEFAULT '{}',
    success_cases TEXT NOT NULL,
    publications TEXT[] DEFAULT '{}',
    video_url TEXT,
    price NUMERIC(10,2) NOT NULL DEFAULT 100.00,
    rating NUMERIC(3,2) DEFAULT 5.00,
    reviews INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 10. Opiniones / Calificaciones de Clientes
CREATE TABLE expert_reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    expert_id TEXT REFERENCES experts(id) ON DELETE CASCADE NOT NULL,
    client_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
    review_text TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 11. Citas / Consultorías Agendadas (Calendly interno)
CREATE TABLE appointments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    expert_id TEXT REFERENCES experts(id) ON DELETE CASCADE NOT NULL,
    client_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    scheduled_at TIMESTAMP WITH TIME ZONE NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'confirmed', 'completed', 'cancelled'
    meeting_link TEXT, -- Google Meet, Zoom, Teams
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- =============================================================================
-- SECCIÓN 5: MARKETPLACE DE SERVICIOS LEGALES Y ACADÉMICOS
-- =============================================================================

-- 12. Cupones de Descuento
CREATE TABLE discount_coupons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT NOT NULL UNIQUE,
    discount_percentage NUMERIC(5,2) NOT NULL CHECK (discount_percentage > 0 AND discount_percentage <= 100),
    is_active BOOLEAN DEFAULT true,
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 13. Órdenes de Compra
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'paid', 'failed', 'refunded'
    subtotal NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    discount NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    total NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    coupon_id UUID REFERENCES discount_coupons(id),
    payment_method TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 14. Detalles de la Orden
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE NOT NULL,
    item_type TEXT NOT NULL, -- 'course', 'appointment', 'membership'
    item_id TEXT NOT NULL, -- ID de referencia (puede ser UUID o texto)
    price NUMERIC(10,2) NOT NULL
);

-- =============================================================================
-- SECCIÓN 6: ACADEMIA VIRTUAL DE FORMACIÓN LEGAL
-- =============================================================================

-- 15. Cursos de la Academia
CREATE TABLE courses (
    id TEXT PRIMARY KEY, -- ID de texto ej: 'curso-datos'
    title TEXT NOT NULL,
    category TEXT NOT NULL, -- 'Protección de Datos', 'Salud', etc.
    duration TEXT NOT NULL,
    level TEXT NOT NULL,
    instructor TEXT NOT NULL, -- Nombre de instructor
    instructor_id TEXT REFERENCES experts(id) ON DELETE SET NULL, -- Vínculo opcional a tabla experts
    price NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    description TEXT NOT NULL,
    modules_count INTEGER NOT NULL DEFAULT 1,
    badge TEXT, -- Insignia desbloqueable ej: 'Oficial de Datos'
    image TEXT, -- URL de la imagen del curso
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 16. Inscripciones y Progreso de Estudiantes
CREATE TABLE course_enrollments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    course_id TEXT REFERENCES courses(id) ON DELETE CASCADE NOT NULL,
    progress_percentage INTEGER DEFAULT 0 CHECK (progress_percentage >= 0 AND progress_percentage <= 100),
    status TEXT DEFAULT 'active', -- 'active', 'completed', 'dropped'
    enrolled_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    completed_at TIMESTAMP WITH TIME ZONE,
    UNIQUE (user_id, course_id)
);

-- 17. Certificados Oficiales Emitidos
CREATE TABLE user_certificates (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    issued_for_type TEXT NOT NULL, -- 'course', 'trivia'
    issued_for_id TEXT NOT NULL, -- ID del curso o trivia (como texto)
    certificate_url TEXT NOT NULL, -- Enlace de descarga en PDF
    issued_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- =============================================================================
-- SECCIÓN 7: TRIVIA / KAHOOT INTERACTIVO DE EVALUACIÓN
-- =============================================================================

-- 18. Banco de Preguntas de Trivia
CREATE TABLE trivia_questions (
    id SERIAL PRIMARY KEY,
    theme TEXT NOT NULL,
    question TEXT NOT NULL,
    options TEXT[] NOT NULL, -- Array de 4 opciones
    correct_index INTEGER CHECK (correct_index >= 0 AND correct_index <= 3) NOT NULL,
    explanation TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 19. Registro de Puntuación de Usuarios (Kahoot Leaderboard)
CREATE TABLE trivia_leaderboard (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    score INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    time_spent_seconds INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- =============================================================================
-- SECCIÓN 8: MULTIMEDIA / CLON DE YOUTUBE (LEGALCOL TV)
-- =============================================================================

-- 20. Videos del Canal
CREATE TABLE youtube_videos (
    id TEXT PRIMARY KEY, -- ID de YouTube ej: 'vid-1'
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    duration TEXT NOT NULL,
    views TEXT NOT NULL,
    embed_url TEXT NOT NULL,
    category TEXT NOT NULL,
    thumbnail TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 21. Comentarios de Videos
CREATE TABLE video_comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    video_id TEXT REFERENCES youtube_videos(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE,
    author_name TEXT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 22. Reacciones (Likes) a Videos
CREATE TABLE video_likes (
    video_id TEXT REFERENCES youtube_videos(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES user_profiles(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    PRIMARY KEY (video_id, user_id)
);

-- =============================================================================
-- APLICAR SEGURIDAD A NIVEL DE FILAS (RLS) EN SUPABASE
-- =============================================================================
ALTER TABLE membership_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE norms ENABLE ROW LEVEL SECURITY;
ALTER TABLE norm_obligations ENABLE ROW LEVEL SECURITY;
ALTER TABLE norm_relations ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE experts ENABLE ROW LEVEL SECURITY;
ALTER TABLE expert_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE discount_coupons ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE course_enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_certificates ENABLE ROW LEVEL SECURITY;
ALTER TABLE trivia_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE trivia_leaderboard ENABLE ROW LEVEL SECURITY;
ALTER TABLE youtube_videos ENABLE ROW LEVEL SECURITY;
ALTER TABLE video_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE video_likes ENABLE ROW LEVEL SECURITY;

-- POLÍTICAS BÁSICAS DE LECTURA PÚBLICA / ESCRITURA AUTENTICADA
CREATE POLICY "Lectura pública de membresías" ON membership_plans FOR SELECT USING (true);
CREATE POLICY "Lectura pública de normas" ON norms FOR SELECT USING (true);
CREATE POLICY "Lectura pública de obligaciones de normas" ON norm_obligations FOR SELECT USING (true);
CREATE POLICY "Lectura pública de relaciones de normas" ON norm_relations FOR SELECT USING (true);
CREATE POLICY "Lectura pública de expertos" ON experts FOR SELECT USING (true);
CREATE POLICY "Lectura pública de reviews de expertos" ON expert_reviews FOR SELECT USING (true);
CREATE POLICY "Lectura pública de cupones" ON discount_coupons FOR SELECT USING (true);
CREATE POLICY "Lectura pública de cursos" ON courses FOR SELECT USING (true);
CREATE POLICY "Lectura pública de trivia" ON trivia_questions FOR SELECT USING (true);
CREATE POLICY "Lectura pública de videos" ON youtube_videos FOR SELECT USING (true);
CREATE POLICY "Lectura pública de comentarios de videos" ON video_comments FOR SELECT USING (true);

-- POLÍTICAS EXCLUSIVAS DEL USUARIO AUTENTICADO
CREATE POLICY "Gestión de perfil personal" ON user_profiles FOR ALL USING (auth.uid() = id);
CREATE POLICY "Gestión de favoritos personales" ON user_favorites FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Gestión de chats personales" ON chat_conversations FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Gestión de mensajes de chat personales" ON chat_messages FOR ALL USING (auth.uid() = (SELECT user_id FROM chat_conversations WHERE id = conversation_id));
CREATE POLICY "Gestión de citas personales" ON appointments FOR ALL USING (auth.uid() = client_id);
CREATE POLICY "Gestión de órdenes personales" ON orders FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Gestión de items de orden personales" ON order_items FOR ALL USING (auth.uid() = (SELECT user_id FROM orders WHERE id = order_id));
CREATE POLICY "Gestión de inscripciones de curso personales" ON course_enrollments FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Gestión de certificados personales" ON user_certificates FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Gestión de likes personales" ON video_likes FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Gestión de leaderboard de trivia personal" ON trivia_leaderboard FOR ALL USING (auth.uid() = user_id);

-- POLÍTICA DE INSERCIÓN Y GESTIÓN GENERAL PARA ADMINISTRAR / POBLAR
CREATE POLICY "Permitir gestión de administradores o debug" ON norms FOR ALL USING (true);
CREATE POLICY "Permitir gestión de administradores o debug" ON experts FOR ALL USING (true);
CREATE POLICY "Permitir gestión de administradores o debug" ON courses FOR ALL USING (true);
CREATE POLICY "Permitir gestión de administradores o debug" ON trivia_questions FOR ALL USING (true);
CREATE POLICY "Permitir gestión de administradores o debug" ON youtube_videos FOR ALL USING (true);

