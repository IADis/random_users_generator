import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_users_generator/repositories/user_model/users_model.dart';
import 'package:random_users_generator/repositories/users_repository.dart';

class UsersCubit extends Cubit<UsersStates> {
  UsersCubit({required this.usersRepository})
      : super(LoadingState(model: UsersModel()));

  final UsersRepository usersRepository;

  Future<void> getUsers({String? mode}) async {
    emit(LoadingState(model: state.model));
    await Future.delayed(const Duration(seconds: 1));
    final model = await usersRepository.getRandomUsers(mode: mode);
    emit(SuccessState(model: model));
  }
}

abstract class UsersStates {
  UsersStates({required this.model});
  final UsersModel model;
}

class LoadingState extends UsersStates {
  LoadingState({required this.model}) : super(model: model);
  final UsersModel model;
}

class InitialState extends UsersStates {
  InitialState({required this.model}) : super(model: model);
  final UsersModel model;
}

class SuccessState extends UsersStates {
  SuccessState({required this.model}) : super(model: model);
  final UsersModel model;
}

class ErrorState extends UsersStates {
  ErrorState({required this.model}) : super(model: model);
  final UsersModel model;
}
