import 'package:amazon_cognito_identity_dart_2/cognito.dart';

abstract class AuthenticationClient {
  Future<void> signUp(String email, String password);
  Future<bool> confirmation(String email, String code);
  Future<CognitoUserSession?> signIn(String email, String password);
  Future<bool> isAuthenticated();
  Future<void> signOut();
}
