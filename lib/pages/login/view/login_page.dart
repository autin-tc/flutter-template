import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume/layouts/auth_layout.dart';
import 'package:plume/packages/biometricsService/biometrics_service.dart';
import 'package:plume/pages/login/login.dart';
import 'package:plume/repositories/authentication_repository.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        title: 'Login',
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
              biometricService: BiometricsService(),
            );
          },
          child: const LoginForm(),
        ),
    );
  }
}
