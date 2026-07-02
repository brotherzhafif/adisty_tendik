import 'package:flutter/material.dart';

class FormKoreksiPage extends StatelessWidget {
  const FormKoreksiPage({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDataPresensiSaatIni(),
              const SizedBox(height: 15),
              _buildFormKoreksi(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF0067AD),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              color: Color(0xFF0067AD),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Submit logic
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF0067AD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Kirim Pengajuan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
    );
  }

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
                    const Divider(height: 16, color: Color(0xFFE0E0E0)),
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
                    const Divider(height: 16, color: Color(0xFFE0E0E0)),
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
                  fontSize: 12,
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

  Widget _buildFormKoreksi() {
    return Container(
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
            color: Color(0xA3A5A5A5),
            blurRadius: 2,
            offset: Offset(0, 0),
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
          _buildInputField(
            label: 'Jam Masuk Baru',
            value: '07:30',
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            label: 'Jam Pulang Baru',
            value: '16:00',
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            label: 'Alasan Koreksi',
            value: 'Saya lupa melakukan presensi',
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildUploadField(),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF0A0A0A),
                fontSize: 12,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isRequired)
              const Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFFB2C36),
                  fontSize: 12,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF99A1AF)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF7A8089),
              fontSize: 14,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF0A0A0A),
                fontSize: 12,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isRequired)
              const Text(
                '*',
                style: TextStyle(
                  color: Color(0xFFFB2C36),
                  fontSize: 12,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF99A1AF)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF7A8089),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Color(0xFF7A8089)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadField() {
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
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '(Opsional)',
                style: TextStyle(
                  color: Color(0xFF7A8089),
                  fontSize: 14,
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
            fontSize: 12,
            fontFamily: 'Nunito',
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
                'Pilih file atau drag & drop disini',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Upload rapor dalam format PDF, maksimal 5MB',
                style: TextStyle(
                  color: Color(0xFF7A8089),
                  fontSize: 12,
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
