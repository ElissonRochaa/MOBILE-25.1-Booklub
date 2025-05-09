import 'package:booklub/ui/user/edit/widgets/editable_field.dart';
import 'package:booklub/ui/user/edit/widgets/photo_picker.dart';
import 'package:booklub/ui/user/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

//TODO: Widget modificar o icon p passar como parametro, pesquisa de campo para data e alterar o layout da tela

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController controller_email = TextEditingController();
  final TextEditingController controller_senha = TextEditingController();
  final TextEditingController controller_nome = TextEditingController();
  final TextEditingController controller_username = TextEditingController();
  final TextEditingController controller_sobrenome = TextEditingController();
  final TextEditingController controller_data = TextEditingController();
  final TextEditingController controller_foto = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
                child: Column(
                  spacing: 16,
                  children: [
                    SectionTitle(
                      title: 'Informações da Conta',
                      icon: Icons.info_outline_rounded,
                    ),
                    EditableField(label: 'Email', controller: controller_email),
                    EditableField(
                      label: 'Senha',
                      controller: controller_senha,
                      obscureText: true,
                    ),
                    EditableField(label: 'Nome', controller: controller_nome),
                    EditableField(
                      label: 'Sobrenome',
                      controller: controller_sobrenome,
                    ),
                    EditableField(
                      label: 'Username',
                      controller: controller_username,
                    ),
                    EditableField(
                      label: 'Data de Nascimento',
                      controller: controller_data,
                    ),
                    PhotoPickerBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
