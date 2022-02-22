import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume/layouts/auth_layout.dart';
import 'package:plume/pages/confirm/bloc/confirm_bloc.dart';
import 'package:plume/pages/confirm/view/confirm_form.dart';
import 'package:plume/repositories/authentication_repository.dart';
import 'package:plume/routes/routes.dart';

class ScreenArguments {
  final String email;
  final String password;

  ScreenArguments(this.email, this.password);
}

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  static const routeName = RoutesBuilder.confirm;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return AuthLayout(
      title: 'Confirm',
      child: BlocProvider(
        create: (context) {
          return ConfirmBloc(
            userData: ScreenArguments(args.email, args.password),
            authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: const ConfirmForm(),
      ),
    );
  }
}
