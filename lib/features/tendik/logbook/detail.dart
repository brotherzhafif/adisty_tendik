import 'package:flutter/material.dart';
import 'widgets/logbook_app_bar.dart';
import 'widgets/logbook_detail_header_card.dart';
import 'widgets/logbook_detail_content_card.dart';
import 'widgets/logbook_activity_item.dart';
import 'form.dart';

// ============================================================
// HALAMAN: Detail Logbook Page
// Menampilkan detail tanggal, waktu dibuat, status,
// judul aktivitas, serta deskripsi lengkap dari logbook.
// ============================================================
class LogbookDetailPage extends StatefulWidget {
  final LogbookActivityData activity;

  const LogbookDetailPage({super.key, required this.activity});

  @override
  State<LogbookDetailPage> createState() => _LogbookDetailPageState();
}

class _LogbookDetailPageState extends State<LogbookDetailPage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subAktivitasList = widget.activity.daftarSubAktivitas;

    // Formatting a pretty date name
    final String tanggalLengkap =
        '${_getDayFullName(widget.activity.hariNama)}, ${widget.activity.tanggal} ${_capitalize(widget.activity.bulan)} 2026';
    final String waktuDibuat =
        'Dibuat pada ${widget.activity.tanggal} ${_capitalize(widget.activity.bulan)} 2026, 10:25 WIB';

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          // --- AppBar Detail ---
          LogbookAppBar(
            title: 'Detail Logbook',
            onBack: () => Navigator.of(context).maybePop(),
          ),

          // --- Konten Utama ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                color: Color(0xFFF6F7F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      // --- Kartu Info Header ---
                      LogbookDetailHeaderCard(
                        tanggalLengkap: tanggalLengkap,
                        waktuDibuat: waktuDibuat,
                        status: 'Tersimpan',
                        totalKategori: subAktivitasList.length,
                        currentKategoriIndex: _currentIndex + 1,
                        currentKategoriNama:
                            subAktivitasList.isNotEmpty &&
                                _currentIndex < subAktivitasList.length
                            ? subAktivitasList[_currentIndex].judul
                            : '',
                        listKategori: subAktivitasList
                            .map((e) => e.judul)
                            .toList(),
                        onKategoriChanged: (newIndex) {
                          final targetPage = newIndex - 1;
                          _pageController.animateToPage(
                            targetPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        onKategoriSelected: (selectedTitle) {
                          final selectedIdx = subAktivitasList.indexWhere(
                            (e) => e.judul == selectedTitle,
                          );
                          if (selectedIdx != -1) {
                            _pageController.animateToPage(
                              selectedIdx,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 16),

                      // --- Horizontal Scroll PageView Kartu Detail Isi Laporan ---
                      SizedBox(
                        height: 320,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: subAktivitasList.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final item = subAktivitasList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2.0,
                              ),
                              child: LogbookDetailContentCard(
                                judulAktivitas: item.judul,
                                deskripsiAktivitas: item.deskripsi,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // --- Info Catatan Koreksi ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE8F1F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Color(0xFF293241),
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Jika terdapat kesalahan pada data logbook, Anda dapat mengajukan koreksi logbook maksimal 3 hari setelah tanggal pembuatan.',
                                style: TextStyle(
                                  color: Color(0xFF293241),
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

                      const SizedBox(height: 24),

                      // --- Tombol Edit Logbook (Full Width) ---
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogbookFormPage(
                                  initialData: widget.activity,
                                  initialSubData:
                                      subAktivitasList[_currentIndex],
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2B86C3),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_rounded, size: 16),
                              SizedBox(width: 6),
                              Text(
                                'Edit Logbook',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper to format day name if needed ---
  String _getDayFullName(String shortDay) {
    switch (shortDay.toLowerCase()) {
      case 'senin':
        return 'Senin';
      case 'selasa':
        return 'Selasa';
      case 'rabu':
        return 'Rabu';
      case 'kamis':
        return 'Kamis';
      case 'jumat':
        return 'Jumat';
      case 'sabtu':
        return 'Sabtu';
      case 'minggu':
        return 'Minggu';
      default:
        return shortDay;
    }
  }

  // --- Helper capitalization ---
  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
