# Biodata Flutter App 📱

Aplikasi CRUD (Create, Read, Update, Delete) biodata siswa berbasis Flutter yang terintegrasi dengan database MySQL menggunakan API PHP.

## 🚀 Fitur
- **Tampil Data**: Menampilkan daftar biodata dari database.
- **Tambah Data**: Input data siswa baru.
- **Edit Data**: Memperbarui informasi biodata yang sudah ada.
- **Hapus Data**: Menghapus data dari sistem.
- **Detail View**: Melihat informasi lengkap per individu.

## 🛠️ Teknologi yang Digunakan
- **Frontend**: [Flutter](https://flutter.dev/) (Dart)
- **Backend**: PHP (sebagai REST API)
- **Database**: MySQL
- **HTTP Client**: Package `http` untuk koneksi Flutter ke API.

## 📁 Struktur Folder Utama
```text
lib/
├── models/      # Model data (api.dart, msiswa.dart)
├── views/       # Antarmuka pengguna (home, create, edit, details)
├── widgets/     # Komponen UI reusable (form.dart)
└── main.dart    # Titik masuk utama aplikasi
