-- ========================================
-- UPDATE SCHEMA TO MATCH CURRENT CODE
-- ========================================

-- Fix contact_messages table
ALTER TABLE contact_messages 
  DROP COLUMN IF EXISTS subject,
  DROP COLUMN IF EXISTS is_read,
  ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'unread';

-- Fix comments table  
ALTER TABLE comments 
  DROP COLUMN IF EXISTS email,
  DROP COLUMN IF EXISTS comment,
  DROP COLUMN IF EXISTS is_approved,
  ADD COLUMN IF NOT EXISTS message TEXT NOT NULL DEFAULT '',
  ADD COLUMN IF NOT EXISTS photo_url TEXT,
  ADD COLUMN IF NOT EXISTS likes INTEGER DEFAULT 0;

-- Update existing data
UPDATE contact_messages SET status = 'read' WHERE is_read = true;
UPDATE contact_messages SET status = 'unread' WHERE is_read = false OR is_read IS NULL;

UPDATE comments SET message = comment WHERE comment IS NOT NULL;

-- ========================================
-- UPDATE RLS POLICIES
-- ========================================

-- Drop old policies
DROP POLICY IF EXISTS "Allow public read approved comments" ON comments;
DROP POLICY IF EXISTS "Allow public insert comments" ON comments;
DROP POLICY IF EXISTS "Allow public insert contact messages" ON contact_messages;

-- New policies for comments (anyone can read and insert)
CREATE POLICY "Anyone can read comments"
  ON comments FOR SELECT
  USING (true);

CREATE POLICY "Anyone can insert comments"
  ON comments FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update comment likes"
  ON comments FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- New policies for contact_messages (anyone can insert)
CREATE POLICY "Anyone can insert messages"
  ON contact_messages FOR INSERT
  WITH CHECK (true);

-- Admin can update message status (for authenticated users)
CREATE POLICY "Authenticated can update message status"
  ON contact_messages FOR UPDATE
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- Admin can read all messages
CREATE POLICY "Authenticated can read messages"
  ON contact_messages FOR SELECT
  USING (auth.role() = 'authenticated');

-- Admin can delete messages
CREATE POLICY "Authenticated can delete messages"
  ON contact_messages FOR DELETE
  USING (auth.role() = 'authenticated');

-- Admin can delete comments
CREATE POLICY "Authenticated can delete comments"
  ON comments FOR DELETE
  USING (auth.role() = 'authenticated');

-- ========================================
-- VERIFY SCHEMA
-- ========================================

-- Show contact_messages structure
SELECT 
  column_name, 
  data_type, 
  column_default,
  is_nullable
FROM information_schema.columns 
WHERE table_name = 'contact_messages'
ORDER BY ordinal_position;

-- Show comments structure  
SELECT 
  column_name, 
  data_type, 
  column_default,
  is_nullable
FROM information_schema.columns 
WHERE table_name = 'comments'
ORDER BY ordinal_position;

-- ========================================
-- SUCCESS MESSAGE
-- ========================================

DO $$
BEGIN
  RAISE NOTICE '✅ Schema updated to match code!';
  RAISE NOTICE '📋 contact_messages now has: id, name, email, message, status, created_at';
  RAISE NOTICE '💬 comments now has: id, name, message, photo_url, likes, created_at';
  RAISE NOTICE '🔒 RLS policies updated for public access';
END $$;
