import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'state.dart';

class LogInCubit extends Cubit<LogInstate> {
  LogInCubit() : super(AppInitState());

  static LogInCubit get(context) {
    return BlocProvider.of(context);
  }

  bool Vispass = false;

  void ChangepasswordVisiability() {
    Vispass = !Vispass;
    emit(ChangeVisState());
  }

  void userLogin({required Email, required pass}) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: Email, password: pass)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      emit(SocialRegisterSuccState(value.user!.uid));
    }).catchError((Error) {
      emit(SocialRegisterErrorState(Error.toString()));
    });
  }

  void resetpassword({required Email}) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: Email).then((value) {
      print("Reset Password");
      emit(SocialResetPassSuccState());
    }).catchError((value) {
      emit(SocialResetPassErrorState(value.toString()));
    });
  }
}
