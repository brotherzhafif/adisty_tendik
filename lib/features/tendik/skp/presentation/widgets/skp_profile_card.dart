import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Card Profil SKP
// Menampilkan info pegawai dan navigasi tahun evaluasi.
// ============================================================
class SkpProfileCard extends StatelessWidget {
  final String name;
  final String department;
  final String role;
  final String avatarUrl;
  final List<String> years;
  final int activeYearIndex;
  final ValueChanged<int> onYearChanged;
  final PageController pageController;
  final ValueChanged<int> onPindahTahun;

  const SkpProfileCard({
    super.key,
    required this.name,
    required this.department,
    required this.role,
    required this.avatarUrl,
    required this.years,
    required this.activeYearIndex,
    required this.onYearChanged,
    required this.pageController,
    required this.onPindahTahun,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) {
        if (pageController.hasClients) {
          // Teruskan pergeseran jari langsung ke PageController tahun
          pageController.position.jumpTo(
            (pageController.position.pixels - details.delta.dx).clamp(
              0.0,
              pageController.position.maxScrollExtent,
            ),
          );
        }
      },
      onHorizontalDragEnd: (details) {
        if (pageController.hasClients) {
          // Cari tahun terdekat berdasarkan arah dan kecepatan geseran
          final double currentPage = pageController.page ?? 0;
          int targetPage = currentPage.round();
          if (details.primaryVelocity! < -100) {
            targetPage = (currentPage + 0.15).ceil();
          } else if (details.primaryVelocity! > 100) {
            targetPage = (currentPage - 0.15).floor();
          }
          onPindahTahun(targetPage.clamp(0, years.length - 1));
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
                                image: NetworkImage(avatarUrl),
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
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 1.33,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          child: Text(
                            department,
                            style: const TextStyle(
                              color: Color(0xFFAEB1B7),
                              fontSize: 10,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              height: 1.60,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          child: Text(
                            role,
                            style: const TextStyle(
                              color: Color(0xFFAEB1B7),
                              fontSize: 10,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              height: 1.60,
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
                  onPressed: activeYearIndex > 0
                      ? () => onPindahTahun(activeYearIndex - 1)
                      : null,
                ),
                const SizedBox(width: 12),
                // Swipeable PageView untuk tahun
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: years.length,
                      onPageChanged: onYearChanged,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            years[index],
                            style: const TextStyle(
                              color: Color(0xFF293241),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.18,
                            ),
                          ),
                        );
                      },
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
                  onPressed: activeYearIndex < years.length - 1
                      ? () => onPindahTahun(activeYearIndex + 1)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- Dot Indicator ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(years.length, (index) {
                final isActive = index == activeYearIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.5),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? 8 : 7,
                    height: isActive ? 8 : 7,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF2B86C3)
                          : const Color(0xFFF6F7F7),
                      borderRadius: BorderRadius.circular(49),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );
}
}
