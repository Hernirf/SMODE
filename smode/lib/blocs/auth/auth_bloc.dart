import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smode/models/login_form_model.dart';
import 'package:smode/models/user_model.dart';
import 'package:smode/services/auth_service.dart';
import 'package:smode/services/firebase_service.dart';
import 'package:smode/services/user_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthService().login(event.data);
          final token = await FirebaseService().initNotifications();
          print(token);
          if (token != null) await UserService().update(token);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());
          final LoginFormModel data =
              await AuthService().getCredentialFromLocal();
          final UserModel user = await AuthService().login(data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
