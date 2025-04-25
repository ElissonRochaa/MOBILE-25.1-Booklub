import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	return Scaffold(
            body: Column(
                  children: [
                        Text("Tteste"),
                        PurpleRoundedButton("Entrar")
                  ],
            )
            
      );
  }

}