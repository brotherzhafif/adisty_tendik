import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/services/validation_service.dart';
import 'package:adisty_tendik_module/core/error/presentation/index.dart';
import 'presensi_state.dart';
import 'tombol_pulang.dart';
import 'presensi_dialogs.dart';

class TombolPresensiWrapper extends StatefulWidget {
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
  State<TombolPresensiWrapper> createState() => _TombolPresensiWrapperState();
}

class _TombolPresensiWrapperState extends State<TombolPresensiWrapper> {
  bool _isValidating = false;

  String get _buttonText {
    switch (widget.state) {
      case PresensiState.belumPresensi:
        return 'Masuk';
      case PresensiState.shift1Selesai:
        return 'Lanjut Shift';
      case PresensiState.pulang:
        return 'Pulang';
    }
  }

  List<Color> get _buttonGradient {
    switch (widget.state) {
      case PresensiState.belumPresensi:
        return const [Color(0xFF4AAF57), Color(0xFF49C95A)];
      case PresensiState.shift1Selesai:
        return const [Color(0xFF0067AD), Color(0xFF4497D0)];
      case PresensiState.pulang:
        return const [Color(0xFFFFAC2F), Color(0xFFFFC268)];
    }
  }

  Future<void> _onPresensiTap() async {
    if (_isValidating) return;

    setState(() => _isValidating = true);

    try {
      // ── Validasi kondisi presensi ──────────────────────────
      final errorType = await ValidationService.instance.validateForPresensi();

      if (!mounted) return;

      if (errorType != null) {
        // Ada kondisi yang tidak terpenuhi → tampilkan halaman error spesifik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AppErrorScreen(
              errorType: errorType,
              onAction: () => Navigator.pop(context),
            ),
          ),
        );
        return;
      }

      // ── Semua OK → jalankan aksi presensi ────────────────
      if (widget.state == PresensiState.pulang) {
        showDialog(
          context: context,
          builder: (context) => DialogKonfirmasiPulang(
            onConfirmed: () {
              widget.onResetState?.call();
            },
          ),
        );
      } else {
        widget.onAdvanceState?.call();
      }
    } finally {
      if (mounted) setState(() => _isValidating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Overlay loading saat validasi berlangsung
        if (_isValidating)
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF0067AD),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Memvalidasi kondisi...',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    color: Color(0xFF5F6570),
                  ),
                ),
              ],
            ),
          ),
        TombolPresensi(
          text: _buttonText,
          gradient: _buttonGradient,
          onTap: _isValidating ? null : _onPresensiTap,
        ),
      ],
    );
  }
}
