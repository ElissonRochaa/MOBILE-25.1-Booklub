import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClubCardWidget extends StatelessWidget {
  final Club club;

  const ClubCardWidget({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final image =
        club.imageUrl != null
            ? NetworkImage(club.imageUrl!)
            : const AssetImage('assets/images/default_club.png')
                as ImageProvider;

    return SizedBox(
      width: 100,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.go('/clubs/${club.id}');
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 35,
              child: Container(
                width: 100,
                height: 110,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 8, left: 6, right: 6),
                child: Text(
                  club.name,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              child: CircleImageWidget.expanded(
                borderColor: colorScheme.primary,
                borderWidth: 3,
                backgroundColor: colorScheme.surface,
                decorationImage: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
