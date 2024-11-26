import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final email = event.email;
        final password = event.password;

        // Email validation regex
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

        if (!emailRegex.hasMatch(email)) {
          emit(AuthFailure('Invalid email format'));
          return;
        }

        if (password.length < 8) {
          emit(AuthFailure('Password can\'t be less than 8 characters'));
          return;
        }

        await Future.delayed(const Duration(seconds: 2), () {
          emit(
            AuthSuccess(uid: '$email-$password'),
          );
        });
      } on Exception catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    });
  }
}
