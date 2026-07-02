import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatistikPresensiV2 extends StatelessWidget {
  const StatistikPresensiV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        // Badge Presensi (jumlah)
        StatistikBadge(
          bgColor: const Color(0x1EFB7F54),
          borderColor: const Color(0xFFFB7F54),
          label: 'Presensi',
          value: '19',
          valueColor: const Color(0xFFFB7F54),
          iconPath: 'assets/icons/(home_page)_people-icon.svg',
          iconColor: const Color(0xFFFB7F54),
        ),

        // Badge Status (On Time)
        StatistikBadge(
          bgColor: const Color(0x1E18C079),
          borderColor: const Color(0xFF18C079),
          label: 'Status',
          value: 'On Time',
          valueColor: const Color(0xFF18C079),
          iconPath: 'assets/icons/(home_page)_shield-icon.svg',
          iconColor: const Color(0xFF18C079),
        ),
      ],
    );
  }
}

class StatistikBadge extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final String label;
  final String value;
  final Color valueColor;
  final String iconPath;
  final Color iconColor;

  const StatistikBadge({super.key, 
    required this.bgColor,
    required this.borderColor,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.iconPath,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 182,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ikon SVG
          Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
              width: 35,
              height: 35,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),

          // Label & Nilai
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
              Container(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: value.length <= 2 ? 20 : 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: value.length <= 2 ? 1.40 : 1.50,
                    letterSpacing: value.length <= 2 ? -0.34 : -0.18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
