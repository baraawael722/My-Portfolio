-- ========================================
-- INSERT CERTIFICATES DATA
-- Exported from ProjectSection.jsx
-- ========================================

-- Clear existing certificates (optional)
-- DELETE FROM certificates;

-- Insert all certificates
INSERT INTO certificates (title, issuer, issue_date, credential_url, image_url)
VALUES
  (
    'Belajar Membuat Aplikasi Web dengan React',
    'Dicoding Indonesia',
    '2024-12-01',
    '/certificates/Belajar Membuat Aplikasi Web dengan React.pdf',
    '/certificate-images/Belajar Membuat Aplikasi Web dengan React.jpg'
  ),
  (
    'Belajar Dasar Pemrograman JavaScript',
    'Dicoding Indonesia',
    '2024-12-01',
    '/certificates/Belajar Dasar Pemrograman JavaScript.pdf',
    '/certificate-images/Belajar Dasar Pemrograman JavaScript.jpg'
  ),
  (
    'Junior Web Developer (BNSP)',
    'Badan Nasional Sertifikasi Profesi (BNSP)',
    '2024-09-01',
    '/certificates/SERTIFIKAT BNSP JUNIOR WEB DEVELOPER ZAIN AHMAD FAHREZI.jpeg',
    '/certificate-images/SERTIFIKAT BNSP JUNIOR WEB DEVELOPER ZAIN AHMAD FAHREZI.jpg'
  ),
  (
    'Belajar Membuat Front-End Web untuk Pemula',
    'Dicoding Indonesia',
    '2024-12-01',
    '/certificates/Belajar Membuat Front-End Web untuk Pemula.pdf',
    '/certificate-images/Belajar Membuat Front-End Web untuk Pemula.jpg'
  ),
  (
    'Operator Komputer Madya (BNSP)',
    'Badan Nasional Sertifikasi Profesi (BNSP)',
    '2024-12-01',
    '/certificates/Operator Komputer Madya BNSP.jpeg',
    '/certificate-images/Operator Komputer Madya BNSP.jpg'
  ),
  (
    'Belajar Dasar Data Science',
    'Dicoding Indonesia',
    '2024-10-01',
    '/certificates/Belajar Dasar Data Science.pdf',
    '/certificate-images/Belajar Dasar Data Science.jpg'
  ),
  (
    'Belajar Dasar Structured Query Language (SQL)',
    'Dicoding Indonesia',
    '2024-10-01',
    '/certificates/Belajar Dasar Structured Query Language (SQL).pdf',
    '/certificate-images/Belajar Dasar Structured Query Language (SQL).jpg'
  ),
  (
    'Belajar Dasar AI',
    'Dicoding Indonesia',
    '2024-09-01',
    '/certificates/Belajar Dasar AI.pdf',
    '/certificate-images/Belajar Dasar AI.jpg'
  ),
  (
    'Belajar Dasar Manajemen Proyek',
    'Dicoding Indonesia',
    '2024-09-01',
    '/certificates/Belajar Dasar Manajemen Proyek.pdf',
    '/certificate-images/Belajar Dasar Manajemen Proyek.jpg'
  ),
  (
    'Operator Komputer Madya (VSGA)',
    'Digital Talent Scholarship',
    '2024-08-01',
    '/certificates/Operator Komputer Madya VSGA.pdf',
    '/certificate-images/Operator Komputer Madya VSGA.jpg'
  ),
  (
    'Junior Web Developer (VSGA)',
    'Kominfo',
    '2024-07-01',
    '/certificates/Junior Web Developer VSGA.pdf',
    '/certificate-images/Junior Web Developer VSGA.jpg'
  ),
  (
    'Java Fundamentals',
    'Oracle',
    '2024-06-01',
    '/certificates/JAVA FUNDAMENTALS.pdf',
    '/certificate-images/JAVA FUNDAMENTALS.jpg'
  ),
  (
    'Belajar Dasar Pemrograman Web',
    'Dicoding Indonesia',
    '2023-11-01',
    '/certificates/Belajar Dasar Pemrograman Web.pdf',
    '/certificate-images/Belajar Dasar Pemrograman Web.jpg'
  );

-- ========================================
-- VERIFY DATA
-- ========================================

-- Check total certificates inserted
SELECT COUNT(*) as total_certificates FROM certificates;

-- View all certificates
SELECT 
  title,
  issuer,
  issue_date,
  created_at
FROM certificates
ORDER BY issue_date DESC;

-- ========================================
-- SUCCESS MESSAGE
-- ========================================

DO $$
BEGIN
  RAISE NOTICE '✅ Successfully inserted 13 certificates!';
  RAISE NOTICE '📜 Data exported from Zain Ahmad Fahrezi portfolio';
END $$;
