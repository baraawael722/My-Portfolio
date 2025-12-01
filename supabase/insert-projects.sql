-- ========================================
-- INSERT PROJECTS DATA
-- Exported from ProjectSection.jsx
-- ========================================

-- Clear existing projects (optional)
-- DELETE FROM projects;

-- Insert all projects
INSERT INTO projects (title, description, image_url, demo_url, github_url, tags, featured)
VALUES
  (
    'Portfolio v2',
    'Website portofolio pribadi yang dibangun dengan React, Next.js, dan Tailwind CSS, di-deploy di Vercel.',
    'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=2070&auto=format&fit=crop',
    'https://github.com/ZainAhmadF28/zain-portofolio',
    'https://github.com/ZainAhmadF28/zain-portofolio',
    ARRAY['Next.js', 'React', 'TailwindCSS', 'Framer Motion'],
    true
  ),
  (
    'E-Commerce API',
    'RESTful API untuk platform e-commerce dengan fitur otentikasi, manajemen produk, dan transaksi.',
    'https://images.unsplash.com/photo-1522199755839-a2bacb67c546?q=80&w=2072&auto=format&fit=crop',
    '#',
    'https://github.com/username/ecommerce-api',
    ARRAY['Node.js', 'Express', 'MongoDB', 'JWT'],
    false
  ),
  (
    'UI Design System',
    'Merancang komponen UI yang reusable dan konsisten untuk aplikasi web menggunakan Figma.',
    'https://images.unsplash.com/photo-1600132806378-62402124d9e0?q=80&w=2070&auto=format&fit=crop',
    '#',
    '#',
    ARRAY['Figma', 'Storybook'],
    false
  ),
  (
    '3D Product Visualization',
    'Desain 3D interaktif untuk showcase produk menggunakan Spline dan Blender.',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop',
    '#',
    '#',
    ARRAY['Spline', 'Blender'],
    false
  ),
  (
    'Animated 3D Landing',
    'Landing page dengan elemen 3D animasi untuk branding modern.',
    'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?q=80&w=2070&auto=format&fit=crop',
    '#',
    '#',
    ARRAY['Spline', 'Three.js'],
    false
  );

-- ========================================
-- VERIFY DATA
-- ========================================

-- Check total projects inserted
SELECT COUNT(*) as total_projects FROM projects;

-- View all projects
SELECT 
  title,
  featured,
  array_length(tags, 1) as tech_count,
  created_at
FROM projects
ORDER BY featured DESC, created_at DESC;

-- View featured projects only
SELECT title, tags FROM projects WHERE featured = true;

-- ========================================
-- SUCCESS MESSAGE
-- ========================================

DO $$
BEGIN
  RAISE NOTICE '✅ Successfully inserted 5 projects!';
  RAISE NOTICE '🚀 1 featured project, 4 regular projects';
END $$;
