import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/notifications/widgets/notification_card_widget.dart';
import 'package:booklub/ui/notifications/welcome_notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String? _filter;

  void _toggleFilter(String type) {
    setState(() {
      _filter = (_filter == type) ? null : type;
    });
  }

  Future<void> _handleNotificationTap(int index) async {
    await GoRouter.of(context).push(Routes.explore);
    setState(() {
      WelcomeNotificationStore.markAsRead(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final allNotifications = WelcomeNotificationStore.notifications;

    final filteredNotifications =
        _filter == null
            ? allNotifications
            : allNotifications
                .where(
                  (n) =>
                      _filter == 'unread' ? !n['isRead'] : n['isRead'] as bool,
                )
                .toList();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: BoxConstraints(minHeight: screenHeight * 0.74),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilterChip(
                          label: const Text('Não lidas'),
                          selected: _filter == 'unread',
                          onSelected: (_) => _toggleFilter('unread'),
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                          labelStyle: TextStyle(
                            color:
                                _filter == 'unread'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 12),
                        FilterChip(
                          label: const Text('Lidas'),
                          selected: _filter == 'read',
                          onSelected: (_) => _toggleFilter('read'),
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
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

                  ...allNotifications.asMap().entries.map((entry) {
                    final index = entry.key;
                    final notif = entry.value;

                    if (_filter == 'unread' && notif['isRead'] == true) {
                      return const SizedBox.shrink();
                    }
                    if (_filter == 'read' && notif['isRead'] == false) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _handleNotificationTap(index),
                        child: NotificationCard(
                          title: notif['title'] as String,
                          message: notif['message'] as String,
                          time: notif['time'] as String,
                          icon: notif['icon'] as IconData,
                          isRead: notif['isRead'] as bool,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
