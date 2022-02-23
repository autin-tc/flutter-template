part of 'confirm_bloc.dart';

abstract class ConfirmEvent extends Equatable {
  const ConfirmEvent();

  @override
  List<Object> get props => [];
}

class CodeChanged extends ConfirmEvent {
  const CodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class ConfirmSubmitted extends ConfirmEvent {
  const ConfirmSubmitted();
}
