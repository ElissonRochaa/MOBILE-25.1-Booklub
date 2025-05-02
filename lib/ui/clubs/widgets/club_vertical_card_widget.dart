import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/core/widgets/vertical_card_widget.dart';
import 'package:flutter/material.dart';

class ClubVerticalCardWidget extends StatelessWidget {

  final Club club;

  const ClubVerticalCardWidget({
    super.key,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalCardWidget(
      imageProvider: NetworkImage(club.imageUrl),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(club.name),
          ],
        ),
      ),
    );
  }


}
