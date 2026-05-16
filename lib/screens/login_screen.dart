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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //Providers
    final formProvider = context.watch<FormProvider>();
    final authProvider = context.read<AuthenticationProvider>();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Bienvenido')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 18,
              vertical: 250,
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
                    key: const ValueKey('key_login_button'), //Key para appium
                    onPressed:
                        formProvider
                            .isLoading //Pantalla de carga
                        ? null
                        : () async {
                            if (formProvider.validateForm(formKey)) {
                              formProvider.isLoading = true;
                              try {
                                //Login en firebase
                                await authProvider.signInWithEmail(
                                  formProvider.emailController.text,
                                  formProvider.passwordController.text,
                                );
                                print('Login Exitoso');
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
                        : const Text('Iniciar sesion'),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text('Olvidó su contraseña?'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
