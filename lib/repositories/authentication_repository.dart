
import 'dart:async';

import 'package:plume/packages/authenticationService/authentication_service.dart';
import 'package:plume/packages/keyStorageService/key_storage_service.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, bioAuth }

class AuthenticationRepository {
  final AuthenticationService authService;
  final KeyStorageService keyStorageService;

  AuthenticationRepository({required this.authService, required this.keyStorageService});
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    final isBioEnabled = await keyStorageService.containsItem('bio');
    final isAuthenticated = await authService.isAuthenticated();

    if (isAuthenticated) {
      yield AuthenticationStatus.authenticated;
    } else {
      if (isBioEnabled) {
        yield AuthenticationStatus.authenticated;
      } else {
        yield AuthenticationStatus.authenticated;
      }
    }

    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final result = await authService.signIn(email, password);
    if (result != null) {
      final String? accessToken = result.accessToken.jwtToken;
      String? refreshToken = result.refreshToken?.token;
      if (accessToken != null) {
        keyStorageService.setItem('access_token', accessToken);
      }
      if (refreshToken != null) {
        keyStorageService.setItem('refresh_token', refreshToken);
      }
    }

    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await authService.signUp(email, password);
  }

  Future<void> confirm ({
    required String email,
    required String code,
  }) async {
    await authService.confirmation(email, code);
  }

  Future<void> logOut() async {
    final isBioAuthEnabled = await keyStorageService.containsItem('bio');
    isBioAuthEnabled
        ? _controller.add(AuthenticationStatus.bioAuth)
        : _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
