import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/default_text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../helpers/cache.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.userItem!.status) {
            _showSnakBar(context, state.userItem!.message!, Colors.greenAccent);

            CacheHelper.saveData('token', state.userItem!.data!.token)
                .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    ));
          } else
            _showSnakBar(context, state.userItem!.message!, Colors.redAccent);
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.grey,
                              fontSize: 26,
                            ),
                      ),
                      const SizedBox(height: 20),
                      DefaultTextField(
                        label: 'Email Address',
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        prefix: Icons.email_outlined,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DefaultTextField(
                        label: 'Password',
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        prefix: Icons.lock_outline,
                        suffix: cubit.isPasswordShown
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        suffixPress: () => cubit.changeVisibility(),
                        isPassword: cubit.isPasswordShown,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      state is! LoginLoadingState
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                minimumSize: const Size.fromHeight(50),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  FocusScope.of(context).unfocus();
                                  cubit.userLoginOrRegister(
                                    type: 'login',
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSnakBar(ctx, String message, redAccent) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 20,
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: redAccent,
      ),
    );
  }
}
