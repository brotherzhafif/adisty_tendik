import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:adisty_tendik_module/core/widgets/app_dialog.dart';
import 'widgets/logbook_app_bar.dart';

// ============================================================
// HALAMAN: Tambah Logbook (Form)
// Form interaktif untuk menambah atau mengedit data logbook.
// ============================================================
class LogbookFormPage extends StatefulWidget {
  const LogbookFormPage({super.key});

  @override
  State<LogbookFormPage> createState() => _LogbookFormPageState();
}

class _LogbookFormPageState extends State<LogbookFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Form State
  DateTime _selectedDate = DateTime(2026, 7, 10);
  String _selectedJabatan = 'Utama Programmer';
  int _kuantitas = 1;
  String _selectedSatuan = 'Item';
  final TextEditingController _uraianController = TextEditingController();

  // List Dummy Pilihan Jabatan
  final List<String> _listJabatan = [
    'Utama Programmer',
    'Sub Direktorat Pengembangan',
    'Administrator Sistem',
    'Analis Kebijakan',
    'Analis Kepegawaian',
    'Analis Keuangan',
    'Analis Pengadaan',
    'Arsiparis',
    'Auditor Internal',
    'Bendahara Pengeluaran',
    'Bendahara Penerimaan',
    'Desainer Grafis',
    'Dokter Kampus',
    'Front Office Staff',
    'Humas dan Protokol',
    'Instruktur Lab Komputer',
    'Instruktur Lab Bahasa',
    'Junior Programmer',
    'Kabag Akademik',
    'Kabag Kemahasiswaan',
    'Kabag Keuangan',
    'Kabag Kepegawaian',
    'Kabag Umum',
    'Kasubag Administrasi',
    'Kasubag Keuangan',
    'Kasubag Rumah Tangga',
    'Kepala Biro SDM',
    'Kepala Biro Keuangan',
    'Kepala UPT Perpustakaan',
    'Kepala UPT TIK',
    'Koordinator Layanan Akademik',
    'Laboran',
    'Manajer Aset',
    'Operator SIAKAD',
    'Operator Keuangan',
    'Operator Kepegawaian',
    'Petugas Kebersihan',
    'Petugas Keamanan',
    'Petugas Perpustakaan',
    'Pranata Humas',
    'Pranata Komputer',
    'Pranata Laboratorium',
    'Sekretaris Dekan',
    'Sekretaris Rektor',
    'Senior Programmer',
    'Staf Administrasi',
    'Staf Keuangan',
    'Staf Pengadaan',
    'Staf Perpustakaan',
    'Teknisi Jaringan',
    'Teknisi Perangkat Keras',
    'Tenaga Kearsipan',
  ];

  // List Dummy Satuan Kuantitas
  final List<String> _listSatuan = ['Item', 'Dokumen', 'Sistem', 'Laporan'];

  // Helper Date Picker (iOS-style Cupertino modal)
  Future<void> _pilihTanggal(BuildContext context) async {
    DateTime tempDate = _selectedDate;

    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          color: Color(0xFFE65768),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const Text(
                      'Pilih Tanggal',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, tempDate),
                      child: const Text(
                        'Pilih',
                        style: TextStyle(
                          color: Color(0xFF0067AD),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  minimumDate: DateTime(2020),
                  maximumDate: DateTime(2030, 12, 31),
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Helper Jabatan Picker (Modal Bottom Sheet)
  Future<void> _pilihJabatan(BuildContext context) async {
    final String? result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _JabatanPickerModal(
        listJabatan: _listJabatan,
        selectedJabatan: _selectedJabatan,
      ),
    );
    if (result != null) {
      setState(() {
        _selectedJabatan = result;
      });
    }
  }

  @override
  void dispose() {
    _uraianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String labelTanggal =
        '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}';

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          // --- AppBar ---
          LogbookAppBar(
            title: 'Tambah Logbook',
            onBack: () => Navigator.of(context).maybePop(),
          ),

          // --- Konten Form ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                color: Color(0xFFF6F7F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // --- Card Container Putih ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x087281DF),
                                blurRadius: 4.11,
                                offset: Offset(0, 0.52),
                              ),
                              BoxShadow(
                                color: Color(0x0C7281DF),
                                blurRadius: 6.99,
                                offset: Offset(0, 1.78),
                              ),
                              BoxShadow(
                                color: Color(0x0F7281DF),
                                blurRadius: 10.20,
                                offset: Offset(0, 4.11),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title Form
                              const Text(
                                'Tambah Logbook Tenaga Kependidikan',
                                style: TextStyle(
                                  color: Color(0xFF2B86C3),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.43,
                                  letterSpacing: -0.08,
                                ),
                              ),

                              const SizedBox(height: 16),

                              // --- Input 1: Tanggal ---
                              const _InputLabel(label: 'Tanggal'),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () => _pilihTanggal(context),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE7E8E9),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        labelTanggal,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.calendar_month_rounded,
                                        color: Color(0xFFAEB1B7),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // --- Input 2: Jabatan Pekerjaan ---
                              const _InputLabel(label: 'Jabatan Pekerjaan'),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () => _pilihJabatan(context),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE7E8E9),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _selectedJabatan,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFFAEB1B7),
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // --- Input 3: Kuantitas & Satuan ---
                              const _InputLabel(label: 'Kuantitas'),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  // Angka Kuantitas
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFE7E8E9),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove_rounded,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              if (_kuantitas > 1) {
                                                setState(() => _kuantitas--);
                                              }
                                            },
                                          ),
                                          Text(
                                            '$_kuantitas',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_rounded,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              setState(() => _kuantitas++);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // Jenis Satuan Dropdown
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFE7E8E9),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedSatuan,
                                          isExpanded: true,
                                          items: _listSatuan.map((
                                            String value,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            if (newValue != null) {
                                              setState(() {
                                                _selectedSatuan = newValue;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // --- Input 4: Uraian Aktivitas ---
                              const _InputLabel(
                                label: 'Uraian Aktivitas',
                                isRequired: true,
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _uraianController,
                                maxLines: 6,
                                maxLength: 2000,
                                decoration: InputDecoration(
                                  hintText:
                                      'Tulis uraian aktivitas Anda di sini...',
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFAEB1B7),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE7E8E9),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE7E8E9),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Uraian aktivitas wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // --- Tombol Aksi ---
                        _FormActions(
                          onBatal: () => Navigator.of(context).maybePop(),
                          onSimpan: () {
                            if (_formKey.currentState!.validate()) {
                              // Simulasikan penyimpanan data sukses
                              showAppDialog(
                                context,
                                type: AppDialogType.success,
                                title: 'Logbook Tersimpan',
                                message: 'Data logbook Anda berhasil disimpan.',
                                onClose: () => Navigator.of(context).pop(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Label input form
// ============================================================
class _InputLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const _InputLabel({required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Color(0xFFE65768),
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Row tombol Batal & Simpan
// ============================================================
class _FormActions extends StatelessWidget {
  final VoidCallback onBatal;
  final VoidCallback onSimpan;

  const _FormActions({required this.onBatal, required this.onSimpan});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Tombol Batal
        Expanded(
          child: OutlinedButton(
            onPressed: onBatal,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFF2B86C3), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: Color(0xFF2B86C3),
                fontSize: 14,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Tombol Simpan
        Expanded(
          child: ElevatedButton(
            onPressed: onSimpan,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B86C3),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Simpan',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Modal Picker Jabatan Pekerjaan
// Modal bottom sheet dengan search bar + daftar scrollable
// ============================================================
class _JabatanPickerModal extends StatefulWidget {
  final List<String> listJabatan;
  final String selectedJabatan;

  const _JabatanPickerModal({
    required this.listJabatan,
    required this.selectedJabatan,
  });

  @override
  State<_JabatanPickerModal> createState() => _JabatanPickerModalState();
}

class _JabatanPickerModalState extends State<_JabatanPickerModal> {
  late List<String> _filtered;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = List.from(widget.listJabatan);
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = widget.listJabatan
          .where((j) => j.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // --- Handle bar ---
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDE0E5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // --- Header ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Pilih Jabatan Pekerjaan',
                        style: TextStyle(
                          color: Color(0xFF293241),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF5F6570)),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),

              // --- Search Bar ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  autofocus: false,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Cari jabatan...',
                    hintStyle: const TextStyle(
                      color: Color(0xFFAEB1B7),
                      fontSize: 13,
                      fontFamily: 'Nunito',
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFFAEB1B7),
                      size: 20,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                color: Color(0xFFAEB1B7), size: 18),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF6F7F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const Divider(height: 1, color: Color(0xFFEEEFF1)),

              // --- Daftar Jabatan ---
              Expanded(
                child: _filtered.isEmpty
                    ? const Center(
                        child: Text(
                          'Jabatan tidak ditemukan',
                          style: TextStyle(
                            color: Color(0xFFAEB1B7),
                            fontSize: 13,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _filtered.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          indent: 20,
                          endIndent: 20,
                          color: Color(0xFFF1F2F4),
                        ),
                        itemBuilder: (context, index) {
                          final jabatan = _filtered[index];
                          final isSelected = jabatan == widget.selectedJabatan;
                          return InkWell(
                            onTap: () => Navigator.of(context).pop(jabatan),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      jabatan,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? const Color(0xFF0067AD)
                                            : const Color(0xFF293241),
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_rounded,
                                      color: Color(0xFF0067AD),
                                      size: 20,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
