part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Username username;
  final Password password;
  final bool hasBiometric;

  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.hasBiometric = false,
  });

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    bool? hasBiometric,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      hasBiometric: hasBiometric ?? this.hasBiometric,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
