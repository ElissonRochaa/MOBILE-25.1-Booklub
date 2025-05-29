import 'package:flutter/material.dart';
import 'package:booklub/ui/notifications/widgets/notification_card_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "New Review in 'Sci-Fi Lovers'",
        "message": "Ana just reviewed 'Dune'. Check it out!",
        "time": "2h ago",
        "icon": Icons.bookmark,
        "isRead": false,
      },
      {
        "title": "Reminder",
        "message": "Your book club meeting is tomorrow at 7PM.",
        "time": "5h ago",
        "icon": Icons.notifications_active,
        "isRead": true,
      },
      {
        "title": "New Member Joined",
        "message": "Lucas joined 'Classic Reads' club.",
        "time": "1d ago",
        "icon": Icons.group_add,
        "isRead": false,
      },
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final notif = notifications[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: NotificationCard(
            title: notif['title'] as String,
            message: notif['message'] as String,
            time: notif['time'] as String,
            icon: notif['icon'] as IconData,
            isRead: notif['isRead'] as bool,
          ),
        );
      }, childCount: notifications.length),
    );
  }
}
