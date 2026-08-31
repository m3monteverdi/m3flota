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
