part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoadingEvent extends UserEvent {}
class UserLoadedEvent extends UserEvent {}
