# 🚀 LANGKAH-LANGKAH SETUP DATABASE

## ✅ Apa yang Sudah Dikerjakan

1. ✅ Export certificates dari ProjectSection.jsx ke SQL
2. ✅ Export projects ke SQL  
3. ✅ Update ProjectSection untuk fetch data dari Supabase
4. ✅ Update Contact untuk simpan pesan ke Supabase
5. ✅ Update Comments untuk simpan ke Supabase dengan real-time fetch
6. ✅ Tambahkan loading states dan fallback ke localStorage

---

## 📋 LANGKAH 1: Run SQL di Supabase

### **1.1 Insert Projects**

1. Buka **Supabase SQL Editor**: https://supabase.com/dashboard/project/gbgfgxjjayeaaeaqyary/editor
2. Klik **"New query"**
3. Copy-paste isi file: [`supabase/insert-projects.sql`](supabase/insert-projects.sql)
4. Klik **"Run"** atau tekan `Ctrl+Enter`
5. Tunggu muncul: **"Success. 5 rows affected"**

### **1.2 Insert Certificates**

1. Masih di SQL Editor
2. Klik **"New query"** lagi
3. Copy-paste isi file: [`supabase/insert-certificates.sql`](supabase/insert-certificates.sql)
4. Klik **"Run"**
5. Tunggu muncul: **"Success. 13 rows affected"**

---

## 📊 LANGKAH 2: Verifikasi Data di Supabase

1. **Klik "Table Editor"** di sidebar Supabase
2. **Klik table `projects`**
   - Harus ada **5 projects**
   - 1 featured (Portfolio v2)
   - 4 regular projects
3. **Klik table `certificates`**
   - Harus ada **13 certificates**
   - Dari Dicoding, BNSP, Oracle, dll.

---

## 🎯 LANGKAH 3: Test di Browser

### **3.1 Jalankan Dev Server**

```bash
npm run dev
```

Buka: http://localhost:5174

### **3.2 Test Projects Tab**

1. Scroll ke section **"PORTFOLIO SHOWCASE"**
2. Klik tab **"Projects"**
3. **Expected Result:**
   - ✅ Muncul 5 projects dari database
   - ✅ Projects punya tags (React, Next.js, dll)
   - ✅ Ada link GitHub dan Demo
   - ✅ Gambar project muncul

### **3.3 Test Certificates Tab**

1. Klik tab **"Certificates"**
2. **Expected Result:**
   - ✅ Muncul 13 certificates dari database
   - ✅ Tersortir dari terbaru (Des 2024) ke terlama (Nov 2023)
   - ✅ Tombol "Show More" muncul (karena > 6 certs)
   - ✅ Klik certificate → muncul preview modal
   - ✅ Klik "Download Certificate" → buka file

### **3.4 Test Certificates Section (Below Projects)**

1. Scroll ke bawah setelah Projects
2. **Expected Result:**
   - ✅ Muncul section **"Certificates & Achievements"** baru
   - ✅ Menampilkan data yang sama dari database
   - ✅ Layout berbeda (dari CertificatesFromDB component)

### **3.5 Test Contact Form**

1. Scroll ke section **"Get In Touch"**
2. Isi form di bagian kiri:
   - **Nama Anda:** John Doe
   - **Email Anda:** john@example.com
   - **Pesan Anda:** Testing contact form dengan database!
3. Klik **"Kirim Pesan"**
4. **Expected Result:**
   - ✅ Muncul alert "Pesan berhasil dikirim!"
   - ✅ Form ter-reset otomatis
   - ✅ Buka Supabase → Table Editor → `contact_messages` → ada data baru

### **3.6 Test Comments System**

1. Masih di section **"Get In Touch"**
2. Scroll ke bagian kanan (Leave a Comment)
3. Opsional: Upload foto profil (klik icon camera di avatar)
4. Isi form:
   - **Your Name:** Jane Smith
   - **Write your comment:** Amazing portfolio! Keep up the great work!
5. Klik **"Post Comment"**
6. **Expected Result:**
   - ✅ Comment langsung muncul di bawah form
   - ✅ Menampilkan foto profil (upload atau avatar default)
   - ✅ Menampilkan nama dan pesan
   - ✅ Menampilkan timestamp (tanggal & waktu)
   - ✅ Buka Supabase → Table Editor → `comments` → ada data baru

### **3.7 Test Like Comment**

1. Cari comment yang baru dibuat
2. Klik icon ❤️ (heart) di bawah comment
3. **Expected Result:**
   - ✅ Angka likes bertambah +1
   - ✅ Icon heart beranimasi
   - ✅ Data tersimpan di Supabase (reload page → likes tetap bertambah)

---

## 🔄 LANGKAH 4: Customization (Optional)

### **Option A: Gunakan Hanya Database Components**

Edit `src/App.jsx`, uncomment bagian ini (sekitar line 223):

```jsx
{/* 
<motion.div
  initial={{ opacity: 0, y: 50 }}
  whileInView={{ opacity: 1, y: 0 }}
  viewport={{ once: true }}
  transition={{ duration: 0.8 }}
>
  <h2 className="text-4xl md:text-5xl font-bold text-center mb-12">
    <span className="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-emerald-400">
      Projects from Database
    </span>
  </h2>
  <ProjectsFromDB />
</motion.div>
*/}
```

Dan comment out `<ProjectSection />` di atasnya.

### **Option B: Tetap Gunakan ProjectSection dengan Database**

**Tidak perlu ubah apa-apa!** ProjectSection sudah otomatis:
- ✅ Fetch projects dari Supabase
- ✅ Fetch certificates dari Supabase
- ✅ Fallback ke static data jika database kosong
- ✅ Loading state saat fetch data

---

## 📝 LANGKAH 5: Add Your Own Data

### **5.1 Add Projects via Supabase**

1. Buka **Table Editor** → `projects`
2. Klik **"Insert row"**
3. Isi data:
   - `title`: "My New Project"
   - `description`: "Description here"
   - `image_url`: URL gambar
   - `demo_url`: https://demo.com
   - `github_url`: https://github.com/...
   - `tags`: `{"React", "Node.js"}` (format array)
   - `featured`: `true` (untuk featured badge)
4. Klik **"Save"**
5. Refresh browser → project baru muncul!

### **5.2 Add Certificates via SQL**

```sql
INSERT INTO certificates (title, issuer, issue_date, credential_url, image_url)
VALUES (
  'Your Certificate Title',
  'Issuer Name',
  '2025-01-01',
  '/certificates/your-cert.pdf',
  '/certificate-images/your-cert.jpg'
);
```

---

## 🐛 Troubleshooting

### **Problem: Projects tidak muncul**
**Solution:**
1. Cek console browser (F12) untuk error
2. Pastikan SQL sudah di-run
3. Verify data di Table Editor
4. Restart dev server: `Ctrl+C` → `npm run dev`

### **Problem: Certificates masih menampilkan data lama**
**Solution:**
- Data lama (13 certs dari static) akan digantikan oleh data database setelah SQL di-run
- Clear browser cache: `Ctrl+Shift+R`

### **Problem: Contact form error**
**Solution:**
1. Cek `.env` ada `VITE_SUPABASE_URL` dan `VITE_SUPABASE_ANON_KEY`
2. Pastikan table `contact_messages` ada
3. Check RLS policies allow public INSERT

### **Problem: Image tidak muncul**
**Solution:**
- Pastikan path image benar di `public/` folder
- Atau gunakan URL eksternal (https://...)

---

## 📂 File yang Dibuat/Diupdate

### **Baru:**
- ✅ `supabase/insert-projects.sql` - SQL insert 5 projects
- ✅ `supabase/insert-certificates.sql` - SQL insert 13 certificates
- ✅ `src/components/ProjectsFromDB.jsx` - Component fetch projects
- ✅ `src/components/CertificatesFromDB.jsx` - Component fetch certificates
- ✅ `src/components/ContactFormDB.jsx` - Contact form with DB

### **Diupdate:**
- ✅ `src/App.jsx` - Tambah import dan sections baru
- ✅ `src/components/ProjectSection.jsx` - Fetch dari Supabase

---

## ✅ Checklist Akhir

- [ ] ✅ Run `insert-projects.sql` di Supabase
- [ ] ✅ Run `insert-certificates.sql` di Supabase
- [ ] ✅ Verify 5 projects di Table Editor
- [ ] ✅ Verify 13 certificates di Table Editor
- [ ] ✅ Test Projects tab di browser
- [ ] ✅ Test Certificates tab di browser
- [ ] ✅ Test Certificates section (standalone)
- [ ] ✅ Test Contact form submission
- [ ] ✅ Data muncul di Supabase setelah submit

---

## 🚀 Deploy to Production

### **1. Update Environment Variables di Vercel**

Dashboard → Settings → Environment Variables:
- `VITE_SUPABASE_URL` = `https://gbgfgxjjayeaaeaqyary.supabase.co`
- `VITE_SUPABASE_ANON_KEY` = `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

### **2. Deploy**

```bash
git add .
git commit -m "feat: integrate projects and certificates with Supabase"
git push origin main
```

Vercel will auto-deploy! 🎉

---

**Selamat! Portfolio Anda sekarang menggunakan database Supabase! 🎊**
