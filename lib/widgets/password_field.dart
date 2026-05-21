import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final Key passwordFieldKey;

  const PasswordField({
    super.key,
    required this.passwordController,
    required this.passwordFieldKey,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.passwordFieldKey,
      controller: widget.passwordController,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintText: 'Por favor ingrese su contraseña',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese su contraseña';
        }
        return null;
      },
    );
  }
}
