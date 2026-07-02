import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatistikPresensiV1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 6,
        children: [
          // Jumlah Presensi bulan ini
          StatistikItem(
            iconColor: const Color(0xFFFB7F54),
            bgColor: const Color(0x1EFB7F54),
            iconPath: 'assets/icons/(home_page)_people-icon.svg',
            label: 'Jumlah Presensi',
            value: '19',
            valueColor: const Color(0xFFFB7F54),
            subLabel: 'Bulan ini',
            subLabelColor: const Color(0xFFFB7F54),
          ),

          // Status Presensi
          StatistikItem(
            iconColor: const Color(0xFF18C079),
            bgColor: const Color(0x1E4AAF57),
            iconPath: 'assets/icons/(home_page)_shield-icon.svg',
            label: 'Status Presensi',
            value: 'On Time',
            valueColor: const Color(0xFF18C079),
            subLabel: 'Excellent!',
            subLabelColor: const Color(0xFF18C079),
          ),
        ],
      ),
    );
  }
}

class StatistikItem extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final String iconPath;
  final String label;
  final String value;
  final Color valueColor;
  final String subLabel;
  final Color subLabelColor;

  const StatistikItem({
    required this.iconColor,
    required this.bgColor,
    required this.iconPath,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.subLabel,
    required this.subLabelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 179,
      padding: const EdgeInsets.only(top: 8, left: 12, right: 6, bottom: 8),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          // Ikon
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),

          // Label, nilai, & sub-label
          SizedBox(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label atas
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF293241),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                  ),
                ),

                // Nilai utama
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: valueColor,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                      letterSpacing: -0.34,
                    ),
                  ),
                ),

                // Sub-label bawah
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    subLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: subLabelColor,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
