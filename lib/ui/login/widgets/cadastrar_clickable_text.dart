import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CadastrarClickableText extends StatelessWidget {
  const CadastrarClickableText({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle defaultStyle = TextStyle(
      color: theme.colorScheme.onSurface,
      fontSize: theme.textTheme.bodyLarge?.fontSize ?? 16,
    );
    TextStyle linkStyle = TextStyle(color: theme.colorScheme.secondary);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: 'ou '),
          TextSpan(
            text: 'cadastre-se',
            style: linkStyle,
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.push('/register');
                  },
          ),
        ],
      ),
    );
  }
}
