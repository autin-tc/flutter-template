import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume/packages/apiService/dto/dto.dart';
import 'package:plume/pages/users/bloc/user_bloc.dart';


class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  @override
  void initState() {
    context.read<UserBloc>().add(UserLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserEmptyState) {
            return const Center(
                child: Text('You don\'t have users')
            );
          }
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if (state is UserLoadedState) {
            return ListView.builder(
              itemCount: state.loadedUser.length,
              itemBuilder: (BuildContext context, int index) {
                User _user = state.loadedUser[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(_user.name),
                    subtitle: Text(_user.email),
                  ),
                );
              },
            );
          }
          return const Text('');
        }
    );
  }
}


