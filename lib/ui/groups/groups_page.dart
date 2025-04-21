import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key, required this.title});

  final String title;

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times: =)'),
        ],
      ),
    );

  }
}