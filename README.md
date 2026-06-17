# 🚀 CLI Server Stats Dashboard

Bosan ngecek performa server pakai perintah `top`, `free -m`, dan `df -h` manual satu-satu? 

Script Bash ini merangkum semua metrik penting server Linux kamu ke dalam satu *dashboard* CLI yang rapi, interaktif (live reload), dan berwarna. Gak perlu *install* *dependencies* atau *tools* aneh-aneh (seperti `htop` atau `bc`), semuanya pakai bawaan asli Linux.

![Dashboard Preview](https://via.placeholder.com/800x400.png?text=Ganti+Gambar+Ini+Dengan+Screenshot/GIF+Terminal+Kamu)

> **Project URL:** [https://github.com/username-kamu/nama-repo-kamu](https://github.com/username-kamu/nama-repo-kamu)  
> *(Catatan untuk penilai: Karena proyek ini berupa script CLI dan bukan web app, link di atas mengarah kembali ke repository ini).*

---

## ✨ Fitur

- **Live Dashboard:** Berjalan terus-menerus dengan *auto-refresh* (seperti *task manager*).
- **Color-Coded CPU:** Indikator warna dinamis (Hijau = Aman, Kuning = Sedang, Merah = Bahaya/Overload).
- **Tanpa Dependencies Eksternal:** Kalkulasi CPU murni hasil *parsing* file `/proc/stat`.
- **Informasi Lengkap:**
  - OS Version, Uptime, Load Average, & Active Users.
  - Total Memory & Disk Usage (Terpakai, Bebas, dan Persentase).
  - Top 5 Proses yang paling banyak makan CPU.
  - Top 5 Proses yang paling banyak makan RAM.
  - Total percobaan *login* yang gagal (Security check).

## 🛠️ Persyaratan Sistem

Script ini didesain universal untuk hampir semua distro Linux (Ubuntu, Debian, CentOS, RHEL, dll). Cukup pastikan *environment* kamu mendukung utilitas standar seperti `bash`, `awk`, `ps`, dan `df`.

## 🚀 Cara Penggunaan

Tinggal *clone* dan jalankan. Gak pakai ribet.

1. **Clone repository ini:**
   ```bash
   git clone [https://github.com/dryuxxinn/ServerStat-sys_dash/tree/maingit](https://github.com/dryuxxinn/ServerStat-sys_dash/tree/main.git)
   cd nama-repo-kamu
