import 'package:flutter/material.dart';

enum StatusPengajuan { menunggu, disetujui, ditolak }

class RiwayatPengajuanItem extends StatelessWidget {
  final StatusPengajuan status;
  final String date;
  final String type;
  final String diajukan;
  final String perubahanLabel;
  final String oldValue;
  final String newValue;
  final VoidCallback onDetailTap;

  const RiwayatPengajuanItem({
    super.key,
    required this.status,
    required this.date,
    required this.type,
    required this.diajukan,
    required this.perubahanLabel,
    required this.oldValue,
    required this.newValue,
    required this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBgColor;
    Color iconBgColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case StatusPengajuan.menunggu:
        statusColor = const Color(0xFFFFAC2F);
        statusBgColor = const Color(0x19FFAC2F);
        iconBgColor = const Color(0x4CFFAC2F);
        statusText = 'Menunggu verifikasi';
        statusIcon = Icons.access_time;
        break;
      case StatusPengajuan.disetujui:
        statusColor = const Color(0xFF4AAF57);
        statusBgColor = const Color(0x194AAF57);
        iconBgColor = const Color(0x4C4AAF57);
        statusText = 'Disetujui';
        statusIcon = Icons.check;
        break;
      case StatusPengajuan.ditolak:
        statusColor = const Color(0xFFE65768);
        statusBgColor = const Color(0x19E65768);
        iconBgColor = const Color(0x4CE65768);
        statusText = 'Ditolak';
        statusIcon = Icons.close;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      margin: const EdgeInsets.only(bottom: 16),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 33,
              bottom: 8,
            ),
            decoration: ShapeDecoration(
              color: statusBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: iconBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Center(
                    child: Icon(statusIcon, color: statusColor, size: 24),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 1.43,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Date & Type
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFFF0F1F2)),
                right: BorderSide(color: Color(0xFFF0F1F2)),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.50, color: Color(0xFFE0E0E0)),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.assignment,
                    color: Color(0xFF2B86C3),
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type,
                          style: const TextStyle(
                            color: Color(0xFF5F6570),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Color(0xFF293241),
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          'Diajukan',
                          style: TextStyle(
                            color: Color(0xFF5F6570),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF5F6570),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                diajukan,
                                style: const TextStyle(
                                  color: Color(0xFF5F6570),
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          'Perubahan',
                          style: const TextStyle(
                            color: Color(0xFF5F6570),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          perubahanLabel,
                          style: const TextStyle(
                            color: Color(0xFF5F6570),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                oldValue,
                                style: const TextStyle(
                                  color: Color(0xFFFFAC2F),
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Color(0xFF5F6570),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                newValue,
                                style: const TextStyle(
                                  color: Color(0xFFFFAC2F),
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // View detail link
          InkWell(
            onTap: onDetailTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.50, color: Color(0xFFE0E0E0)),
                ),
              ),
              child: const Text(
                'Lihat Detail',
                style: TextStyle(
                  color: Color(0xFF016EB8),
                  fontSize: 12,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  height: 1.33,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
