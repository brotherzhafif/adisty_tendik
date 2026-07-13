import 'package:flutter/material.dart';
import 'presensi_log_model.dart';

// ============================================================
// KOMPONEN: REKAP LOG ITEM
// ============================================================
class RekapLogItem extends StatelessWidget {
  final PresensiLog log;
  final VoidCallback onTap;

  const RekapLogItem({super.key, required this.log, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (log.status.toLowerCase()) {
      case 'on time':
        statusColor = const Color(0xFF4AAF57);
        break;
      case 'terlambat':
        statusColor = const Color(0xFFFFAC2F);
        break;
      default:
        statusColor = const Color(0xFFE65768);
        break;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F7281DF),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Tanggal Box
                Container(
                  width: 64,
                  height: 64,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFEEF2F3),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        log.dayName,
                        style: const TextStyle(
                          color: Color(0xFF5F6570),
                          fontSize: 12,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        log.dayNum,
                        style: const TextStyle(
                          color: Color(0xFF293241),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Detail Status & Lokasi
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            log.status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (log.badges.isNotEmpty)
                            ...log.badges.map(
                              (badge) => Container(
                                margin: const EdgeInsets.only(left: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0x1E016EB8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  badge,
                                  style: const TextStyle(
                                    color: Color(0xFF016EB8),
                                    fontSize: 10,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF5F6570),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            log.location,
                            style: const TextStyle(
                              color: Color(0xFF5F6570),
                              fontSize: 14,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Transport
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Transport',
                      style: TextStyle(
                        color: Color(0xFF5F6570),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      log.transport,
                      style: const TextStyle(
                        color: Color(0xFF293241),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFEEF2F3)),
            const SizedBox(height: 12),

            // Waktu Masuk & Pulang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.login, color: Color(0xFF5F6570), size: 16),
                    const SizedBox(width: 6),
                    const Text(
                      'Masuk : ',
                      style: TextStyle(
                        color: Color(0xFF5F6570),
                        fontSize: 12,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      log.masuk,
                      style: const TextStyle(
                        color: Color(0xFF2B86C3),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Color(0xFF5F6570),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Pulang : ',
                      style: TextStyle(
                        color: Color(0xFF5F6570),
                        fontSize: 12,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      log.pulang,
                      style: const TextStyle(
                        color: Color(0xFF2B86C3),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
