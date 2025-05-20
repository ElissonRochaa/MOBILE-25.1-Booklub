import 'package:flutter/material.dart';

class ClubPrivacyToggle extends StatefulWidget {
  final bool isToggled;
  final ValueChanged<bool> onChanged;

  const ClubPrivacyToggle(this.isToggled, this.onChanged, {super.key});

  @override
  _ClubPrivacyToggleState createState() => _ClubPrivacyToggleState();
}

class _ClubPrivacyToggleState extends State<ClubPrivacyToggle> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.isToggled;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Switch(
      value: _isToggled,
      onChanged: (value) {
        setState(() {
          _isToggled = value;
        });
        widget.onChanged(value);
      },
      activeColor: theme.colorScheme.primary,
      inactiveThumbColor: theme.colorScheme.primary,
    );
  }
}
