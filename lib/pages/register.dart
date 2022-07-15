import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/default_text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../helpers/cache.dart';
import 'home.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState)
           _showSnakBar(context, 'An error occurred', Colors.redAccent);
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
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Register to your account',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.grey,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(height: 20),
                      DefaultTextField(
                        label: 'User Name',
                        type: TextInputType.name,
                        controller: nameController,
                        prefix: Icons.person,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
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
                        label: 'Phone Number',
                        type: TextInputType.phone,
                        controller: phoneController,
                        prefix: Icons.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
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
                        suffix: Icons.visibility_outlined,
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
                                    type: 'register',
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
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
