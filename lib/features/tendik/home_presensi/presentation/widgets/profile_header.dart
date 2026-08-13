import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adisty_tendik_module/features/tendik/notifikasi/presentation/index.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import '../../data/models/home_presensi_model.dart';

class ProfileHeader extends StatelessWidget {
  final HomeProfileModel? profile;

  const ProfileHeader({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    final nameText = profile?.name.isNotEmpty == true
        ? profile!.name
        : 'Hi Agung';
    final greetingText = profile?.greeting.isNotEmpty == true
        ? profile!.greeting
        : 'Selamat datang di Adisty';
    final unreadCount = profile?.unreadNotificationCount ?? 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Info Pengguna (Foto + Nama) ---
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            // Foto Profil
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(64),
                child:
                    (profile?.avatarUrl != null &&
                        profile!.avatarUrl.isNotEmpty &&
                        !profile!.avatarUrl.contains('placehold.co'))
                    ? Image.network(
                        profile!.avatarUrl,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
              ),
            ),

            // Nama & Sapaan
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Flexible(
                      child: Text(
                        nameText,
                        textAlign: TextAlign.left,
                        style: AppTextStyle.headingXxl,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  greetingText,
                  style: AppTextStyle.bodyMd,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),

        // --- Ikon Notifikasi dengan Badge ---
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotifikasiPage()),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/(home_page)_notification-icon.svg',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
              if (unreadCount > 0)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 222, 40, 40),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unreadCount.toString(),
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyXs.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
