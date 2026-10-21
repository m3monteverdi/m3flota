-- =====================================================
-- Migracion S&H: tabla de checklists de seguridad e higiene
-- Ejecutar en Supabase > SQL Editor > New query > Paste > RUN
-- =====================================================

CREATE TABLE IF NOT EXISTS sh_checklists (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tipo text NOT NULL,                           -- 'camion' | 'chofer'
  ref text NOT NULL,                            -- id del camion o nombre del chofer
  item text NOT NULL,                           -- clave del item (matafuego, casco, ...)
  estado text NOT NULL DEFAULT 'pend',          -- 'ok' | 'no' | 'pend'
  fecha date,                                   -- proximo cambio / vencimiento
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (tipo, ref, item)
);

ALTER TABLE sh_checklists ENABLE ROW LEVEL SECURITY;

-- SELECT (necesario para que el upsert funcione)
DROP POLICY IF EXISTS "anon_select_sh_checklists" ON sh_checklists;
CREATE POLICY "anon_select_sh_checklists" ON sh_checklists
  FOR SELECT TO anon
  USING (true);

-- INSERT
DROP POLICY IF EXISTS "anon_insert_sh_checklists" ON sh_checklists;
CREATE POLICY "anon_insert_sh_checklists" ON sh_checklists
  FOR INSERT TO anon
  WITH CHECK (true);

-- UPDATE
DROP POLICY IF EXISTS "anon_update_sh_checklists" ON sh_checklists;
CREATE POLICY "anon_update_sh_checklists" ON sh_checklists
  FOR UPDATE TO anon
  USING (true)
  WITH CHECK (true);

-- DELETE
DROP POLICY IF EXISTS "anon_delete_sh_checklists" ON sh_checklists;
CREATE POLICY "anon_delete_sh_checklists" ON sh_checklists
  FOR DELETE TO anon
  USING (true);

-- Permisos para usuarios anonimos y autenticados
GRANT SELECT, INSERT, UPDATE, DELETE ON sh_checklists TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON sh_checklists TO authenticated;
GRANT USAGE, SELECT ON SEQUENCE sh_checklists_id_seq TO anon;
GRANT USAGE, SELECT ON SEQUENCE sh_checklists_id_seq TO authenticated;

-- Verificar
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'sh_checklists'
ORDER BY ordinal_position;

-- =====================================================
-- Listas editables de S&H (que camiones/choferes aparecen)
-- =====================================================
CREATE TABLE IF NOT EXISTS sh_listas (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tipo text NOT NULL,                           -- 'camion' | 'chofer'
  ref text NOT NULL,                            -- id del camion o nombre del chofer
  modelo text,                                  -- marca (solo camiones custom)
  accion text NOT NULL DEFAULT 'excluir',       -- 'excluir' | 'agregar'
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (tipo, ref)
);

ALTER TABLE sh_listas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_sh_listas" ON sh_listas;
CREATE POLICY "anon_select_sh_listas" ON sh_listas
  FOR SELECT TO anon
  USING (true);

DROP POLICY IF EXISTS "anon_insert_sh_listas" ON sh_listas;
CREATE POLICY "anon_insert_sh_listas" ON sh_listas
  FOR INSERT TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_sh_listas" ON sh_listas;
CREATE POLICY "anon_update_sh_listas" ON sh_listas
  FOR UPDATE TO anon
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_sh_listas" ON sh_listas;
CREATE POLICY "anon_delete_sh_listas" ON sh_listas
  FOR DELETE TO anon
  USING (true);

GRANT SELECT, INSERT, UPDATE, DELETE ON sh_listas TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON sh_listas TO authenticated;
GRANT USAGE, SELECT ON SEQUENCE sh_listas_id_seq TO anon;
GRANT USAGE, SELECT ON SEQUENCE sh_listas_id_seq TO authenticated;

SELECT schemaname, tablename, policyname, roles, cmd
FROM pg_policies
WHERE tablename IN ('sh_checklists','sh_listas')
ORDER BY tablename, policyname;
