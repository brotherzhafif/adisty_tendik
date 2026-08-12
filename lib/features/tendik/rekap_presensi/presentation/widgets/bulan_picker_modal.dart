import 'package:flutter/material.dart';

// ============================================================
// WIDGET REUSABLE: Modal Picker Bulan Rekap Presensi (Searchable)
// Modal bottom sheet dengan search bar + daftar bulan & tahun
// ============================================================
class BulanPickerModal extends StatefulWidget {
  final List<String> listBulan;
  final String selectedBulan;

  const BulanPickerModal({
    super.key,
    required this.listBulan,
    required this.selectedBulan,
  });

  /// Helper static untuk menampilkan modal bottom sheet
  static Future<int?> show(
    BuildContext context, {
    required List<String> listBulan,
    required String selectedBulan,
  }) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BulanPickerModal(
        listBulan: listBulan,
        selectedBulan: selectedBulan,
      ),
    );
    if (result != null) {
      final index = listBulan.indexOf(result);
      return index != -1 ? index : null;
    }
    return null;
  }

  @override
  State<BulanPickerModal> createState() => _BulanPickerModalState();
}

class _BulanPickerModalState extends State<BulanPickerModal> {
  late List<String> _filtered;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = List.from(widget.listBulan);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filtered = List.from(widget.listBulan);
      } else {
        _filtered = widget.listBulan
            .where((b) => b.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // --- Handle bar ---
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDE0E5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // --- Header ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Pilih Bulan Rekap Presensi',
                        style: TextStyle(
                          color: Color(0xFF293241),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF5F6570),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),

              // --- Search Bar ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: false,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Cari bulan dan tahun...',
                    hintStyle: const TextStyle(
                      color: Color(0xFFAEB1B7),
                      fontSize: 13,
                      fontFamily: 'Nunito',
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFFAEB1B7),
                      size: 20,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: Color(0xFFAEB1B7),
                              size: 18,
                            ),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF6F7F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const Divider(height: 1, color: Color(0xFFEEEFF1)),

              // --- Daftar Bulan & Tahun ---
              Expanded(
                child: _filtered.isEmpty
                    ? const Center(
                        child: Text(
                          'Bulan tidak ditemukan',
                          style: TextStyle(
                            color: Color(0xFFAEB1B7),
                            fontSize: 13,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _filtered.length,
                        separatorBuilder: (_, _) => const Divider(
                          height: 1,
                          indent: 20,
                          endIndent: 20,
                          color: Color(0xFFF1F2F4),
                        ),
                        itemBuilder: (context, index) {
                          final bulanLabel = _filtered[index];
                          final isSelected = bulanLabel == widget.selectedBulan;
                          return InkWell(
                            onTap: () => Navigator.of(context).pop(bulanLabel),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      bulanLabel,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? const Color(0xFF0067AD)
                                            : const Color(0xFF293241),
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_rounded,
                                      color: Color(0xFF0067AD),
                                      size: 20,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
