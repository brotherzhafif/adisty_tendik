import 'package:flutter/material.dart';
import 'presensi_state.dart';
import 'tombol_pulang.dart';
import 'presensi_dialogs.dart';

class TombolPresensiWrapper extends StatelessWidget {
  final PresensiState state;
  final VoidCallback? onAdvanceState;
  final VoidCallback? onResetState;

  const TombolPresensiWrapper({
    super.key,
    required this.state,
    this.onAdvanceState,
    this.onResetState,
  });

  @override
  Widget build(BuildContext context) {
    String buttonText;
    List<Color> buttonGradient;

    switch (state) {
      case PresensiState.belumPresensi:
        buttonText = 'Masuk';
        buttonGradient = const [Color(0xFF4AAF57), Color(0xFF49C95A)];
        break;
      case PresensiState.shift1Selesai:
        buttonText = 'Lanjut Shift';
        buttonGradient = const [Color(0xFF0067AD), Color(0xFF4497D0)];
        break;
      case PresensiState.pulang:
        buttonText = 'Pulang';
        buttonGradient = const [Color(0xFFFFAC2F), Color(0xFFFFC268)];
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TombolPresensi(
          text: buttonText,
          gradient: buttonGradient,
          onTap: () {
            if (state == PresensiState.pulang) {
              // State Pulang: tampilkan dialog konfirmasi
              showDialog(
                context: context,
                builder: (context) => DialogKonfirmasiPulang(
                  onConfirmed: () {
                    onResetState?.call(); // Reset ke belumPresensi
                  },
                ),
              );
            } else {
              // State lain: advance ke state berikutnya
              onAdvanceState?.call();
            }
          },
        ),
      ],
    );
  }
}
