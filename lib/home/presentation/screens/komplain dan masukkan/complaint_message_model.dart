// lib/complaint_message_model.dart
import 'package:flutter/material.dart';

enum MessageSender { user, admin }

class ComplaintMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final MessageSender sender;
  final String? senderName; // e.g., "FISTRA ADMIN"
  final IconData? avatarIcon; // e.g., Icons.admin_panel_settings_rounded

  ComplaintMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.sender,
    this.senderName,
    this.avatarIcon,
  });
}
