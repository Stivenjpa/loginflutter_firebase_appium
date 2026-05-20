import 'package:loginflutter_firebase_appium/widgets/password_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loginflutter_firebase_appium/widgets/email_field.dart';
import 'package:loginflutter_firebase_appium/providers/login_provider.dart';
import 'package:loginflutter_firebase_appium/providers/auth_provider.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final formProvider = context.watch<FormProvider>();
    final authProvider = context.read<AuthenticationProvider>();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Registro')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 18,
                vertical: 80,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    EmailField(emailController: formProvider.emailController),
                    const SizedBox(height: 20),
                    PasswordField(
                      passwordController: formProvider.passwordController,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      key: const ValueKey(
                        'key_register_button',
                      ), //Key para appium
                      onPressed:
                          formProvider
                              .isLoading //Pantalla de carga
                          ? null
                          : () async {
                              if (formProvider.validateForm(formKey)) {
                                formProvider.isLoading = true;
                                try {
                                  //Login en firebase
                                  await authProvider.signUpWithEmail(
                                    formProvider.emailController.text,
                                    formProvider.passwordController.text,
                                  );
                                  print('Usuario registrado');
                                  if (context.mounted) {
                                    Navigator.of(
                                      context,
                                    ).pushNamedAndRemoveUntil(
                                      "/home",
                                      (_) => false,
                                    );
                                  }
                                  ;
                                } catch (e) {
                                  //Capturar error y mostrarlo
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: ${e.toString()}'),
                                    ),
                                  );
                                } finally {
                                  //Finalizamos el loading
                                  formProvider.isLoading = false;
                                }
                              }
                            },
                      child: formProvider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Registrarme'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
