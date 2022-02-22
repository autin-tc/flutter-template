import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:plume/pages/signUp/bloc/sign_up_bloc.dart';
import '../../confirm/view/confirm_page.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          Navigator.pushNamed(
              context,
              ConfirmPage.routeName,
              arguments: ScreenArguments(
                state.email.value,
                state.password.value,
              )
          );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(16)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(16)),
            _SignUpButton(),
            const Padding(padding: EdgeInsets.all(16)),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('SignUpForm_emailInput_textField'),
          onChanged: (username) =>
              context.read<SignUpBloc>().add(SignUpUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('SignUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                child: const Text('Sign Up'),
                onPressed: state.status.isValidated
                    ? () {
                  context.read<SignUpBloc>().add(const SignUpSubmitted());
                }
                    : null,
              );
      },
    );
  }
}
