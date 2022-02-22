import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:plume/pages/confirm/confirm.dart';
import 'package:plume/pages/confirm/model/code.dart';
import 'package:plume/repositories/authentication_repository.dart';

part 'confirm_state.dart';
part 'confirm_event.dart';

class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {
  final ScreenArguments userData;
  ConfirmBloc({
    required this.userData,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const ConfirmState()) {
    on<CodeChanged>(_onCodeChanged);
    on<ConfirmSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onCodeChanged(
      CodeChanged event,
      Emitter<ConfirmState> emit,
      ) {
    final code = Code.dirty(event.code);
    emit(state.copyWith(
      code: code,
      status: Formz.validate([code]),
    ));
  }

  void _onSubmitted(
      ConfirmSubmitted event,
      Emitter<ConfirmState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.confirm(
          email: userData.email,
          code: state.code.value,
        );
        await _authenticationRepository.logIn(email: userData.email, password: userData.password);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
