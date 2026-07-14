import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF293241),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Color(0xFF293241),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: const [
          NotificationItem(
            title: 'Agenda',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
            time: '16:40',
            iconPath: 'assets/icons/(notification_page)_agenda.svg',
            iconColor: Color(0x1EEE6C4D),
            isUnread: true,
          ),
          NotificationItem(
            title: 'Agenda',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
            time: '16:40',
            iconPath: 'assets/icons/(notification_page)_agenda.svg',
            iconColor: Color(0x1EEE6C4D),
            isUnread: false,
          ),
          NotificationItem(
            title: 'Riwayat kepegawaian',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
            time: '16:40',
            iconPath: 'assets/icons/(notification_page)_riwayat.svg',
            iconColor: Color(0x1EE65768),
            isUnread: false,
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String iconPath;
  final Color iconColor;
  final bool isUnread;

  const NotificationItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.iconPath,
    required this.iconColor,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 16),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0x0F016EB8) : Colors.transparent,
        border: const Border(
          bottom: BorderSide(width: 1, color: Color(0xFFE5E6E8)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: SvgPicture.asset(iconPath),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0A0A0A),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF6F757E),
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF9FA3A9),
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
