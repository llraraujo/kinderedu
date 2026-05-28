
import 'package:flutter/material.dart';

class ProfileMenuOption {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  ProfileMenuOption({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class UserProfile {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String imageUrl;

  UserProfile({
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.imageUrl,
  });
}

class LinkedChild {
  final String name;
  final String age;
  final String imageUrl;

  LinkedChild({
    required this.name,
    required this.age,
    required this.imageUrl,
  });
}

class EmergencyContact {
  final String name;
  final String phone;

  EmergencyContact({
    required this.name,
    required this.phone,
  });
}