import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume/packages/apiService/api_service.dart';
import 'package:plume/packages/apiService/dto/dto.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  UserBloc({required this.apiService}) : super(UserEmptyState()) {
    on<UserLoadingEvent>(_onUserEventLoading);
  }

  FutureOr<void> _onUserEventLoading(UserLoadingEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final List<User> _loadedUserList = await apiService.fetchUsers();
      emit(UserLoadedState(loadedUser: _loadedUserList));
    } catch (_) {
      emit(UserErrorState());
    }
  }
}
