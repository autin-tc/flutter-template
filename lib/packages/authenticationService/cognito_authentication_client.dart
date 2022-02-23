import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plume/packages/authenticationService/authentication_client.dart';

class CognitoAuthenticationClient implements AuthenticationClient {
  final CognitoUserPool _userPool = CognitoUserPool(
     dotenv.get('USER_POOL_ID'),
     dotenv.get('CLIENT_ID')
  );

  @override
  Future signUp(String userName, String password) async {
    final userAttributes = [
      AttributeArg(name: 'email', value: userName),
    ];
    try {
      return await _userPool.signUp(userName, password, userAttributes: userAttributes);
    } catch(e) {
      print(e);
    }
  }

  @override
  Future<bool> confirmation(String email, String code) async {
    final cognitoUser = CognitoUser(email, _userPool);
    return await cognitoUser.confirmRegistration(code);
  }

  @override
  Future<CognitoUserSession?> signIn(String email, String password) async {
    final cognitoUser = CognitoUser(email, _userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );

    return await cognitoUser.authenticateUser(authDetails);

  }
  @override
  Future<bool> isAuthenticated() async {
    final user = await _userPool.getCurrentUser();
    return user != null ? true : false;
  }

  @override
  Future<void> signOut() async {
    final user = await _userPool.getCurrentUser();
    user != null ? await user.signOut() : null;
  }
}
