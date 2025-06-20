import 'package:flutter/material.dart';

class WelcomeNotificationStore {
  static final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Bem-vinde ao Booklub!",
      "message": "Obrigado por se juntar a nós! Explore nossos clubes.",
      "time": "1min atrás",
      "icon": Icons.celebration,
      "isRead": false,
    },
  ];

  static List<Map<String, dynamic>> get notifications => _notifications;

  static void markAsRead(int index) {
    _notifications[index]['isRead'] = true;
  }
}
