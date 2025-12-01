-- ========================================
-- FIX: Drop existing tables and recreate
-- ========================================

-- Drop existing tables (if any)
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS contact_messages CASCADE;
DROP TABLE IF EXISTS certificates CASCADE;
DROP TABLE IF EXISTS projects CASCADE;

-- ========================================
-- CREATE TABLES
-- ========================================

-- 1. Projects Table
CREATE TABLE projects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT,
  demo_url TEXT,
  github_url TEXT,
  tags TEXT[],
  featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Certificates Table
CREATE TABLE certificates (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  issuer TEXT NOT NULL,
  issue_date DATE,
  credential_url TEXT,
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Contact Messages Table
CREATE TABLE contact_messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  subject TEXT,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Comments Table
CREATE TABLE comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  comment TEXT NOT NULL,
  is_approved BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ========================================
-- ENABLE ROW LEVEL SECURITY (RLS)
-- ========================================

ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE certificates ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- ========================================
-- CREATE POLICIES (Public Read Access)
-- ========================================

-- Projects: Allow public read
CREATE POLICY "Allow public read projects"
ON projects FOR SELECT
USING (true);

-- Certificates: Allow public read
CREATE POLICY "Allow public read certificates"
ON certificates FOR SELECT
USING (true);

-- Comments: Allow public read approved comments only
CREATE POLICY "Allow public read approved comments"
ON comments FOR SELECT
USING (is_approved = true);

-- ========================================
-- CREATE POLICIES (Public Insert Access)
-- ========================================

-- Contact Messages: Allow anyone to submit
CREATE POLICY "Allow public insert contact messages"
ON contact_messages FOR INSERT
WITH CHECK (true);

-- Comments: Allow anyone to submit (pending approval)
CREATE POLICY "Allow public insert comments"
ON comments FOR INSERT
WITH CHECK (true);

-- ========================================
-- INSERT SAMPLE DATA
-- ========================================

-- Sample Projects
INSERT INTO projects (title, description, image_url, demo_url, github_url, tags, featured)
VALUES 
  (
    'Portfolio Website',
    'Personal portfolio with stunning 3D animations and interactive elements built with React, Three.js, and Framer Motion',
    'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
    'https://zain-portfolio.vercel.app',
    'https://github.com/ZainAhmadF28/zain-portofolio',
    ARRAY['React', 'Three.js', 'Vite', 'Tailwind CSS', 'Framer Motion'],
    true
  ),
  (
    'E-Commerce Platform',
    'Full-stack e-commerce solution with payment integration and real-time inventory',
    'https://images.unsplash.com/photo-1557821552-17105176677c?w=800',
    'https://example.com',
    'https://github.com/example/ecommerce',
    ARRAY['Next.js', 'Node.js', 'MongoDB', 'Stripe'],
    true
  ),
  (
    'Task Management App',
    'Collaborative task management tool with real-time updates',
    'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800',
    'https://example.com/tasks',
    'https://github.com/example/tasks',
    ARRAY['React', 'Firebase', 'Material-UI'],
    false
  );

-- Sample Certificates
INSERT INTO certificates (title, issuer, issue_date, credential_url, image_url)
VALUES 
  (
    'Full Stack Web Development',
    'Udemy',
    '2024-01-15',
    'https://www.udemy.com/certificate/xxx',
    'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800'
  ),
  (
    'React Advanced Patterns',
    'Frontend Masters',
    '2024-03-20',
    'https://frontendmasters.com/certificate/xxx',
    'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800'
  ),
  (
    'Node.js Developer Certification',
    'OpenJS Foundation',
    '2023-11-10',
    'https://openjsf.org/certification/xxx',
    'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800'
  );

-- Sample Approved Comment
INSERT INTO comments (name, email, comment, is_approved)
VALUES 
  (
    'John Doe',
    'john@example.com',
    'Amazing portfolio! The 3D animations are so smooth and the performance is great.',
    true
  ),
  (
    'Sarah Smith',
    'sarah@example.com',
    'Love the interactive elements. Great work!',
    true
  );

-- ========================================
-- CREATE INDEXES (Performance Optimization)
-- ========================================

CREATE INDEX idx_projects_featured ON projects(featured);
CREATE INDEX idx_projects_created_at ON projects(created_at DESC);
CREATE INDEX idx_certificates_issue_date ON certificates(issue_date DESC);
CREATE INDEX idx_comments_approved ON comments(is_approved);
CREATE INDEX idx_contact_is_read ON contact_messages(is_read);
CREATE INDEX idx_contact_created_at ON contact_messages(created_at DESC);

-- ========================================
-- SUCCESS MESSAGE
-- ========================================

DO $$
BEGIN
  RAISE NOTICE '✅ Database setup completed successfully!';
  RAISE NOTICE '📊 Created 4 tables: projects, certificates, contact_messages, comments';
  RAISE NOTICE '🔒 Enabled Row Level Security on all tables';
  RAISE NOTICE '📝 Inserted sample data for testing';
  RAISE NOTICE '⚡ Created performance indexes';
END $$;
