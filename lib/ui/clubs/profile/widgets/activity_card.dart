import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActivityCard extends StatelessWidget {

  final String activity;

  final String title;

  final Widget additionalContent;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.title,
    required this.additionalContent,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final imageWidget = InkWell(
      onTap: () => context.push(Routes.individualBook()),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://m.media-amazon.com/images/I/91ocgbfq55L._AC_UF1000,1000_QL80_.jpg'),
            fit: BoxFit.cover,
          )
        ),
      ),
    );

    final content = [
      Text(activity),
      Text(
        title,
        style: textTheme.labelMedium!.copyWith(
          fontFamily: 'Navicula',
          fontWeight: FontWeight.w700,
          color: colorScheme.primary
        ),
      ),
      additionalContent
    ];

    return Card(
      color: colorScheme.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content,
              ),
            ),
            AspectRatio(
              aspectRatio: 1/1.6,
              child: imageWidget
            ),
          ],
        ),
      ),
    );
  }
}
