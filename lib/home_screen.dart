import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/auth_bloc.dart';
import 'package:login/login_screen.dart';
import 'package:login/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AuthSuccess) {
              return Column(
                children: [
                  Center(
                    child: Text(state.uid),
                  ),
                  GradientButton(onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  }),
                ],
              );
            } else {
              return const Text("Unknown error");
            }
          },
        ));
  }
}
