import 'package:flutter/material.dart';

// =============================================================================
// THEME — warna & text style dikumpulkan di sini biar konsisten & gak
// hardcode berulang di tiap widget.
// =============================================================================

class _AppColors {
  _AppColors._();

  static const Color primary = Color(0xFF2B86C3);
  static const Color background = Color(0xFFF6F7F9);

  static const Color textPrimary = Color(0xFF293241);
  static const Color textSecondary = Color(0xFF5F6570);
  static const Color textMuted = Color(0xFF7A8089);

  static const Color statusYellow = Color(0xFFFFAC2F);
  static const Color statusYellowBg = Color(0x1EFFAC2F);
  static const Color statusGreen = Color(0xF54AAF57);

  static const Color primarySoftBg = Color(0x1E2B86C3);
  static const Color inactiveStep = Color(0xFFD9D9D9);
  static const Color inactiveLine = Color(0xFFE5E7EB);
  static const Color border = Color(0xFFD9D9D9);
  static const Color linkBlue = Color(0xFF016EB8);
  static const Color outlineBlue = Color(0xFF0067AD);

  static const List<BoxShadow> cardShadow = [
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
  ];
}

class _AppTextStyles {
  _AppTextStyles._();

  static const TextStyle pageTitle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 1.40,
    letterSpacing: -0.34,
  );

  static const TextStyle cardTitle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w700,
    height: 1.50,
    letterSpacing: -0.27,
  );

  static const TextStyle fieldLabel = TextStyle(
    color: _AppColors.textSecondary,
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: -0.08,
  );

  static const TextStyle fieldValue = TextStyle(
    color: _AppColors.textPrimary,
    fontSize: 16,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
    height: 1.50,
    letterSpacing: -0.27,
  );

  static const TextStyle fieldValueGreen = TextStyle(
    color: _AppColors.statusGreen,
    fontSize: 16,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
    height: 1.50,
    letterSpacing: -0.27,
  );

  static const TextStyle subLabelBold = TextStyle(
    color: _AppColors.linkBlue,
    fontSize: 12,
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeight.w700,
    letterSpacing: 0.18,
  );

  static const TextStyle stepLabel = TextStyle(
    color: _AppColors.textPrimary,
    fontSize: 12,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
    height: 1.33,
  );

  static const TextStyle badgeText = TextStyle(
    color: _AppColors.statusYellow,
    fontSize: 12,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w700,
    height: 1.33,
  );

  static const TextStyle body = TextStyle(
    color: _AppColors.textSecondary,
    fontSize: 12,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  static const TextStyle fileName = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: -0.17,
  );

  static const TextStyle fileSize = TextStyle(
    color: _AppColors.textSecondary,
    fontSize: 12,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  static const TextStyle historyTitle = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w700,
    height: 1.43,
    letterSpacing: -0.17,
  );

  static const TextStyle historyDate = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static const TextStyle historyDesc = TextStyle(
    color: _AppColors.textMuted,
    fontSize: 12,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static const TextStyle backButtonLabel = TextStyle(
    color: _AppColors.outlineBlue,
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 1.50,
    letterSpacing: -0.18,
  );
}

// =============================================================================
// MODELS — data yang dibutuhkan halaman ini. Inject dari API di real usage,
// KoreksiDetail.dummy() cuma buat preview/testing.
// =============================================================================

class TimelineStepData {
  final String label;
  final bool isActive;
  const TimelineStepData({required this.label, this.isActive = false});
}

class DataChangeItem {
  final String fieldLabel;
  final String oldValue;
  final String newValue;
  final bool highlightNewValue;
  const DataChangeItem({
    required this.fieldLabel,
    required this.oldValue,
    required this.newValue,
    this.highlightNewValue = false,
  });
}

class AttachmentItem {
  final String fileName;
  final String fileSize;
  final IconData icon;
  const AttachmentItem({
    required this.fileName,
    required this.fileSize,
    this.icon = Icons.insert_drive_file_outlined,
  });
}

class HistoryEntry {
  final String title;
  final String dateTime;
  final String description;
  const HistoryEntry({
    required this.title,
    required this.dateTime,
    required this.description,
  });
}

class KoreksiDetail {
  final String tanggal;
  final String hari;
  final String statusLabel;
  final List<TimelineStepData> timelineSteps;
  final List<DataChangeItem> dataChanges;
  final String alasanPengajuan;
  final List<AttachmentItem> attachments;
  final List<HistoryEntry> historyEntries;

  const KoreksiDetail({
    required this.tanggal,
    required this.hari,
    required this.statusLabel,
    required this.timelineSteps,
    required this.dataChanges,
    required this.alasanPengajuan,
    required this.attachments,
    required this.historyEntries,
  });

  factory KoreksiDetail.dummy() {
    return const KoreksiDetail(
      tanggal: '9 September 2023',
      hari: 'Rabu',
      statusLabel: 'Menunggu verifikasi',
      timelineSteps: [
        TimelineStepData(label: 'Diajukan', isActive: true),
        TimelineStepData(label: 'Diverifikasi'),
        TimelineStepData(label: 'Selesai'),
      ],
      dataChanges: [
        DataChangeItem(
          fieldLabel: 'Jam Masuk',
          oldValue: '07:30',
          newValue: '07:00',
          highlightNewValue: true,
        ),
        DataChangeItem(
          fieldLabel: 'Jam Pulang',
          oldValue: '-',
          newValue: '17:00',
        ),
      ],
      alasanPengajuan:
          'Lupa melakukan presensi pulang karena kegiatan lembur hingga selesai.',
      attachments: [
        AttachmentItem(fileName: 'Surat_tugas.pdf', fileSize: '512 KB'),
        AttachmentItem(fileName: 'Screenshot.jpg', fileSize: '1,2 MB'),
      ],
      historyEntries: [
        HistoryEntry(
          title: 'Pengajuan dibuat',
          dateTime: '09 Sep 2023 · 08:20',
          description: 'Pengajuan koreksi presensi berhasil dibuat.',
        ),
        HistoryEntry(
          title: 'Menunggu verifikasi',
          dateTime: '09 Sep 2023 · 08:20',
          description: 'Pengajuan sedang menunggu verifikasi admin pegawai.',
        ),
        HistoryEntry(
          title: 'Selesai',
          dateTime: '-',
          description: 'Belum diproses oleh admin.',
        ),
      ],
    );
  }
}

// =============================================================================
// SHARED WIDGET — card container dengan shadow standar, dipakai berkali-kali.
// =============================================================================

class _ElevatedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const _ElevatedCard({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadows: _AppColors.cardShadow,
      ),
      child: child,
    );
  }
}

// =============================================================================
// APP BAR
// =============================================================================

class _KoreksiAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const _KoreksiAppBar({required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: _AppTextStyles.pageTitle,
          ),
        ),
        const SizedBox(width: 48), // spacer biar judul tetap center
      ],
    );
  }
}

// =============================================================================
// SECTION 1 — Status Presensi (tanggal, hari, badge status)
// =============================================================================

class _StatusPresensiCard extends StatelessWidget {
  final String tanggal;
  final String hari;
  final String statusLabel;

  const _StatusPresensiCard({
    required this.tanggal,
    required this.hari,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const ShapeDecoration(
                color: _AppColors.primarySoftBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
              ),
              child: const Icon(
                Icons.fingerprint,
                color: _AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Presensi', style: _AppTextStyles.fieldLabel),
                  Text(tanggal, style: _AppTextStyles.fieldValue),
                  Text(hari, style: _AppTextStyles.fieldLabel),
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 129),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: ShapeDecoration(
                color: _AppColors.statusYellowBg,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: _AppColors.statusYellow,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                statusLabel,
                textAlign: TextAlign.center,
                style: _AppTextStyles.badgeText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Timeline Pengajuan (Diajukan -> Diverifikasi -> Selesai)
// =============================================================================

class _TimelinePengajuanCard extends StatelessWidget {
  final List<TimelineStepData> steps;

  const _TimelinePengajuanCard({required this.steps});

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timeline Pengajuan', style: _AppTextStyles.cardTitle),
          const SizedBox(height: 16),
          Row(
            children: [
              for (int i = 0; i < steps.length; i++)
                _TimelineStep(data: steps[i], isLast: i == steps.length - 1),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final TimelineStepData data;
  final bool isLast;

  const _TimelineStep({required this.data, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final Color lineColor = data.isActive
        ? _AppColors.statusYellow
        : _AppColors.inactiveLine;

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: data.isActive
                        ? _AppColors.statusYellowBg
                        : _AppColors.inactiveStep,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(999)),
                    ),
                  ),
                  child: Icon(
                    data.isActive ? Icons.hourglass_bottom : Icons.circle,
                    size: 20,
                    color: data.isActive
                        ? _AppColors.statusYellow
                        : Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.label,
                  textAlign: TextAlign.center,
                  style: _AppTextStyles.stepLabel,
                ),
              ],
            ),
          ),
          if (!isLast)
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              color: lineColor,
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Perubahan Data (Jam Masuk / Jam Pulang, dst)
// =============================================================================

class _PerubahanDataCard extends StatelessWidget {
  final List<DataChangeItem> items;

  const _PerubahanDataCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Perubahan Data', style: _AppTextStyles.cardTitle),
          const SizedBox(height: 16),
          for (int i = 0; i < items.length; i++) ...[
            _DataChangeRow(item: items[i]),
            if (i != items.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _DataChangeRow extends StatelessWidget {
  final DataChangeItem item;

  const _DataChangeRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.fieldLabel, style: _AppTextStyles.subLabelBold),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: _ValueBox(label: 'Data Sebelumnya', value: item.oldValue),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.arrow_forward,
                size: 20,
                color: _AppColors.textMuted,
              ),
            ),
            Expanded(
              child: _ValueBox(
                label: 'Pengajuan Baru',
                value: item.newValue,
                highlight: item.highlightNewValue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ValueBox extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _ValueBox({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _AppTextStyles.fieldLabel),
          Text(
            value,
            style: highlight
                ? _AppTextStyles.fieldValueGreen
                : _AppTextStyles.fieldValue,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Alasan Pengajuan
// =============================================================================

class _AlasanPengajuanCard extends StatelessWidget {
  final String alasan;

  const _AlasanPengajuanCard({required this.alasan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: _AppColors.primary, size: 24),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Alasan Pengajuan',
                    style: _AppTextStyles.cardTitle,
                  ),
                ),
                Text(alasan, style: _AppTextStyles.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — Lampiran
// =============================================================================

class _LampiranCard extends StatelessWidget {
  final List<AttachmentItem> attachments;
  final ValueChanged<AttachmentItem>? onTapAttachment;

  const _LampiranCard({required this.attachments, this.onTapAttachment});

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.attach_file, size: 24, color: _AppColors.textPrimary),
              SizedBox(width: 10),
              Text('Lampiran', style: _AppTextStyles.cardTitle),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < attachments.length; i++) ...[
            _AttachmentTile(
              item: attachments[i],
              onTap: onTapAttachment == null
                  ? null
                  : () => onTapAttachment!(attachments[i]),
            ),
            if (i != attachments.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  final AttachmentItem item;
  final VoidCallback? onTap;

  const _AttachmentTile({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: _AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 37,
              height: 37,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: _AppColors.primary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.fileName, style: _AppTextStyles.fileName),
                  Text(item.fileSize, style: _AppTextStyles.fileSize),
                ],
              ),
            ),
            const Icon(
              Icons.download_outlined,
              size: 24,
              color: _AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Riwayat Proses
// =============================================================================

class _RiwayatProsesCard extends StatelessWidget {
  final List<HistoryEntry> entries;

  const _RiwayatProsesCard({required this.entries});

  @override
  Widget build(BuildContext context) {
    return _ElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Riwayat Proses', style: _AppTextStyles.cardTitle),
          const SizedBox(height: 16),
          for (int i = 0; i < entries.length; i++) ...[
            _HistoryTile(entry: entries[i]),
            if (i != entries.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final HistoryEntry entry;

  const _HistoryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entry.title, style: _AppTextStyles.historyTitle),
        Text(entry.dateTime, style: _AppTextStyles.historyDate),
        Text(entry.description, style: _AppTextStyles.historyDesc),
      ],
    );
  }
}

// =============================================================================
// SECTION 7 — Tombol Kembali
// =============================================================================

class _KembaliButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _KembaliButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: const BorderSide(width: 1, color: _AppColors.outlineBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Kembali', style: _AppTextStyles.backButtonLabel),
      ),
    );
  }
}

// =============================================================================
// PAGE — cuma nyusun urutan card dari data KoreksiDetail. Kalau mau ubah
// tampilan salah satu section, tinggal cari class-nya di atas (per SECTION).
// =============================================================================

class RiwayatKoreksiDetailPage extends StatelessWidget {
  final KoreksiDetail detail;

  /// Wajib kirim [detail] (misal dari hasil fetch API).
  const RiwayatKoreksiDetailPage({super.key, required this.detail});

  /// Shortcut untuk preview/testing pakai data contoh, tanpa perlu
  /// nyiapin KoreksiDetail asli dulu. Contoh: RiwayatKoreksiDetailPage.demo()
  factory RiwayatKoreksiDetailPage.demo() {
    return RiwayatKoreksiDetailPage(detail: KoreksiDetail.dummy());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: _KoreksiAppBar(title: 'Detail Pengajuan Koreksi'),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(22),
                  children: [
                    _StatusPresensiCard(
                      tanggal: detail.tanggal,
                      hari: detail.hari,
                      statusLabel: detail.statusLabel,
                    ),
                    const SizedBox(height: 18),
                    _TimelinePengajuanCard(steps: detail.timelineSteps),
                    const SizedBox(height: 18),
                    _PerubahanDataCard(items: detail.dataChanges),
                    const SizedBox(height: 18),
                    _AlasanPengajuanCard(alasan: detail.alasanPengajuan),
                    const SizedBox(height: 18),
                    _LampiranCard(attachments: detail.attachments),
                    const SizedBox(height: 18),
                    _RiwayatProsesCard(entries: detail.historyEntries),
                    const SizedBox(height: 18),
                    const _KembaliButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
