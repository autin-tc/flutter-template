import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:plume/packages/authenticationService/authentication_client.dart';

class AuthenticationService {
  final AuthenticationClient _client;

  AuthenticationService(this._client);

  Future signUp(String email, String password) => _client.signUp(email, password);

  Future<bool> confirmation(String email, String code) => _client.confirmation(email, code);

  Future<CognitoUserSession?> signIn(String email, String password) => _client.signIn(email, password);

  Future<bool> isAuthenticated() => _client.isAuthenticated();

  Future<void> signOut() => _client.signOut();
}
