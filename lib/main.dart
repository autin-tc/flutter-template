import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plume/app.dart';
import 'package:plume/packages/apiService/api_service.dart';
import 'package:plume/packages/apiService/native_client.dart';
import 'package:plume/packages/authenticationService/authentication_service.dart';
import 'package:plume/packages/authenticationService/cognito_authentication_client.dart';
import 'package:plume/packages/keyStorageService/key_storage_service.dart';
import 'package:plume/repositories/authentication_repository.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(App(
    authenticationRepository: AuthenticationRepository(
        authService: AuthenticationService(CognitoAuthenticationClient()),
        keyStorageService: KeyStorageService(),
    ),
    apiService: ApiService(apiClient: NativeClient()),
  ));
}
