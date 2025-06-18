import 'package:booklub/ui/clubs/profile/widgets/_club_activities_list_widget.dart';
import 'package:booklub/ui/clubs/profile/widgets/_club_profile_info_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClubProfilePageBodyWidget extends StatefulWidget {

  const ClubProfilePageBodyWidget({super.key});

  @override
  State<ClubProfilePageBodyWidget> createState() => _ClubProfilePageBodyWidgetState();

}

enum ProfileInfoSection {members, readings, badges, requests}

class _ClubProfilePageBodyWidgetState extends State<ClubProfilePageBodyWidget> {

  ProfileInfoSection? selectedProfileInfoSection;

  void _setSection(ProfileInfoSection section) {
    setState(() {
      selectedProfileInfoSection =
      selectedProfileInfoSection == section ? null : section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageBody = selectedProfileInfoSection != null
      ? Builder(builder: _buildProfileInfoDetails)
      : ClubActivitiesListWidget();

    return MultiSliver(
      children: [
        Builder(builder: _buildProfileInfo),
        pageBody
      ]
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    final profileInfos = [
      ClubProfileInfoListItem(
        label: 'Membros',
        number: 8,
        onTap: () => _setSection(ProfileInfoSection.members),
        selected: selectedProfileInfoSection == ProfileInfoSection.members,
      ),
      ClubProfileInfoListItem(
        label: 'Leituras',
        number: 3,
        onTap: () => _setSection(ProfileInfoSection.readings),
        selected: selectedProfileInfoSection == ProfileInfoSection.readings,
      ),
      ClubProfileInfoListItem(
        label: 'Badges',
        number: 1,
        onTap: () => _setSection(ProfileInfoSection.badges),
        selected: selectedProfileInfoSection == ProfileInfoSection.badges,
      ),
      ClubProfileInfoListItem(
        label: 'Solicitações',
        number: 4,
        onTap: () => _setSection(ProfileInfoSection.requests),
        selected: selectedProfileInfoSection == ProfileInfoSection.requests,
      ),
    ];

    return ClubProfileInfoListWidget(
      infoItems: profileInfos,
    );
  }

  Widget _buildProfileInfoDetails(BuildContext context) {
    final placeholder = const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Placeholder(),
      ),
    );

    return switch (selectedProfileInfoSection) {
      ProfileInfoSection.members => placeholder,
      ProfileInfoSection.readings => placeholder,
      ProfileInfoSection.badges => placeholder,
      ProfileInfoSection.requests => placeholder,
      _ => throw UnimplementedError('Section not implemented'),
    };
  }

}


