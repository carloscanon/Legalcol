const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://xyfadsowrgobwqdgeyuu.supabase.co';
const supabaseKey = 'sb_publishable_H-fDeFRBfB1ErHMl7RJffQ_2AMJ6ijZ';

const supabase = createClient(supabaseUrl, supabaseKey);

async function createAdmin() {
  const email = 'admin@legalcol.com';
  const password = 'AdminLegalCol2026!';
  const fullName = 'Administrador General';
  
  console.log(`Intentando crear cuenta de administrador por defecto en tu Supabase...`);
  console.log(`Email: ${email}`);
  
  try {
    // 1. Crear usuario en Auth
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: {
          full_name: fullName,
          role: 'admin'
        }
      }
    });

    if (error) {
      // Si el usuario ya existe, intentamos al menos upsertear su perfil
      if (error.message.includes('already registered') || error.status === 422) {
        console.log(`ℹ️ El usuario ya está registrado en Auth.`);
      } else {
        throw error;
      }
    } else {
      console.log(`✅ Usuario creado en Supabase Auth con ID: ${data.user.id}`);
    }

    // 2. Registrar/actualizar perfil en user_profiles
    // Obtenemos el ID del usuario. Si no vino en data (porque ya existía), podemos intentar loguearnos
    // para obtener su ID, o simplemente intentar registrar el perfil.
    let userId = data?.user?.id;
    if (!userId) {
      console.log("Intentando iniciar sesión para obtener el UUID y sincronizar el perfil...");
      const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password
      });
      if (signInError) throw signInError;
      userId = signInData.user.id;
    }

    const { error: profileError } = await supabase.from('user_profiles').upsert({
      id: userId,
      email: email,
      full_name: fullName,
      current_membership_id: null,
      membership_status: 'active'
    });

    if (profileError) {
      console.log(`❌ Error al crear perfil en user_profiles: ${profileError.message}`);
    } else {
      console.log(`✅ Perfil registrado en user_profiles con rol de admin.`);
      
      // Intentar actualizar el rol en user_profiles si existe esa columna o si la manejamos por metadatos.
      // Esperamos que en Supabase Auth los metadatos de rol sirvan para el inicio.
      // Opcionalmente podemos intentar setear el rol directamente si existe una columna 'role' (no la tenemos en la tabla original, pero sí en los metadatos de auth).
      // En App.vue: "this.currentUserRole = session.profile.role || session.auth.user_metadata?.role || 'user';"
      // Así que leyéndolo de user_metadata funcionará perfecto!
    }

    console.log("\n🚀 ¡CUENTA ADMINISTRADOR LISTA!");
    console.log(`Email: ${email}`);
    console.log(`Password: ${password}`);

  } catch (e) {
    console.error("❌ Error al configurar cuenta de administrador por defecto:", e.message);
  }
}

createAdmin();
