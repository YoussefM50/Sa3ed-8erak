import 'package:final_pro/Screens/LogIn/reserpassword.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../Admin/Adminpage.dart';
import '../../Helper/Share_Pref.dart';
import '../../Theme/theme.dart';
import '../../imp_func.dart';
import '../../widgets/botton.dart';
import '../../widgets/text_field.dart';
import '../SignUp/Signup.dart';
import '../homepage/tabview/tabview.dart';
import 'Cubit/cubit.dart';
import 'Cubit/state.dart';

class LogInSrc extends StatelessWidget {
  var id = TextEditingController();
  var password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    // vis_icon() {
    //   return IconButton(
    //     icon: Icon(not_visible ? Icons.visibility : Icons.visibility_off),
    //     color: Colors.black,
    //     onPressed: () {
    //       setState(() {
    //         print("Visiable : $not_visible");
    //         not_visible = !not_visible;
    //       });
    //     },
    //   );
    // }
    return BlocProvider(
        create: (context) => LogInCubit(),
        child: BlocConsumer<LogInCubit, LogInstate>(
          listener: (context, state) {
            if (state is SocialRegisterErrorState) {
              print(state.error);
              showtoast(
                  state.error ==
                          '[firebase_auth/invalid-email] The email address is badly formatted.'
                      ? "مشكله في شكل البريد الإلكتروني"
                      : state.error ==
                              "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."
                          ? "بريد إلكتروني غير موجود"
                          : state.error ==
                                  "[firebase_auth/wrong-password] The password is invalid or the user does not have a password."
                              ? "الرقم السري غير صحيح"
                              : "حاول فى وقت أخر",
                  2);
            }
            if (state is SocialRegisterSuccState) {
              print(state.Id);
              UID = state.Id;
              if (UID == "fU7m4HlpLXOq8Dx8W6YyzXjANDg2") {
                Sharepref.savedata(key: "UID", value: state.Id).then((value) {
                  go_toAnd_finish(context, BlocProviderAdminscreen());
                  showtoast("تم تسجيل الدخول بنجاح 😁", 1);
                });
              } else {
                Sharepref.savedata(key: "UID", value: state.Id).then((value) {
                  go_toAnd_finish(context, Blockprovidertabview());
                  showtoast("تم تسجيل الدخول بنجاح 😁", 1);
                });
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: const AssetImage("lib/img/img4.jpg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(.9),
                                BlendMode.modulate))),
                    child: BlurryContainer(
                      width: mediaquery(context).width,
                      height: mediaquery(context).height, //340
                      blur: 10,
                      elevation: 2,
                      color: Colors.transparent,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset(
                                projectLogo,
                                height: 120,
                                width: 120,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TEXTFIELD(
                                id,
                                TextInputType.emailAddress,
                                "البريد الالكتروني",
                                "ادخل البريد الالكتروني",
                                const Icon(
                                  Icons.login,
                                  color: Colors.black,
                                ),
                                false),
                            const SizedBox(
                              height: 10,
                            ),
                            TEXTFIELD(
                                password,
                                TextInputType.visiblePassword,
                                "كلمة السر",
                                "ادخل كلمة السر",
                                PassIcon(
                                    Icon(LogInCubit.get(context).Vispass
                                        ? Icons.visibility_off
                                        : Icons.visibility), () {
                                  print(
                                      "Visiable : ${!LogInCubit.get(context).Vispass}");
                                  LogInCubit.get(context)
                                      .ChangepasswordVisiability();
                                }),
                                !LogInCubit.get(context).Vispass),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  go_to(context, resetpassword());
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "هل نسيت كلمة السر ؟",
                                    style: Bodylestyle.copyWith(
                                        color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Mybutton(
                                label: "تسجيل الدخول",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    LogInCubit.get(context).userLogin(
                                        Email: id.text, pass: password.text);
                                  }
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            line_or(),
                            const SizedBox(
                              height: 10,
                            ),
                            Mybutton(
                                label: "انشاء حساب",
                                onTap: () {
                                  go_to(context, SignUpSrc());
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  line_or() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              height: 1,
              width: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            child: Text(
              "او",
              style: Body2lestyle.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              height: 1,
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}
