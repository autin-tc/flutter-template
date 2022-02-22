import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:plume/pages/signUp/model/models.dart';
import 'package:plume/repositories/authentication_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignUpState()) {
    on<SignUpUsernameChanged>(_onUsernameChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
      SignUpUsernameChanged event,
      Emitter<SignUpState> emit,
      ) {
    final email = Email.dirty(event.username);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onPasswordChanged(
      SignUpPasswordChanged event,
      Emitter<SignUpState> emit,
      ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    ));
  }

  void _onSubmitted(
      SignUpSubmitted event,
      Emitter<SignUpState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
