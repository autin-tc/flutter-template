import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:plume/layouts/main_layout.dart';
import 'package:plume/packages/apiService/api_service.dart';
import 'package:plume/pages/users/bloc/user_bloc.dart';
import 'package:plume/pages/users/view/users_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();
    return MainLayout(
        title: 'Users',
        child: BlocProvider<UserBloc>(
            create: (_) => UserBloc(apiService: apiService),
            child: const UserList(),
        )
    );
  }
}
