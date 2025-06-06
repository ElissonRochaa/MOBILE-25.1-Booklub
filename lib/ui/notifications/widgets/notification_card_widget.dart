import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final bool isRead;
  final Color? color; // Still supported, but now optional

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.isRead,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color purple = theme.colorScheme.secondary;
    final Color lightGray = Colors.grey[350]!;

    final Color backgroundColor = isRead ? lightGray : purple;
    final Color textColor = isRead ? purple : lightGray;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: backgroundColor,
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Text(
          message,
          style: TextStyle(color: textColor.withOpacity(isRead ? 0.8 : 1)),
        ),
        trailing: Text(
          time,
          style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
        ),
      ),
    );
  }
}
