import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/default_text_field.dart';
import '../cubit/shop_cubit.dart';
import '../cubit/shop_state.dart';
import '../helpers/cache.dart';
import '../pages/login.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void logout(BuildContext context) {
    CacheHelper.logout().then(
      (value) {
        if (value) {
          //log('Logout success');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final ShopCubit cubit = ShopCubit.get(context);

        if (cubit.userData != null && cubit.userData!.data != null) {
          _nameController.text = cubit.userData!.data!.name;
          _emailController.text = cubit.userData!.data!.email;
          _phoneController.text = cubit.userData!.data!.phone;
        }

        return cubit.userData == null
            ? const Center(child: LinearProgressIndicator())
            : cubit.userData!.data != null
                ? Center(child: Text(cubit.userData!.message!))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextField(
                          controller: _nameController,
                          label: 'Name',
                          type: TextInputType.name,
                          prefix: Icons.person,
                          validate: (String? val) {
                            if (val!.isEmpty) return 'name is required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        DefaultTextField(
                          controller: _emailController,
                          label: 'Email',
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,
                          validate: (String? val) {
                            if (val!.isEmpty) return 'email is required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        DefaultTextField(
                          controller: _phoneController,
                          label: 'Phone',
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                          validate: (String? val) {
                            if (val!.isEmpty) return 'phone is required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () => logout(context),
                          child: const Text(
                            'LOGOUT',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (state is ShopUserDataErrorStatus)
                          const Center(child: Text('An error occurred')),
                      ],
                    ),
                  );
      },
    );
  }
}
