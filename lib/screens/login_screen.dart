import 'package:loginflutter_firebase_appium/widgets/password_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loginflutter_firebase_appium/widgets/email_field.dart';
import 'package:loginflutter_firebase_appium/providers/login_provider.dart';
import 'package:loginflutter_firebase_appium/providers/auth_provider.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //Providers
    final formProvider = context.watch<FormProvider>();
    final authProvider = context.read<AuthenticationProvider>();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Bienvenido')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 18,
                vertical: 80,
              ),
              child: Form(
                key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    EmailField(
                      emailController: formProvider.emailController,
                      emailFieldKey: const ValueKey('login_email_key'),
                    ),
                    const SizedBox(height: 20),
                    PasswordField(
                      passwordController: formProvider.passwordController,
                      passwordFieldKey: const ValueKey('login_password_key'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      key: const ValueKey('key_login_button'), //Key para appium
                      onPressed:
                          formProvider
                              .isLoading //Pantalla de carga
                          ? null
                          : () async {
                              if (formProvider.validateForm(loginFormKey)) {
                                formProvider.isLoading = true;
                                try {
                                  //Login en firebase
                                  await authProvider.signInWithEmail(
                                    formProvider.emailController.text,
                                    formProvider.passwordController.text,
                                  );
                                  formProvider.clearControllers();
                                  if (context.mounted) {
                                    Navigator.of(
                                      context,
                                    ).pushNamedAndRemoveUntil(
                                      "/home",
                                      (_) => false,
                                    );
                                  }
                                } catch (e) {
                                  //Capturar error y mostrarlo
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: ${e.toString()}'),
                                    ),
                                  );
                                  formProvider.clearControllers();
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
                          : const Text('Iniciar sesion'),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextButton(
                            onPressed: () {
                              formProvider.clearControllers();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "/formRegister",
                                (_) => false,
                              );
                            },
                            child: Text('Registrate aquí.'),
                          ),
                        ),
                        Spacer(flex: 1),
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Olvidó su contraseña?.'),
                          ),
                        ),
                      ],
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
