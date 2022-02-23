import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:plume/packages/biometricsService/biometrics_service.dart';
import 'package:plume/pages/login/model/models.dart';
import 'package:plume/repositories/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
    required BiometricsService biometricService,
  })  : _authenticationRepository = authenticationRepository,
        _biometricsService = biometricService,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<ShowBioMetricDialog>(_onShowBioMetricDialog);
    on<Initial>(_onInitial);
  }

  final AuthenticationRepository _authenticationRepository;
  final BiometricsService _biometricsService;

  void _onUsernameChanged(
      LoginUsernameChanged event,
      Emitter<LoginState> emit,
      ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          email: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  FutureOr<void> _onShowBioMetricDialog(ShowBioMetricDialog event, Emitter<LoginState> emit) async {
    // emit(state.copyWith(isBiometricsDialog: true));
    final bool status = await _biometricsService.authenticate();
    print(status);
    if (status) {
      final email = await _authenticationRepository.keyStorageService.getItem('plume_user_username');
      final password = await _authenticationRepository.keyStorageService.getItem('plume_user_password');
      if (email != null && password != null) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        await _authenticationRepository.logIn(
          email: email,
          password: password,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } else {
      // emit(state.copyWith(isBiometricsDialog: false));
    }
  }


  FutureOr<void> _onInitial(Initial event, Emitter<LoginState> emit) async {
    final bool status = await _authenticationRepository.hasBiometrics();
    if (status) emit(state.copyWith(hasBiometric: true));
  }
}
