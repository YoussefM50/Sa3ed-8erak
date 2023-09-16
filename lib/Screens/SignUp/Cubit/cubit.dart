import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/Sa3edUserData.dart';
import 'state.dart';

class SignUpCubit extends Cubit<SignUpstate> {
  SignUpCubit() : super(AppInitState());

  static SignUpCubit get(context) {
    return BlocProvider.of(context);
  }

  bool Vispass = false;

  void ChangepasswordVisiability() {
    Vispass = !Vispass;
    emit(ChangeVisState());
  }

  void UserRegister({
    required String email,
    required String pass,
    required String Fname,
    required String Lname,
    required String id,
    required String address,
    required String phonenumber,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      CreateUser(
          Fname: Fname,
          Lname: Lname,
          Uid: value.user!.uid,
          id: id,
          email: email,
          address: address,
          phonenumber: phonenumber);
      emit(SocialRegisterSuccState(value.user!.uid));
    }).catchError((Error) {
      emit(SocialRegisterErrorState(Error.toString()));
    });
  }

  void CreateUser({
    required String Fname,
    required String Lname,
    required String Uid,
    required String id,
    required String email,
    required String address,
    required String phonenumber,
  }) {
    Social_model model = Social_model(
        Fname: Fname,
        Lname: Lname,
        Uid: Uid,
        id: id,
        email: email,
        address: address,
        phonenumber: phonenumber);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(Uid)
        .set(model.tomap())
        .then((value) {
      // emit(SocialCreateUserSuccState());
    }).catchError((Error) {
      emit(SocialCreateUserErrorState(Error.toString()));
    });
  }

  void confirm_Id({
    required String email,
    required String pass,
    required String Fname,
    required String Lname,
    required String id,
    required String address,
    required String phonenumber,
  }) {
    emit(SocialIduCheckState());
    FirebaseFirestore.instance
        .collection("Users")
        .where("id", isEqualTo: id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());
        emit(SocialIdusededState());
      });
      print("ooooooooooooooook");
      if (state is! SocialIdusededState) {
        UserRegister(
            email: email,
            pass: pass,
            Fname: Fname,
            Lname: Lname,
            id: id,
            address: address,
            phonenumber: phonenumber);
      }
    }).catchError((Error) {
      print(Error);
    });
  }
}
