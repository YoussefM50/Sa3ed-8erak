import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Cubit/state.dart';
import 'package:final_pro/imp_func.dart';
import 'package:final_pro/widgets/botton.dart';
import 'package:final_pro/widgets/text_field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/toastbar.dart';

class BlocProviderEditpassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: Editpassword(),
    );
  }
}

class Editpassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var oldpassword = TextEditingController();
    var newpassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1.5,
        title: const Text(
          "تحديث كلمة السر",
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is changepasswordfailure) {
          showtoast(state.error, 2);
        } else if (state is changepasswordsuccess) {
          showtoast("تم تغيير كلمة السر بنجاح ", 1);
        }
      }, builder: (context, state) {
        oldpassword = TextEditingController();
        newpassword = TextEditingController();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        TEXTFIELD(
                            oldpassword,
                            TextInputType.visiblePassword,
                            "كلمة السر الحالية ",
                            "ادخل كلمة السر",
                            PassIcon(
                                Icon(AppCubit.get(context).Vispass
                                    ? Icons.visibility_off
                                    : Icons.visibility), () {
                              print(
                                  "Visiable : ${AppCubit.get(context).Vispass}");
                              AppCubit.get(context).ChangepasswordVisiability();
                            }),
                            !AppCubit.get(context).Vispass),
                        const SizedBox(
                          height: .5,
                        ),
                        TEXTFIELD(
                          newpassword,
                          TextInputType.visiblePassword,
                          "كلمة السر الجديدة",
                            "ادخل كلمة السر",
                          PassIcon(
                              Icon(AppCubit.get(context).Vispass
                                  ? Icons.visibility_off
                                  : Icons.visibility), () {
                            print(
                                "Visiable : ${AppCubit.get(context).Vispass}");
                            AppCubit.get(context).ChangepasswordVisiability();
                          }),
                          !AppCubit.get(context).Vispass,
                        ),
                        const Divider(
                          thickness: 5,
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Mybutton(
                            label: "حفظ",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                AppCubit.get(context).changePassword(
                                  currentPassword: oldpassword.text,
                                  newPassword: newpassword.text,
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
