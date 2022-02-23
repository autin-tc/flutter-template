part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Email email;
  final Password password;

  SignUpState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
  }) {
    return SignUpState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}
