# Supabase Database Setup Guide

## 1. Create Supabase Project

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Click "New project"
3. Fill in:
   - **Project name**: `zain-portfolio`
   - **Database password**: (save this securely)
   - **Region**: Choose closest to your users
4. Click "Create new project" (wait ~2 minutes)

## 2. Get API Credentials

1. In your Supabase project, go to **Settings** → **API**
2. Copy these values to your `.env` file:
   - **URL**: Copy from "Project URL" → paste to `VITE_SUPABASE_URL`
   - **Anon Key**: Copy from "Project API keys" → `anon` `public` → paste to `VITE_SUPABASE_ANON_KEY`

Example `.env`:
```env
VITE_SUPABASE_URL=https://xyzcompany.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
PORT=3001
VITE_API_URL=http://localhost:3001
```

## 3. Create Database Tables

1. Go to **SQL Editor** in Supabase Dashboard
2. Click "New query"
3. Paste and run this SQL:

```sql
-- Create projects table
CREATE TABLE projects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  image TEXT,
  demo_url TEXT,
  github_url TEXT,
  technologies TEXT[] DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create certificates table
CREATE TABLE certificates (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  issuer TEXT NOT NULL,
  issue_date DATE NOT NULL,
  credential_url TEXT,
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create contact_messages table
CREATE TABLE contact_messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  subject TEXT,
  message TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create comments table
CREATE TABLE comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  comment TEXT NOT NULL,
  approved BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE certificates ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Public can read projects" ON projects FOR SELECT USING (true);
CREATE POLICY "Public can read certificates" ON certificates FOR SELECT USING (true);
CREATE POLICY "Public can read approved comments" ON comments FOR SELECT USING (approved = true);

-- Allow public to insert contact messages and comments
CREATE POLICY "Public can insert contact messages" ON contact_messages FOR INSERT WITH CHECK (true);
CREATE POLICY "Public can insert comments" ON comments FOR INSERT WITH CHECK (true);
```

4. Click "Run" (or press F5)

## 4. Insert Sample Data (Optional)

```sql
-- Insert sample project
INSERT INTO projects (title, description, image, demo_url, github_url, technologies) VALUES
('Portfolio Website', 'Modern portfolio with 3D graphics', '/images/project1.jpg', 'https://yourportfolio.vercel.app', 'https://github.com/yourusername/portfolio', ARRAY['React', 'Three.js', 'Tailwind CSS']);

-- Insert sample certificate
INSERT INTO certificates (title, issuer, issue_date, credential_url) VALUES
('React Developer Certificate', 'Meta', '2024-01-15', 'https://coursera.org/verify/XXXX');

-- Insert sample comment
INSERT INTO comments (name, email, comment, approved) VALUES
('John Doe', 'john@example.com', 'Great portfolio! Love the 3D effects.', true);
```

## 5. Verify Tables

1. Go to **Table Editor** in Supabase
2. You should see all 4 tables:
   - `projects`
   - `certificates`
   - `contact_messages`
   - `comments`

## 6. Update .env File

Make sure your `.env` has all values:

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
PORT=3001
VITE_API_URL=http://localhost:3001
```

## 7. Test Backend Connection

```bash
# Start backend server
npm run server

# In another terminal, test API
curl http://localhost:3001/api/projects
```

## Next Steps

- Update `package.json` with server scripts
- Create frontend API service (`src/services/api.js`)
- Update components to fetch from API instead of static data
- Deploy backend to Vercel or separate hosting

---

**Important Notes:**
- Row Level Security (RLS) is enabled for security
- Public can only READ projects and certificates
- Public can INSERT contact messages and comments
- Admin features (UPDATE/DELETE) will need authentication (future enhancement)
