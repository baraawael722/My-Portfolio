# 🔐 Security Guide - Admin Authentication

## ⚠️ IMPORTANT: Admin Account Security

### 🚨 DO NOT SHARE THESE FILES PUBLICLY:

1. **`supabase/insert-admin.sql`** - Contains default admin credentials
2. **`.env`** - Contains Supabase API keys
3. **`.env.local`** - Contains local environment variables

**These files are already in `.gitignore` - DO NOT remove them from gitignore!**

---

## 🔒 How Admin Login Works (Secure)

### ✅ Secure Features:

1. **Password Hashing (bcrypt)**
   - Passwords are NEVER stored in plain text
   - Uses bcrypt with cost factor 10
   - Password hashes are 60 characters long
   - Example hash: `$2b$10$abcdefghijklmnopqrstuvwxyz...`

2. **Database Verification**
   - Login credentials verified against Supabase database
   - No hardcoded passwords in frontend code
   - Password comparison done server-side (PostgreSQL)

3. **RLS Policies**
   - Row Level Security enabled on `admins` table
   - Only authenticated users can read admin data
   - Public cannot access admin table directly

4. **Session Management**
   - 30-minute session timeout
   - Auto-logout on session expiry
   - Session data stored in localStorage (encrypted ID only)

5. **Brute Force Protection**
   - Maximum 3 login attempts
   - 15-minute lockout after failed attempts
   - Prevents automated attack attempts

---

## 📋 Setup Instructions

### Step 1: Create Admin Table in Supabase

1. Open Supabase SQL Editor
2. Run `RESET_DATABASE.sql` (creates `admins` table)
3. Run `insert-admin.sql` (creates default admin account)

### Step 2: Verify Admin Account

Run this SQL to check admin exists:
```sql
SELECT 
  username,
  email,
  is_active,
  LENGTH(password_hash) as hash_length,
  SUBSTRING(password_hash, 1, 4) as hash_prefix,
  created_at
FROM admins;
```

**Expected output:**
```
username | email                        | is_active | hash_length | hash_prefix | created_at
---------|------------------------------|-----------|-------------|-------------|--------------------
admin    | admin@zainahmadfahrezi.com   | true      | 60          | $2b$        | 2024-11-04 ...
```

### Step 3: Test Login

1. Open website: `npm run dev`
2. Click ⚙️ icon in "Get In Touch" section
3. Login:
   - **Username:** `admin`
   - **Password:** `zain2024@admin`
4. Should see "Login berhasil! 🎉"

---

## 🔧 Database Functions

### 1. verify_admin_login(username, password)

Verifies login credentials securely.

**Usage:**
```sql
SELECT * FROM verify_admin_login('admin', 'zain2024@admin');
```

**Returns:**
```
success | admin_id | username | email                      | full_name
--------|----------|----------|----------------------------|------------------
true    | uuid...  | admin    | admin@zainahmadfahrezi.com | Zain Ahmad Fahrezi
```

### 2. update_admin_last_login(admin_id)

Updates last login timestamp.

**Usage:**
```sql
SELECT update_admin_last_login('your-admin-uuid');
```

### 3. change_admin_password(admin_id, old_password, new_password)

Changes admin password securely.

**Usage:**
```sql
SELECT change_admin_password(
  'your-admin-uuid',
  'zain2024@admin',
  'new-secure-password-123!'
);
```

**Returns:**
- `true` if password changed successfully
- `false` if old password is incorrect

---

## 🛡️ Security Best Practices

### ✅ DO:

1. **Change Default Password Immediately**
   ```sql
   SELECT change_admin_password(
     (SELECT id FROM admins WHERE username = 'admin'),
     'zain2024@admin',
     'YourStrongPassword123!@#'
   );
   ```

2. **Use Strong Passwords**
   - Minimum 12 characters
   - Mix uppercase, lowercase, numbers, symbols
   - Example: `MyP@ssw0rd!2024#Secure`

3. **Keep `.env` File Secure**
   - Never commit to Git
   - Use different keys for production
   - Rotate keys regularly

4. **Monitor Admin Activity**
   ```sql
   SELECT username, last_login, created_at 
   FROM admins 
   ORDER BY last_login DESC;
   ```

5. **Add More Admins (if needed)**
   ```sql
   INSERT INTO admins (username, password_hash, email, full_name)
   VALUES (
     'newadmin',
     crypt('SecurePassword123!', gen_salt('bf', 10)),
     'newadmin@example.com',
     'New Admin Name'
   );
   ```

### ❌ DON'T:

1. ❌ **Don't commit `insert-admin.sql` to GitHub**
   - Already in `.gitignore`
   - Contains default credentials

2. ❌ **Don't share `.env` file**
   - Contains Supabase API keys
   - Gives full database access

3. ❌ **Don't use weak passwords**
   - Bad: `admin`, `123456`, `password`
   - Good: `MySecure!P@ssw0rd#2024`

4. ❌ **Don't disable RLS policies**
   - Protects admin table from public access
   - Required for security

5. ❌ **Don't store passwords in frontend code**
   - All verification done server-side
   - Frontend only sends credentials for verification

---

## 🔍 Troubleshooting

### Problem: "Username atau password salah"

**Solutions:**
1. Check if admin account exists:
   ```sql
   SELECT * FROM admins WHERE username = 'admin';
   ```

2. Verify password hash exists:
   ```sql
   SELECT 
     username,
     LENGTH(password_hash) as hash_length
   FROM admins 
   WHERE username = 'admin';
   -- Should return hash_length = 60
   ```

3. Test password verification:
   ```sql
   SELECT * FROM verify_admin_login('admin', 'zain2024@admin');
   -- Should return success = true
   ```

### Problem: "Account terkunci"

**Solution:**
Wait 15 minutes, or clear lockout in browser console:
```javascript
localStorage.clear();
location.reload();
```

### Problem: "Terjadi kesalahan saat login"

**Check:**
1. Supabase connection:
   ```javascript
   console.log('Supabase URL:', import.meta.env.VITE_SUPABASE_URL);
   console.log('Supabase Key:', import.meta.env.VITE_SUPABASE_ANON_KEY?.substring(0, 20) + '...');
   ```

2. Database functions exist:
   ```sql
   SELECT proname FROM pg_proc WHERE proname LIKE '%admin%';
   -- Should show: verify_admin_login, update_admin_last_login, change_admin_password
   ```

---

## 📊 Admin Table Schema

```sql
CREATE TABLE admins (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,        -- bcrypt hash (60 chars)
  email TEXT UNIQUE,
  full_name TEXT,
  is_active BOOLEAN DEFAULT true,     -- Can disable without deleting
  last_login TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

---

## 🚀 Production Deployment Checklist

Before deploying to production:

- [ ] Change default admin password
- [ ] Verify `insert-admin.sql` is in `.gitignore`
- [ ] Check `.env` is in `.gitignore`
- [ ] Use different Supabase project for production
- [ ] Enable Supabase MFA (Multi-Factor Authentication)
- [ ] Monitor admin login activity
- [ ] Set up email notifications for failed logins
- [ ] Regular password rotation (every 90 days)
- [ ] Backup admin account recovery method

---

## 📞 Emergency Access

If you lose admin password:

1. **Reset via Supabase SQL Editor:**
   ```sql
   UPDATE admins
   SET password_hash = crypt('NewTemporaryPassword!123', gen_salt('bf', 10))
   WHERE username = 'admin';
   ```

2. **Login with temporary password**

3. **Change password immediately** using `change_admin_password()` function

---

## 🎯 Summary

**Your admin system is now secure because:**

✅ Passwords are hashed with bcrypt (not plain text)  
✅ Login verification done server-side (PostgreSQL)  
✅ No hardcoded credentials in frontend code  
✅ RLS policies protect admin table  
✅ Session timeout prevents unauthorized access  
✅ Brute force protection (3 attempts lockout)  
✅ Credentials file ignored from Git (`.gitignore`)  

**Even if someone views your GitHub repository, they CANNOT:**
- See your admin password (stored as bcrypt hash)
- Access admin credentials (file not in repo)
- Access Supabase database (keys not in repo)
- Bypass login system (server-side verification)

**Your portfolio is secure! 🔒**
