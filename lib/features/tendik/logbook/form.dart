import 'package:flutter/material.dart';
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
  ];

  // List Dummy Satuan Kuantitas
  final List<String> _listSatuan = ['Item', 'Dokumen', 'Sistem', 'Laporan'];

  // Helper Date Picker
  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
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
                              Container(
                                width: double.infinity,
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
                                    value: _selectedJabatan,
                                    isExpanded: true,
                                    items: _listJabatan.map((String value) {
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
                                          _selectedJabatan = newValue;
                                        });
                                      }
                                    },
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Logbook berhasil disimpan'),
                                ),
                              );
                              Navigator.of(context).pop();
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
