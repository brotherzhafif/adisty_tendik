import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

class TombolPresensi extends StatelessWidget {
  final String text;
  final List<Color> gradient;
  final VoidCallback? onTap;

  const TombolPresensi({
    super.key,
    this.text = 'Pulang',
    this.gradient = const [Color(0xFFFFAC2F), Color(0xFFFFC268)],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(6),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.50, 1.00),
            end: const Alignment(0.50, 0.00),
            colors: gradient,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyle.buttonLg,
          ),
        ),
      ),
    );
  }
}
