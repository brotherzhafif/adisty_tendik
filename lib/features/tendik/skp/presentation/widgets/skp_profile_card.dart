import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Card Profil SKP
// Menampilkan info pegawai dan navigasi tahun evaluasi.
// ============================================================
class SkpProfileCard extends StatefulWidget {
  final String name;
  final String department;
  final String role;
  final String avatarUrl;
  final List<String> years;
  final int activeYearIndex;
  final ValueChanged<int> onYearChanged;

  const SkpProfileCard({
    super.key,
    required this.name,
    required this.department,
    required this.role,
    required this.avatarUrl,
    required this.years,
    required this.activeYearIndex,
    required this.onYearChanged,
  });

  @override
  State<SkpProfileCard> createState() => _SkpProfileCardState();
}

class _SkpProfileCardState extends State<SkpProfileCard> {
  bool _slideLeft = true;

  @override
  void didUpdateWidget(covariant SkpProfileCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeYearIndex != oldWidget.activeYearIndex) {
      _slideLeft = widget.activeYearIndex < oldWidget.activeYearIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (details) {
        final dx = details.velocity.pixelsPerSecond.dx;
        if (dx < -300) {
          if (widget.activeYearIndex < widget.years.length - 1) {
            widget.onYearChanged(widget.activeYearIndex + 1);
          }
        } else if (dx > 300) {
          if (widget.activeYearIndex > 0) {
            widget.onYearChanged(widget.activeYearIndex - 1);
          }
        }
      },
      child: Container(
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
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0C7281DF),
              blurRadius: 6.99,
              offset: Offset(0, 1.78),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0F7281DF),
              blurRadius: 10.20,
              offset: Offset(0, 4.11),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Info Pegawai ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: Color(0xFFFAFAFA),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar dengan Gradient Ring (meniru persis figma stack)
                  Container(
                    width: 64,
                    height: 64,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [Color(0xFFF6CE65), Color(0xFFDE7C28)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(64),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.avatarUrl),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(64),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Teks Nama & Posisi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 1.33,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          child: Text(
                            widget.department,
                            style: const TextStyle(
                              color: Color(0xFFAEB1B7),
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              height: 1.50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          child: Text(
                            widget.role,
                            style: const TextStyle(
                              color: Color(0xFFAEB1B7),
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
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
            const SizedBox(height: 8),

            // --- Selector Tahun ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Panah Kiri
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    color: Color(0xFF293241),
                    size: 24,
                  ),
                  onPressed: widget.activeYearIndex > 0
                      ? () => widget.onYearChanged(widget.activeYearIndex - 1)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        transitionBuilder: (child, animation) {
                          final offset = _slideLeft
                              ? const Offset(-0.4, 0)
                              : const Offset(0.4, 0);
                          return SlideTransition(
                            position: Tween<Offset>(begin: offset, end: Offset.zero)
                                .animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                            child: FadeTransition(opacity: animation, child: child),
                          );
                        },
                        child: Text(
                          widget.years[widget.activeYearIndex],
                          key: ValueKey(widget.years[widget.activeYearIndex]),
                          style: const TextStyle(
                            color: Color(0xFF293241),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: -0.18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Panah Kanan
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF293241),
                    size: 24,
                  ),
                  onPressed: widget.activeYearIndex < widget.years.length - 1
                      ? () => widget.onYearChanged(widget.activeYearIndex + 1)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
