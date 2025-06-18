import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EsqueceuSenhaClickableText extends StatelessWidget {
  const EsqueceuSenhaClickableText({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle defaultStyle = TextStyle(
      color: theme.colorScheme.onSurface,
      fontSize: theme.textTheme.bodyLarge?.fontSize ?? 16,
    );
    TextStyle linkStyle = TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold);
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
            text: 'Esqueceu sua senha?',
            style: linkStyle,
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.push('/recover-password');
                  },
          ),
        ],
      ),
    ),
    );
  }
}
