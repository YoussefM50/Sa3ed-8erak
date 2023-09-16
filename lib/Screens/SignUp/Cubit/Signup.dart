import 'package:final_pro/Screens/LogIn/LogIn.dart';
import 'package:final_pro/Screens/SignUp/Cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Helper/Share_Pref.dart';
import '../../../Theme/theme.dart';
import '../../../imp_func.dart';
import '../../../widgets/botton.dart';
import '../../../widgets/text_field.dart';
import '../../homepage/tabview/tabview.dart';
import 'cubit.dart';



class SignUpSrc extends StatelessWidget {
  var id = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var address = TextEditingController();
  var confirmpassword = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var phonenumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpstate>(
          listener: (context, state) {
            if (state is SocialIdusededState) {
              showtoast(
                  "الرقم القومي موجود برجاء التواصل معنا لحل المشكله شكراً ",
                  2);
              id.text = "";
            }
            if (state is SocialRegisterErrorState) {
              print(state.Error);
              showtoast(
                  state.Error ==
                          "[firebase_auth/email-already-in-use] The email address is already in use by another account."
                      ? "الحساب موجود لمستخدم اخر"
                      : state.Error ==
                              "[firebase_auth/invalid-email] The email address is badly formatted."
                          ? "مشكله في شكل البريد الإلكتروني"
                          : state.Error ==
                                  "[firebase_auth/weak-password] Password should be at least 6 characters"
                              ? "الرقم السري ضعيف"
                              : "حاول فى وقت أخر",
                  2);
            }
            if (state is SocialRegisterSuccState) {
              print(state.Id);
              Sharepref.savedata(key: "UID", value: state.Id).then((value) {
                go_toAnd_finish(context,  Blockprovidertabview());
                showtoast("Success", 1);
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: null,
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: const AssetImage("lib/img/img4.jpg"),
                            fit: BoxFit.fitHeight,
                            colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(.9),
                                BlendMode.modulate))),
                    child: BlurryContainer(
                      height: mediaquery(context).height,
                      width: mediaquery(context).width,
                      borderRadius: BorderRadius.circular(0),
                      blur: 10,
                      elevation: 2,
                      color: Colors.transparent,
                      child: Form(
                        key: _formKey,
                        child: SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(55),
                                      child: Image.asset(
                                        projectLogo,
                                        height: 90,
                                        width: 90,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery(context).width / 4,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          go_to(context, LogInSrc());
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Center(
                                  child: Text(
                                    "التسجيل",
                                    style: Headingstyle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TEXTFIELD(
                                          firstname,
                                          TextInputType.text,
                                          "الأسم الأول",
                                          "ادخل الأسم الأول",
                                          const Icon(
                                            Icons.account_circle,
                                            color: Colors.black,
                                          ),
                                          false),
                                    ),
                                    Expanded(
                                      child: TEXTFIELD(
                                          lastname,
                                          TextInputType.text,
                                          "الأسم الأخير",
                                          "ادخل الأسم الأخير",
                                          const Icon(
                                            Icons.account_circle,
                                            color: Colors.black,
                                          ),
                                          false),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                TEXTFIELD(
                                    phonenumber,
                                    TextInputType.phone,
                                    "رقم الهاتف",
                                    "ادخل رقم الهاتف",
                                    const Icon(
                                      Icons.numbers_outlined,
                                      color: Colors.black,
                                    ),
                                    false),
                                const SizedBox(
                                  height: 1,
                                ),
                                TEXTFIELD(
                                    address,
                                    TextInputType.text,
                                    "العنوان",
                                    "ادخل العنوان",
                                    const Icon(
                                      Icons.fmd_good_sharp,
                                      color: Colors.black,
                                    ),
                                    false),
                                const SizedBox(
                                  height: 1,
                                ),
                                TEXTFIELD(
                                    id,
                                    TextInputType.number,
                                    "الرقم القومي",
                                    "ادخل الرقم القومي",
                                    const Icon(
                                      Icons.numbers,
                                      color: Colors.black,
                                    ),
                                    false),
                                const SizedBox(
                                  height: 1,
                                ),
                                TEXTFIELD(
                                    email,
                                    TextInputType.emailAddress,
                                    "البريد الالكتروني",
                                    "ادخل البريد الالكتروني",
                                    const Icon(
                                      Icons.login,
                                      color: Colors.black,
                                    ),
                                    false),
                                const SizedBox(
                                  height: 1,
                                ),
                                TEXTFIELD(
                                    password,
                                    TextInputType.visiblePassword,
                                    "الرقم السري",
                                    "ادخل الرقم السري",
                                    PassIcon(
                                        Icon(SignUpCubit.get(context).Vispass
                                            ? Icons.visibility_off
                                            : Icons.visibility), () {
                                      print(
                                          "Visiable : ${SignUpCubit.get(context).Vispass}");
                                      SignUpCubit.get(context)
                                          .ChangepasswordVisiability();
                                    }),
                                    !SignUpCubit.get(context).Vispass),
                                const SizedBox(
                                  height: 1,
                                ),
                                TEXTFIELD(
                                    confirmpassword,
                                    TextInputType.visiblePassword,
                                    "تأكيد الرقم السري",
                                    "ادخل الرقم السري",
                                    PassIcon(
                                        Icon(SignUpCubit.get(context).Vispass
                                            ? Icons.visibility_off
                                            : Icons.visibility), () {
                                      print(
                                          "Visiable : ${SignUpCubit.get(context).Vispass}");
                                      SignUpCubit.get(context)
                                          .ChangepasswordVisiability();
                                    }),
                                    !SignUpCubit.get(context).Vispass,
                                    conpass: password),
                                const SizedBox(
                                  height: 15,
                                ),
                                Mybutton(
                                    label: "انشاء حساب",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        SignUpCubit.get(context).confirm_Id(
                                            email: email.text,
                                            pass: confirmpassword.text,
                                            Fname: firstname.text,
                                            Lname: lastname.text,
                                            id: id.text,
                                            address: address.text,
                                            phonenumber: phonenumber.text);
                                      }
                                    }),
                              ],
                            ),
                          ),
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
}
