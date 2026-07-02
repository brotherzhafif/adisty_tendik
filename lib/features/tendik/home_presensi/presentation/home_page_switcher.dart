import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/presensi_state.dart';
import 'home_page_1.dart' as page1;
import 'home_page_1-2.dart' as page1_2;
import 'home_page_2.dart' as page2;
import 'home_page_2-2.dart' as page2_2;
import '../../presensi_hari_ini/presentation/landing.dart';

// ============================================================
// HALAMAN UTAMA - HomePageSwitcher (kini menggunakan Switcher)
// Menampilkan satu homepage aktif dengan FloatingActionButton
// untuk mengganti versi tampilan (v1, v1-2, v2, v2-2).
// ============================================================
class HomePageSwitcher extends StatefulWidget {
  const HomePageSwitcher({super.key});

  @override
  State<HomePageSwitcher> createState() => _HomePageSwitcherState();
}

class _HomePageSwitcherState extends State<HomePageSwitcher> {
  int _currentPage = 0;
  PresensiState _currentPresensiState = PresensiState.belumPresensi;

  void _changeVersion(int index) {
    setState(() {
      _currentPage = index;
    });
    Navigator.pop(context); // Tutup modal setelah memilih
  }

  void _changeState(PresensiState state) {
    setState(() {
      _currentPresensiState = state;
    });
    Navigator.pop(context);
  }

  // Callback untuk flow tombol presensi
  void _advanceState() {
    setState(() {
      switch (_currentPresensiState) {
        case PresensiState.belumPresensi:
          _currentPresensiState = PresensiState.shift1Selesai;
          break;
        case PresensiState.shift1Selesai:
          _currentPresensiState = PresensiState.pulang;
          break;
        case PresensiState.pulang:
          break;
      }
    });
  }

  // Setelah dialog konfirmasi pulang berhasil
  void _resetState() {
    setState(() {
      _currentPresensiState = PresensiState.belumPresensi;
    });
  }

  void _showVersionSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Pilih Versi Tampilan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.looks_one),
                title: const Text('Home Page V1'),
                onTap: () => _changeVersion(0),
                selected: _currentPage == 0,
              ),
              ListTile(
                leading: const Icon(Icons.looks_two),
                title: const Text('Home Page V1-2'),
                onTap: () => _changeVersion(1),
                selected: _currentPage == 1,
              ),
              ListTile(
                leading: const Icon(Icons.looks_3),
                title: const Text('Home Page V2'),
                onTap: () => _changeVersion(2),
                selected: _currentPage == 2,
              ),
              ListTile(
                leading: const Icon(Icons.looks_4),
                title: const Text('Home Page V2-2'),
                onTap: () => _changeVersion(3),
                selected: _currentPage == 3,
              ),
              // const Divider(),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   child: Text(
              //     'Pilih Status Presensi',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: 'Poppins',
              //     ),
              //   ),
              // ),
              // ListTile(
              //   leading: const Icon(Icons.access_time),
              //   title: const Text('Belum Presensi'),
              //   onTap: () => _changeState(PresensiState.belumPresensi),
              //   selected: _currentPresensiState == PresensiState.belumPresensi,
              // ),
              // ListTile(
              //   leading: const Icon(Icons.check_circle_outline),
              //   title: const Text('Shift 1 Selesai / Lanjut'),
              //   onTap: () => _changeState(PresensiState.shift1Selesai),
              //   selected: _currentPresensiState == PresensiState.shift1Selesai,
              // ),
              // ListTile(
              //   leading: const Icon(Icons.directions_walk),
              //   title: const Text('Pulang'),
              //   onTap: () => _changeState(PresensiState.pulang),
              //   selected: _currentPresensiState == PresensiState.pulang,
              // ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    switch (_currentPage) {
      case 0:
        activePage = page1.HomePage1(
          state: _currentPresensiState,
          onAdvanceState: _advanceState,
          onResetState: _resetState,
        );
        break;
      case 1:
        activePage = page1_2.HomePage1_2(
          state: _currentPresensiState,
          onAdvanceState: _advanceState,
          onResetState: _resetState,
        );
        break;
      case 2:
        activePage = page2.HomePage2(
          state: _currentPresensiState,
          onAdvanceState: _advanceState,
          onResetState: _resetState,
        );
        break;
      case 3:
        activePage = page2_2.HomePage2_2(
          state: _currentPresensiState,
          onAdvanceState: _advanceState,
          onResetState: _resetState,
        );
        break;
      default:
        activePage = page1.HomePage1(
          state: _currentPresensiState,
          onAdvanceState: _advanceState,
          onResetState: _resetState,
        );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      body: activePage,
      floatingActionButton: FloatingActionButton(
        onPressed: _showVersionSelector,
        backgroundColor: const Color(0xFF016EB8),
        tooltip: 'Pilih Versi Tampilan',
        child: const Icon(Icons.palette, color: Colors.white),
      ),
      bottomNavigationBar: const _Navbar(),
    );
  }
}

// ============================================================
// KOMPONEN: NAVBAR BAWAH
// Menampilkan 3 item navigasi: Beranda, Presensi, Profil
// Icon diambil dari assets/icons/(home_page)_ menggunakan flutter_svg.
// ============================================================
class _Navbar extends StatelessWidget {
  const _Navbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 0,
            offset: Offset(0.50, 0),
            spreadRadius: 0.50,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Tab Beranda (aktif) ---
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/(home_page)_home-icon.svg',
                width: 40,
                height: 40,
              ),
              const Text(
                'Beranda',
                style: TextStyle(
                  color: Color(0xFF016EB8),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  height: 1.49,
                ),
              ),
            ],
          ),

          // --- Tab Presensi (tidak aktif) ---
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LandingPresensiHariIni(),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/(home_page)_presensi-icon.svg',
                  width: 40,
                  height: 40,
                ),
                const Text(
                  'Presensi',
                  style: TextStyle(
                    color: Color(0xFF5F6570),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.49,
                  ),
                ),
              ],
            ),
          ),

          // --- Tab Profil (tidak aktif) ---
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/(home_page)_profile-icon.svg',
                width: 40,
                height: 40,
              ),
              const Text(
                'Profil',
                style: TextStyle(
                  color: Color(0xFF5F6570),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  height: 1.49,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
