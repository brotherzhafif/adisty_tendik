import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

class StatistikPresensi extends StatelessWidget {
  const StatistikPresensi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Badge Presensi (jumlah)
          Expanded(
            child: StatistikBadge(
              bgColor: const Color(0x1EFB7F54),
              borderColor: const Color(0xFFFB7F54),
              label: 'Presensi',
              value: '19',
              valueColor: const Color(0xFFFB7F54),
              iconPath: 'assets/icons/(home_page)_people-icon.svg',
              iconColor: const Color(0xFFFB7F54),
            ),
          ),
          const SizedBox(width: 12),
          // Badge Status (On Time)
          Expanded(
            child: StatistikBadge(
              bgColor: const Color(0x1E18C079),
              borderColor: const Color(0xFF18C079),
              label: 'Status',
              value: 'On Time',
              valueColor: const Color(0xFF18C079),
              iconPath: 'assets/icons/(home_page)_shield-icon.svg',
              iconColor: const Color(0xFF18C079),
            ),
          ),
        ],
      ),
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

  const StatistikBadge({
    super.key,
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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  style: AppTextStyle.bodySm.copyWith(color: const Color(0xFF293241)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  value,
                  style: (value.length <= 2 ? AppTextStyle.headingXl : AppTextStyle.headingLg).copyWith(
                    color: valueColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
