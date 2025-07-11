import 'package:flutter/material.dart';
import 'package:booklub/ui/notifications/widgets/notification_card_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> _allNotifications = [
    {
      "title": "Nova avaliação em 'clube das lindas'",
      "message": "Ana avaliou 'Duna'. Veja!",
      "time": "2h atrás",
      "icon": Icons.bookmark,
      "isRead": false,
    },
    {
      "title": "Lembre-se do encontro!",
      "message": "‘clube do romance’ tem encontro amanhã às 19h.",
      "time": "1d atrás",
      "icon": Icons.calendar_today,
      "isRead": true,
    },
    {
      "title": "Novo membro no clube!",
      "message": "Michael entrou no 'clube dos aventureiros'. Diga 'olá'!",
      "time": "3h atrás",
      "icon": Icons.person,
      "isRead": false,
    },
  ];

  String? _filter;

  void _toggleFilter(String type) {
    setState(() {
      if (_filter == type) {
        _filter = null;
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
