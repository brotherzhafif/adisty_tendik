import 'package:flutter/material.dart';

class InfoPresensiCard extends StatelessWidget {
  const InfoPresensiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            iconBgColor: const Color(0x1E4AAF57),
            icon: const Icon(Icons.calendar_today, color: Color(0xFF4AAF57), size: 20),
            label: 'Tanggal',
            value: 'Rabu, 9 September 2023',
          ),
          _buildInfoRow(
            iconBgColor: const Color(0x1E2B86C3),
            icon: const Icon(Icons.check_circle_outline, color: Color(0xFF2B86C3), size: 20),
            label: 'Status Presensi',
            value: 'On time',
          ),
          _buildInfoRow(
            iconBgColor: const Color(0x1EE65768),
            icon: const Icon(Icons.location_on_outlined, color: Color(0xFFE65768), size: 20),
            label: 'Lokasi',
            value: 'Kampus 4',
          ),
          _buildInfoRow(
            iconBgColor: const Color(0x1E2B86C3),
            icon: const Icon(Icons.directions_car_outlined, color: Color(0xFF2B86C3), size: 20),
            label: 'Transport',
            value: 'Rp 20.000',
          ),
          _buildInfoRow(
            iconBgColor: const Color(0x1E4AAF57),
            icon: const Icon(Icons.login, color: Color(0xFF4AAF57), size: 20),
            label: 'Jam Masuk',
            value: '07.00',
          ),
          _buildInfoRow(
            iconBgColor: const Color(0x1EFFA426),
            icon: const Icon(Icons.logout, color: Color(0xFFFFA426), size: 20),
            label: 'Jam Pulang',
            value: '-',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required Color iconBgColor,
    required Widget icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: isLast
          ? null
          : const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.50, color: Color(0xFFE0E0E0)),
              ),
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: iconBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF5F6570),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
              Text(
                value,
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
        ],
      ),
    );
  }
}
