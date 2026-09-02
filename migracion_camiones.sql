-- Migracion: agregar columnas faltantes a tabla camiones
-- Ejecutar en Supabase > SQL Editor > New query > Paste > RUN

ALTER TABLE camiones ADD COLUMN IF NOT EXISTS pat TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS cho TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS cap TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS est TEXT DEFAULT 'DISPONIBLE';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS seg TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS rto TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS us TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS ps TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS ue TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS pe TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS uc TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS pc TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS ub TEXT DEFAULT '---';
ALTER TABLE camiones ADD COLUMN IF NOT EXISTS pb TEXT DEFAULT '---';

-- Verificar
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'camiones'
ORDER BY ordinal_position;

-- =====================================================
-- POLITICAS RLS: permitir UPDATE y DELETE anonimo
-- Sin esto, editar/eliminar reportes no funciona
-- =====================================================

-- REPORTES: permitir UPDATE a usuarios anonimos
DROP POLICY IF EXISTS "anon_update_reportes" ON reportes;
CREATE POLICY "anon_update_reportes" ON reportes
FOR UPDATE TO anon
USING (true)
WITH CHECK (true);

-- REPORTES: permitir DELETE a usuarios anonimos
DROP POLICY IF EXISTS "anon_delete_reportes" ON reportes;
CREATE POLICY "anon_delete_reportes" ON reportes
FOR DELETE TO anon
USING (true);

-- CAMIONES: permitir UPDATE/DELETE a usuarios anonimos
DROP POLICY IF EXISTS "anon_update_camiones" ON camiones;
CREATE POLICY "anon_update_camiones" ON camiones
FOR UPDATE TO anon
USING (true)
WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_camiones" ON camiones;
CREATE POLICY "anon_delete_camiones" ON camiones
FOR DELETE TO anon
USING (true);

-- CHOFERES: permitir UPDATE/DELETE a usuarios anonimos
DROP POLICY IF EXISTS "anon_update_choferes" ON choferes;
CREATE POLICY "anon_update_choferes" ON choferes
FOR UPDATE TO anon
USING (true)
WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_choferes" ON choferes;
CREATE POLICY "anon_delete_choferes" ON choferes
FOR DELETE TO anon
USING (true);

-- Verificar politicas
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;
