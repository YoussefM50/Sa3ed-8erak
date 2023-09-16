import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Cubit/state.dart';
import 'package:final_pro/imp_func.dart';
import 'package:final_pro/widgets/botton.dart';
import 'package:final_pro/widgets/text_field.dart';
import 'package:final_pro/widgets/toastbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Deleteprofile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1.5,
        title: const Text(
          "الغاء الحساب",
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is deleteemailfailure) {
          mytoastbar(text: state.error, context: context);
        }
      }, builder: (context, state) {
        // password = TextEditingController();
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
                        const SizedBox(
                          height: .5,
                        ),
                        TEXTFIELD(
                          password,
                          TextInputType.visiblePassword,
                          "كلمة السر",
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
                            label: "تاكيد",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                AppCubit.get(context)
                                    .deleteemail(password.text);
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
