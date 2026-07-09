import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ============================================================
// HALAMAN: Form Koreksi Presensi
// Mengajukan koreksi jam masuk/pulang presensi yang salah.
// ============================================================
class FormKoreksiPage extends StatefulWidget {
  const FormKoreksiPage({super.key});

  @override
  State<FormKoreksiPage> createState() => _FormKoreksiPageState();
}

class _FormKoreksiPageState extends State<FormKoreksiPage> {
  final _formKey = GlobalKey<FormState>();

  // State Inputs
  TimeOfDay _jamMasuk = const TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _jamPulang = const TimeOfDay(hour: 16, minute: 0);
  String _alasanKoreksi = 'Saya lupa melakukan presensi';
  final List<String> _uploadedFiles = [];

  // Pilihan Alasan
  final List<String> _listAlasan = [
    'Saya lupa melakukan presensi',
    'Kendala perangkat/aplikasi error',
    'Dinas luar kota / tugas dinas',
    'Salah menekan tombol presensi',
    'Lainnya',
  ];

  // Helper format jam ke string HH:mm
  String _formatTime(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Slide Time Picker (Cupertino modal popup)
  Future<void> _selectTimeCupertino(BuildContext context, bool isMasuk) async {
    final TimeOfDay initialTime = isMasuk ? _jamMasuk : _jamPulang;
    final DateTime initialDateTime = DateTime(2026, 1, 1, initialTime.hour, initialTime.minute);

    final DateTime? selectedDateTime = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        DateTime tempDateTime = initialDateTime;
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              // Header picker
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
                    Text(
                      isMasuk ? 'Pilih Jam Masuk Baru' : 'Pilih Jam Pulang Baru',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, tempDateTime),
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
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime: initialDateTime,
                  onDateTimeChanged: (DateTime newDateTime) {
                    tempDateTime = newDateTime;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selectedDateTime != null) {
      setState(() {
        final time = TimeOfDay(hour: selectedDateTime.hour, minute: selectedDateTime.minute);
        if (isMasuk) {
          _jamMasuk = time;
        } else {
          _jamPulang = time;
        }
      });
    }
  }

  // Simulasi upload file
  void _uploadMockFile() {
    if (_uploadedFiles.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maksimal 3 file bukti')),
      );
      return;
    }
    setState(() {
      final int fileNumber = _uploadedFiles.length + 1;
      _uploadedFiles.add('bukti_presensi_$fileNumber.jpg');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Koreksi Presensi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F7F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Data Presensi Saat Ini ---
                _buildDataPresensiSaatIni(),
                
                const SizedBox(height: 16),

                // --- Form Koreksi Putih ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0x3DEBEBEB)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x087281DF),
                        blurRadius: 4.11,
                        offset: Offset(0, 0.52),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Form Koreksi',
                        style: TextStyle(
                          color: Color(0xFF293241),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      // --- Input Jam Masuk Baru ---
                      _InputFieldLabel(label: 'Jam Masuk Baru', isRequired: true),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () => _selectTimeCupertino(context, true),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF99A1AF)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatTime(_jamMasuk),
                                style: const TextStyle(
                                  color: Color(0xFF293241),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(Icons.access_time_rounded, color: Color(0xFF7A8089), size: 20),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // --- Input Jam Pulang Baru ---
                      _InputFieldLabel(label: 'Jam Pulang Baru', isRequired: true),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () => _selectTimeCupertino(context, false),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF99A1AF)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatTime(_jamPulang),
                                style: const TextStyle(
                                  color: Color(0xFF293241),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(Icons.access_time_rounded, color: Color(0xFF7A8089), size: 20),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // --- Dropdown Alasan Koreksi ---
                      _InputFieldLabel(label: 'Alasan Koreksi', isRequired: true),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF99A1AF)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _alasanKoreksi,
                            isExpanded: true,
                            items: _listAlasan.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Color(0xFF293241),
                                    fontSize: 13,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _alasanKoreksi = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // --- Upload File Bukti ---
                      _buildUploadSection(),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // --- Form Action Button Row ---
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.5, color: Color(0xFF0067AD)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Batal',
                              style: TextStyle(
                                color: Color(0xFF0067AD),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pengajuan Koreksi Presensi dikirim')),
                          );
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF0067AD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Kirim Pengajuan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget: Data Presensi Saat Ini ---
  Widget _buildDataPresensiSaatIni() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFFE8F1F9),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x3DEBEBEB)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data presensi saat ini',
            style: TextStyle(
              color: Color(0xFF293241),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildMiniInfoRow(
                      icon: Icons.calendar_today,
                      iconColor: const Color(0xFF4AAF57),
                      iconBg: const Color(0x1E4AAF57),
                      label: 'Tanggal',
                      value: 'Rabu, 9 Sep 2023',
                    ),
                    const Divider(height: 16, color: Color(0xFFD4E1EE)),
                    _buildMiniInfoRow(
                      icon: Icons.login,
                      iconColor: const Color(0xFF4AAF57),
                      iconBg: const Color(0x1E4AAF57),
                      label: 'Jam Masuk',
                      value: '07.00',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _buildMiniInfoRow(
                      icon: Icons.location_on,
                      iconColor: const Color(0xFFE65768),
                      iconBg: const Color(0x1EE65768),
                      label: 'Lokasi',
                      value: 'Kampus 4',
                    ),
                    const Divider(height: 16, color: Color(0xFFD4E1EE)),
                    _buildMiniInfoRow(
                      icon: Icons.logout,
                      iconColor: const Color(0xFFFFA426),
                      iconBg: const Color(0x1EFFA426),
                      label: 'Jam Pulang',
                      value: '-',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniInfoRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF5F6570),
                  fontSize: 11,
                  fontFamily: 'Nunito',
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF293241),
                  fontSize: 13,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Widget: Upload File Section ---
  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Upload Bukti ',
                style: TextStyle(
                  color: Color(0xFF0A0A0A),
                  fontSize: 13,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '(Opsional)',
                style: TextStyle(
                  color: Color(0xFF7A8089),
                  fontSize: 12,
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Maksimal 3 file · JPG, PNG, PDF · Maks. 5MB per file',
          style: TextStyle(
            color: Color(0xFF7A8089),
            fontSize: 11,
            fontFamily: 'Nunito',
          ),
        ),
        const SizedBox(height: 8),
        
        // Dnd / click upload box
        InkWell(
          onTap: _uploadMockFile,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFAEB1B7)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: const [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 32,
                  color: Color(0xFF0067AD),
                ),
                SizedBox(height: 8),
                Text(
                  'Pilih file bukti disini',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        // List File yang ter-upload
        if (_uploadedFiles.isNotEmpty) ...[
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _uploadedFiles.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                color: const Color(0xFFF6F7F9),
                margin: const EdgeInsets.only(bottom: 6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.insert_drive_file_outlined, color: Color(0xFF0067AD), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _uploadedFiles[index],
                            style: const TextStyle(fontSize: 12, fontFamily: 'Nunito'),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFE65768), size: 20),
                        onPressed: () {
                          setState(() {
                            _uploadedFiles.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Label input
// ============================================================
class _InputFieldLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const _InputFieldLabel({required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0A0A0A),
            fontSize: 13,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              color: Color(0xFFFB2C36),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
