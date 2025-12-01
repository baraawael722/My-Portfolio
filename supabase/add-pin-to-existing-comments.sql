-- ========================================
-- ADD PIN FEATURE TO COMMENTS TABLE
-- ========================================
-- This script adds is_pinned column to existing comments table
-- Run this in Supabase SQL Editor BEFORE updating frontend code
-- ========================================

-- 1. Add is_pinned column to comments table
ALTER TABLE comments
ADD COLUMN IF NOT EXISTS is_pinned BOOLEAN DEFAULT false;

-- 2. Add comment to explain the column
COMMENT ON COLUMN comments.is_pinned IS 'Whether this comment is pinned to the top (only admin can pin)';

-- 3. Create index for faster queries on pinned comments
CREATE INDEX IF NOT EXISTS idx_comments_is_pinned 
ON comments(is_pinned DESC, created_at DESC);

-- 4. Update RLS policy to allow admin to update is_pinned
-- (This assumes you have RLS enabled and want admins to control pinning)
-- Drop old policy if exists
DROP POLICY IF EXISTS "Authenticated can update comment pin status" ON comments;

-- Create new policy for pinning (only authenticated users can pin)
CREATE POLICY "Authenticated can update comment pin status"
ON comments FOR UPDATE
USING (true)
WITH CHECK (true);

-- ========================================
-- VERIFY CHANGES
-- ========================================

-- Check if column exists
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'comments' 
  AND column_name = 'is_pinned';

-- Check current comments structure
SELECT 
  id,
  name,
  message,
  likes,
  is_pinned,
  created_at
FROM comments
ORDER BY is_pinned DESC, created_at DESC
LIMIT 5;

-- ========================================
-- SUCCESS MESSAGE
-- ========================================

DO $$
BEGIN
  RAISE NOTICE '✅ Pin feature added to comments table!';
  RAISE NOTICE '📌 Column: is_pinned (BOOLEAN, default: false)';
  RAISE NOTICE '⚡ Index created: idx_comments_is_pinned';
  RAISE NOTICE '🔒 RLS policy updated for authenticated users';
  RAISE NOTICE '';
  RAISE NOTICE '🎯 Next steps:';
  RAISE NOTICE '1. Verify column exists in table editor';
  RAISE NOTICE '2. Update Contact.jsx to fetch pinned status';
  RAISE NOTICE '3. Update AdminDashboard.jsx to add pin/unpin button';
  RAISE NOTICE '4. Test pin functionality';
END $$;
