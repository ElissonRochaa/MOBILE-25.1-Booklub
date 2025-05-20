import 'package:booklub/ui/core/widgets/top_inner_shadow.dart/top_inner_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntFieldRounded extends StatefulWidget {
  final String? Function(String?) validator;
  final void Function(String)? onChanged;

  const IntFieldRounded(this.validator, this.onChanged, {super.key});

  @override
  State<StatefulWidget> createState() => _IntFieldRoundedState();
}

class _IntFieldRoundedState extends State<IntFieldRounded> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 35,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(children: [_buildTextField(theme), _TopShadow(context)]),
      ),
    );
  }

  Widget _buildTextField(ThemeData theme) {
    return TextFormField(
      validator: (value) => widget.validator(value),
      onChanged: widget.onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.surface,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _TopShadow(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: 10,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.15), Colors.transparent],
          ),
        ),
      ),
    );
  }
}
