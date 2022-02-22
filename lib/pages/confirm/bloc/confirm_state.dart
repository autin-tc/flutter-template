part of 'confirm_bloc.dart';

class ConfirmState extends Equatable {
  const ConfirmState({
    this.status = FormzStatus.pure,
    this.code = const Code.pure(),
  });

  final FormzStatus status;
  final Code code;

  ConfirmState copyWith({
    FormzStatus? status,
    Code? code,
  }) {
    return ConfirmState(
      status: status ?? this.status,
      code: code ?? this.code,
    );
  }

  @override
  List<Object> get props => [status, code];
}
