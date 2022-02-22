import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:plume/pages/confirm/bloc/confirm_bloc.dart';
import 'package:plume/routes/routes.dart';

class ConfirmForm extends StatelessWidget {
  const ConfirmForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfirmBloc, ConfirmState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Confirmation Failure')),
              );
          }
          if (state.status.isSubmissionSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(RoutesBuilder.home, (route) => false);
          }
        },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CodeInput(),
            const Padding(padding: EdgeInsets.all(16)),
            _ConfirmButton(),
            const Padding(padding: EdgeInsets.all(16)),
          ],
        ),
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmBloc, ConfirmState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return TextField(
          key: const Key('Confirm_passwordInput_textField'),
          onChanged: (code) =>
              context.read<ConfirmBloc>().add(CodeChanged(code)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'code',
            errorText: state.code.invalid ? 'invalid code' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmBloc, ConfirmState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('Confirm_continue_raisedButton'),
                child: const Text('Confirm'),
                onPressed: state.status.isValidated
                    ? () => context.read<ConfirmBloc>().add(const ConfirmSubmitted())
                    : null,
              );
      },
    );
  }
}
