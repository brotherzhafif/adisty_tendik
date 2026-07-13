import 'package:flutter/material.dart';
import 'detail.dart';
import 'widgets/riwayat_pengajuan_item.dart';

class RiwayatKoreksiPage extends StatelessWidget {
  const RiwayatKoreksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Riwayat Pengajuan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F7F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RiwayatPengajuanItem(
                status: StatusPengajuan.menunggu,
                date: 'Rabu, 9 September 2023',
                type: 'Presensi',
                diajukan: '09 Sep 2023 · 08:30',
                perubahanLabel: 'Jam Pulang',
                oldValue: '-',
                newValue: '17:00',
                onDetailTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RiwayatKoreksiDetailPage.demo(),
                    ),
                  );
                },
              ),
              RiwayatPengajuanItem(
                status: StatusPengajuan.disetujui,
                date: 'Kamis, 10 September 2023',
                type: 'Presensi',
                diajukan: '10 Sep 2023 · 09:00',
                perubahanLabel: 'Jam Masuk',
                oldValue: '08:00',
                newValue: '07:30',
                onDetailTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RiwayatKoreksiDetailPage.demo(),
                    ),
                  );
                },
              ),
              RiwayatPengajuanItem(
                status: StatusPengajuan.ditolak,
                date: 'Jumat, 11 September 2023',
                type: 'Presensi',
                diajukan: '11 Sep 2023 · 10:15',
                perubahanLabel: 'Jam Pulang',
                oldValue: '16:00',
                newValue: '17:30',
                onDetailTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RiwayatKoreksiDetailPage.demo(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
