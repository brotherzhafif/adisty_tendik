# Modul Tendik & Global Error Gateway - Adisty UAD

Modul ini dikembangkan secara mandiri (*self-contained*) dengan pendekatan **Feature-First Architecture** untuk diintegrasikan ke dalam aplikasi utama Adisty UAD tanpa merusak atau mengubah kode pada modul Mahasiswa maupun Dosen.

## 📁 Struktur Direktori Modul

Seluruh komponen fitur diisolasi di dalam folder `lib/features/`:

```text
lib/features/
├── global_error/          # Fitur Pencegat & Halaman Error Global
│   ├── bloc/              # State management halaman error
│   ├── data/              # Dio Interceptor (Error Gateway)
│   └── presentation/      # UI Global Error Page
└── tendik/                # Utama: Fitur Tenaga Kependidikan
    ├── home_presensi/     # Dashboard Presensi (2 Versi Layout)
    │   ├── bloc/          # Otak pengatur state presensi & device context
    │   ├── data/          # Service Hardware (GPS, IP, Device Info) & API Repo
    │   └── presentation/  # UI Dashboard & Reusable Widgets
    ├── logbook/           # Fitur Pengisian dan Monitoring Logbook Pegawai
    ├── notifikasi/        # Fitur Notifikasi Tendik
    ├── presensi_hari_ini/ # Detail Presensi Hari Ini
    ├── rekap_presensi/    # Fitur Rekapitulasi Presensi per Bulan
    ├── skp/               # Fitur Pemantauan Total Skor SKP (Sasaran Kinerja Pegawai)
    └── tunjangan_beras/   # Fitur Klaim/Informasi Tunjangan Beras
```

## 🏗️ Arsitektur
Modul ini menggunakan **Clean Architecture** yang dikombinasikan dengan state management **BLoC**.
Setiap fitur (misalnya `logbook`, `skp`, `rekap_presensi`) memiliki struktur independen yang mencakup `bloc`, `data`, `domain`, dan `presentation` / `widgets`.

## 🛠️ State Management & Data
- Semua logic bisnis dikontrol menggunakan BLoC pattern.
- Data tiruan (mock data) disimpan di dalam folder `assets/data/` berformat JSON (`logbook.json`, `skp.json`, `monitoring_presensi.json`, dsb) yang di-parsing ke model secara modular.