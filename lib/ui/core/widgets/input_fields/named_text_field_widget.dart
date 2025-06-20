import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/core/widgets/top_inner_shadow.dart/top_inner_shadow.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/material.dart';

class NamedTextFieldWidget extends StatefulWidget {
  final String label;

  final InputWrapper inputWrapper;

  final bool hidable;

  final Widget? suffixIcon;

  const NamedTextFieldWidget({
    super.key,
    required this.label,
    required this.inputWrapper,
    this.hidable = false,
    this.suffixIcon,
  });

  @override
  State<NamedTextFieldWidget> createState() => _NamedTextFieldWidgetState();
}

class _NamedTextFieldWidgetState extends State<NamedTextFieldWidget> {
  late bool _hideText;

  @override
  void initState() {
    super.initState();
    _hideText = widget.hidable;
  }

  void _toggleTextVisibility() {
    setState(() {
      _hideText = !_hideText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Builder(builder: _buildTextField), TopInnerShadow()],
    );
  }

  Widget _buildTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const borderRadius = BorderRadius.all(Radius.circular(8));

    final enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: borderRadius,
    );

    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.primary),
      borderRadius: borderRadius,
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error),
      borderRadius: borderRadius,
    );

    final suffixIcon =
        widget.suffixIcon ??
        (widget.hidable
            ? IconButton(
              icon: Icon(
                _hideText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: colorScheme.secondary,
              ),
              onPressed: _toggleTextVisibility,
            )
            : null);

    return TextFormField(
      obscureText: _hideText,
      validator: widget.inputWrapper.validator,
      controller: widget.inputWrapper,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: colorScheme.superLightBlack),
        floatingLabelStyle: TextStyle(color: colorScheme.onSurface),
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
