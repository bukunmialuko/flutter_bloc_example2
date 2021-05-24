import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example2/auth/auth_repository.dart';
import 'package:flutter_bloc_example2/auth/form_submission_status.dart';
import 'package:flutter_bloc_example2/auth/login/login_event.dart';
import 'package:flutter_bloc_example2/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc(this.authRepo) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      // password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authRepo.login();
        yield state.copyWith(formStatus: SubmittingSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
