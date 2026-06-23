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
    └── home_presensi/     # Dashboard Presensi (2 Versi Layout)
        ├── bloc/          # Otak pengatur state presensi & device context
        ├── data/          # Service Hardware (GPS, IP, Device Info) & API Repo
        └── presentation/  # UI Dashboard & Reusable Widgets