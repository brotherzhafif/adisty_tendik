import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ============================================================
// WIDGET: KARTU LOKASI PRESENSI (FLUTTER_MAP + OPENSTREETMAP)
// Menampilkan peta interaktif OpenStreetMap & detail alamat kampus
// ============================================================
class LokasiPresensiCard extends StatelessWidget {
  final String namaLokasi;
  final String alamatLine1;
  final String alamatLine2;
  final double latitude;
  final double longitude;

  const LokasiPresensiCard({
    super.key,
    this.namaLokasi = 'Kampus 4 - Universitas Ahmad Dahlan',
    this.alamatLine1 = 'Jl. Ringroad Selatan, Tamanan, Banguntapan',
    this.alamatLine2 = 'Bantul, D.I. Yogyakarta',
    this.latitude = -7.8331,
    this.longitude = 110.3831,
  });

  @override
  Widget build(BuildContext context) {
    final locationPoint = LatLng(latitude, longitude);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x087281DF),
            blurRadius: 4.11,
            offset: Offset(0, 0.52),
          ),
          BoxShadow(
            color: Color(0x0C7281DF),
            blurRadius: 6.99,
            offset: Offset(0, 1.78),
          ),
          BoxShadow(
            color: Color(0x0F7281DF),
            blurRadius: 10.20,
            offset: Offset(0, 4.11),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Judul Section ---
          const Text(
            'Lokasi Presensi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.50,
              letterSpacing: -0.27,
            ),
          ),
          const SizedBox(height: 16),

          // --- Peta Interactive FlutterMap (OSM Tile Layer) ---
          Container(
            width: double.infinity,
            height: 169,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: FlutterMap(
              options: MapOptions(
                initialCenter: locationPoint,
                initialZoom: 16.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.uad.adisty_tendik',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: locationPoint,
                      width: 50,
                      height: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: const Color(0x282B86C3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF2B86C3),
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // --- Detail Alamat ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.50, color: Color(0xFFE0E0E0)),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0x1EE65768),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFFE65768),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaLokasi,
                        style: const TextStyle(
                          color: Color(0xFF303B4C),
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 1.43,
                          letterSpacing: -0.17,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        alamatLine1,
                        style: const TextStyle(
                          color: Color(0xFF5F6570),
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                      Text(
                        alamatLine2,
                        style: const TextStyle(
                          color: Color(0xFF5F6570),
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
