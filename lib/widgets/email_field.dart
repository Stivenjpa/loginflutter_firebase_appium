import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final Key emailFieldKey;
  const EmailField({
    super.key,
    required this.emailController,
    required this.emailFieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: emailFieldKey, //Key para appium
      decoration: InputDecoration(
        labelText: 'Correo Electronico',
        hintText: 'Por favor ingrese su correo electronico',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese su correo';
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Ingresa un correo electrónico válido';
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
