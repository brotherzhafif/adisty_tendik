import 'package:flutter/material.dart';
import '../../data/models/presensi_hari_ini_model.dart';

class InfoPresensiCard extends StatelessWidget {
  final PresensiHariIniDetailModel? detail;

  const InfoPresensiCard({super.key, this.detail});

  @override
  Widget build(BuildContext context) {
    final dateValue = detail?.date.isNotEmpty == true
        ? detail!.date
        : 'Rabu, 9 September 2023';
    final statusValue = detail?.statusPresensi.isNotEmpty == true
        ? detail!.statusPresensi
        : 'On time';
    final locationValue = detail?.location.isNotEmpty == true
        ? detail!.location
        : 'Kampus 4';
    final transportValue = detail?.transport.isNotEmpty == true
        ? detail!.transport
        : 'Rp 20.000';
    final jamMasukValue = detail?.jamMasuk.isNotEmpty == true
        ? detail!.jamMasuk
        : '07.00';
    final jamPulangValue = detail?.jamPulang.isNotEmpty == true
        ? detail!.jamPulang
        : '-';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            iconBgColor: const Color(0x1E4AAF57),
            iconColor: const Color(0xFF4AAF57),
            icon: Icons.calendar_today_rounded,
            label: 'Tanggal',
            value: dateValue,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            iconBgColor: const Color(0x1E2B86C3),
            iconColor: const Color(0xFF2B86C3),
            icon: Icons.check_circle_outline_rounded,
            label: 'Status Presensi',
            value: statusValue,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            iconBgColor: const Color(0x1EE65768),
            iconColor: const Color(0xFFE65768),
            icon: Icons.location_on_outlined,
            label: 'Lokasi',
            value: locationValue,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            iconBgColor: const Color(0x1E2B86C3),
            iconColor: const Color(0xFF2B86C3),
            icon: Icons.directions_car_outlined,
            label: 'Transport',
            value: transportValue,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            iconBgColor: const Color(0x1E4AAF57),
            iconColor: const Color(0xFF4AAF57),
            icon: Icons.login_rounded,
            label: 'Jam Masuk',
            value: jamMasukValue,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            iconBgColor: const Color(0x1EFFA426),
            iconColor: const Color(0xFFFFA426),
            icon: Icons.logout_rounded,
            label: 'Jam Pulang',
            value: jamPulangValue,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required Color iconBgColor,
    required Color iconColor,
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(
                  width: 0.50,
                  color: Color(0xFFE0E0E0),
                ),
              ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
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
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFF5F6570),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  letterSpacing: -0.08,
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
                  letterSpacing: -0.27,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
