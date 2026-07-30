import 'package:equatable/equatable.dart';

// ============================================================
// DATA MODEL: HOME PROFILE MODEL
// ============================================================
class HomeProfileModel extends Equatable {
  final String name;
  final String greeting;
  final String avatarUrl;
  final int unreadNotificationCount;

  const HomeProfileModel({
    required this.name,
    required this.greeting,
    required this.avatarUrl,
    required this.unreadNotificationCount,
  });

  const HomeProfileModel.empty()
      : name = 'Hi User',
        greeting = 'Selamat datang di Adisty',
        avatarUrl = '',
        unreadNotificationCount = 0;

  factory HomeProfileModel.fromJson(Map<String, dynamic> json) {
    return HomeProfileModel(
      name: json['name'] as String? ?? 'Hi User',
      greeting: json['greeting'] as String? ?? 'Selamat datang di Adisty',
      avatarUrl: json['avatar_url'] as String? ?? '',
      unreadNotificationCount: json['unread_notification_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'greeting': greeting,
      'avatar_url': avatarUrl,
      'unread_notification_count': unreadNotificationCount,
    };
  }

  @override
  List<Object?> get props => [
        name,
        greeting,
        avatarUrl,
        unreadNotificationCount,
      ];
}

// ============================================================
// DATA MODEL: HOME PRESENSI TODAY MODEL
// ============================================================
class HomePresensiTodayModel extends Equatable {
  final String date;
  final String status;
  final int presensiCount;
  final String statusLabel;
  final String lokasi;
  final String transport;
  final String masuk;
  final String pulang;

  const HomePresensiTodayModel({
    required this.date,
    required this.status,
    required this.presensiCount,
    required this.statusLabel,
    required this.lokasi,
    required this.transport,
    required this.masuk,
    required this.pulang,
  });

  const HomePresensiTodayModel.empty()
      : date = '',
        status = 'belum_presensi',
        presensiCount = 0,
        statusLabel = 'On Time',
        lokasi = 'Kampus 4',
        transport = 'Rp 20.000',
        masuk = '-',
        pulang = '-';

  factory HomePresensiTodayModel.fromJson(Map<String, dynamic> json) {
    return HomePresensiTodayModel(
      date: json['date'] as String? ?? '',
      status: json['status'] as String? ?? 'belum_presensi',
      presensiCount: json['presensi_count'] as int? ?? 0,
      statusLabel: json['status_label'] as String? ?? 'On Time',
      lokasi: json['lokasi'] as String? ?? 'Kampus 4',
      transport: json['transport'] as String? ?? 'Rp 20.000',
      masuk: json['masuk'] as String? ?? '-',
      pulang: json['pulang'] as String? ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'status': status,
      'presensi_count': presensiCount,
      'status_label': statusLabel,
      'lokasi': lokasi,
      'transport': transport,
      'masuk': masuk,
      'pulang': pulang,
    };
  }

  @override
  List<Object?> get props => [
        date,
        status,
        presensiCount,
        statusLabel,
        lokasi,
        transport,
        masuk,
        pulang,
      ];
}

// ============================================================
// DATA MODEL: HOME PRESENSI RESPONSE MODEL
// ============================================================
class HomePresensiResponseModel extends Equatable {
  final String status;
  final String message;
  final HomeProfileModel profile;
  final HomePresensiTodayModel presensiToday;

  const HomePresensiResponseModel({
    required this.status,
    required this.message,
    required this.profile,
    required this.presensiToday,
  });

  factory HomePresensiResponseModel.fromJson(Map<String, dynamic> json) {
    return HomePresensiResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      profile: json['profile'] != null
          ? HomeProfileModel.fromJson(json['profile'] as Map<String, dynamic>)
          : const HomeProfileModel.empty(),
      presensiToday: json['presensi_today'] != null
          ? HomePresensiTodayModel.fromJson(
              json['presensi_today'] as Map<String, dynamic>)
          : const HomePresensiTodayModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'profile': profile.toJson(),
      'presensi_today': presensiToday.toJson(),
    };
  }

  @override
  List<Object?> get props => [status, message, profile, presensiToday];
}
