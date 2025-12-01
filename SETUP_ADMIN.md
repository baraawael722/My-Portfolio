# 🚨 IMPORTANT: Setup Admin Account

## ⚠️ First Time Setup

After cloning this repository, you MUST create your own admin account:

### Step 1: Create Supabase Project

1. Go to https://supabase.com
2. Create new project
3. Copy your project URL and anon key

### Step 2: Setup Environment Variables

Create `.env` file in root:

```env
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### Step 3: Run Database Setup

In Supabase SQL Editor, run these files **IN ORDER**:

1. **`supabase/RESET_DATABASE.sql`** - Creates all tables
2. **`supabase/insert-projects.sql`** - Sample projects
3. **`supabase/insert-certificates.sql`** - Sample certificates

### Step 4: Create YOUR Admin Account

**DO NOT use the default credentials!**

In Supabase SQL Editor, run:

```sql
-- Enable password hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Create YOUR admin account
INSERT INTO admins (username, password_hash, email, full_name, is_active)
VALUES (
  'your_username',  -- Change this
  crypt('your_secure_password', gen_salt('bf', 10)),  -- Change this
  'your_email@example.com',  -- Change this
  'Your Full Name',  -- Change this
  true
);
```

**IMPORTANT:**
- Replace `your_username` with your desired username
- Replace `your_secure_password` with a STRONG password
- Use minimum 12 characters with mix of uppercase, lowercase, numbers, symbols
- Example: `MyP@ssw0rd!2024#Secure`

### Step 5: Test Login

1. Run: `npm run dev`
2. Click ⚙️ icon in "Get In Touch" section
3. Login with YOUR credentials
4. Should see "Login berhasil! 🎉"

---

## 🔒 Security Notes

### ✅ Secure Features:

- **Bcrypt Password Hashing** - Passwords encrypted with bcrypt (60 chars)
- **Database Verification** - Login verified server-side (PostgreSQL)
- **No Hardcoded Credentials** - No credentials in frontend code
- **RLS Policies** - Row Level Security protects admin table
- **Session Timeout** - 30-minute auto-logout
- **Brute Force Protection** - 3 attempts → 15 min lockout

### 🚫 Files NOT in This Repository (for security):

- `supabase/insert-admin.sql` - Admin credentials file
- `.env` - Supabase API keys
- `.env.local` - Local environment variables

**These are in `.gitignore` to protect your credentials!**

---

## 📖 Documentation

Read these files for more information:

- **`SECURITY.md`** - Complete security guide
- **`COMPLETE_RESET_GUIDE.md`** - Step-by-step setup guide
- **`README.md`** - Main project documentation

---

## 🆘 Troubleshooting

### Can't Login?

Check if admin account exists:
```sql
SELECT username, email, is_active FROM admins;
```

### Forgot Password?

Reset via Supabase SQL Editor:
```sql
UPDATE admins
SET password_hash = crypt('NewPassword123!', gen_salt('bf', 10))
WHERE username = 'your_username';
```

### Need Help?

1. Check `SECURITY.md` for detailed troubleshooting
2. Verify Supabase connection in browser console
3. Check database functions exist:
   ```sql
   SELECT proname FROM pg_proc WHERE proname LIKE '%admin%';
   ```

---

## ⚠️ NEVER COMMIT THESE FILES:

- ❌ `supabase/insert-admin.sql` (already in .gitignore)
- ❌ `.env` (already in .gitignore)
- ❌ Any file containing passwords or API keys

**Always use `.gitignore` to protect sensitive files!**

---

**Your admin system is secure! 🔐**

Passwords are hashed with bcrypt, verified server-side, and credentials are never committed to Git.
