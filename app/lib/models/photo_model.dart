import 'package:flutter/material.dart';

class PhotoGallery {
  final String imageUrl;
  final String description;
  final String time;

  PhotoGallery({
    required this.imageUrl,
    required this.description,
    required this.time,
  });

  factory PhotoGallery.fromJson(Map<String, dynamic> json, String baseUrl) {
    final rawImageUrl = json['imageUrl']?.toString() ?? '';
    final resolvedImageUrl = rawImageUrl.startsWith('http')
        ? rawImageUrl
        : '$baseUrl$rawImageUrl';

    return PhotoGallery(
      imageUrl: resolvedImageUrl,
      description: json['description']?.toString().isNotEmpty == true
          ? json['description'].toString()
          : 'Foto da rotina',
      time: json['time']?.toString() ?? '',
    );
  }
}

class PhotoEntry {
  final int year;
  final IconData icon;
  final Color iconColor;

  PhotoEntry({required this.year, required this.icon, required this.iconColor});
}

class PhotoMonth {
  final String month;
  final IconData icon;
  final Color iconColor;

  PhotoMonth({
    required this.month,
    required this.icon,
    required this.iconColor,
  });
}

class PhotoDayEntry {
  final int day;
  final String month;
  final int year;
  final bool hasReport;

  PhotoDayEntry({
    required this.day,
    required this.month,
    required this.year,
    this.hasReport = true,
  });
}
