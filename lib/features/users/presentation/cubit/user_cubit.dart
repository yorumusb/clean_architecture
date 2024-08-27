import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_users.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsers getUsers;

  UserCubit(this.getUsers) : super(UserInitial());

  Future<void> fetchUsers() async {
    emit(UserLoading());

    final failureOrUsers = await getUsers();
    failureOrUsers.fold(
      (failure) => emit(UserError(_mapFailureToMessage(failure))),
      (users) => emit(UserLoaded(users)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      case const (NetworkFailure):
        return 'Network Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
