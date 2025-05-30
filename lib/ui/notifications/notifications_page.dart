import 'package:flutter/material.dart';
import 'package:booklub/ui/notifications/widgets/notification_card_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Mock notifications
  final List<Map<String, dynamic>> _allNotifications = [
    {
      "title": "New Review in 'Sci-Fi Lovers'",
      "message": "Ana just reviewed 'Dune'. Check it out!",
      "time": "2h ago",
      "icon": Icons.bookmark,
      "isRead": false,
    },
    {
      "title": "Meeting Reminder",
      "message": "‘Fantasy Readers’ meets tomorrow at 6pm!",
      "time": "1d ago",
      "icon": Icons.calendar_today,
      "isRead": true,
    },
    {
      "title": "New Member!",
      "message": "Liam just joined ‘Mystery Bookworms’. Say hi!",
      "time": "3h ago",
      "icon": Icons.person,
      "isRead": false,
    },
  ];

  String? _filter; // 'read', 'unread', or null

  void _toggleFilter(String type) {
    setState(() {
      if (_filter == type) {
        _filter = null; // Clear filter on second tap
      } else {
        _filter = type;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final filteredNotifications =
        _filter == null
            ? _allNotifications
            : _allNotifications
                .where((n) => _filter == 'unread' ? !n['isRead'] : n['isRead'])
                .toList();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: BoxConstraints(minHeight: screenHeight * 0.75),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Filter buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilterChip(
                          label: const Text('Unread'),
                          selected: _filter == 'unread',
                          onSelected: (_) => _toggleFilter('unread'),
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color:
                                _filter == 'unread'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 12),
                        FilterChip(
                          label: const Text('Read'),
                          selected: _filter == 'read',
                          onSelected: (_) => _toggleFilter('read'),
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color:
                                _filter == 'read'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Notifications list
                  ...filteredNotifications.map(
                    (notif) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: NotificationCard(
                        title: notif['title'] as String,
                        message: notif['message'] as String,
                        time: notif['time'] as String,
                        icon: notif['icon'] as IconData,
                        isRead: notif['isRead'] as bool,
                        color:
                            notif['isRead']
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
