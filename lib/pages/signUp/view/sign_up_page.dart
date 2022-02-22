import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume/layouts/auth_layout.dart';
import 'package:plume/pages/signUp/bloc/sign_up_bloc.dart';
import 'package:plume/pages/signUp/view/sign_up_form.dart';
import 'package:plume/repositories/authentication_repository.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Sign Up',
      child: BlocProvider(
        create: (context) {
          return SignUpBloc(
            authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: const SignUpForm(),
      ),
    );
  }
}
