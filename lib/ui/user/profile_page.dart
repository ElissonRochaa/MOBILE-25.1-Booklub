import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  final bool isMyOwnUserProfile;
  const ProfilePage({super.key, required this.userId, required this.isMyOwnUserProfile,});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
