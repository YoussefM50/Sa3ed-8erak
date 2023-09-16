import 'package:final_pro/Screens/LogIn/LogIn.dart';
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

class resetpassword extends StatelessWidget {
  var id = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LogInCubit(),
        child: BlocConsumer<LogInCubit, LogInstate>(
          listener: (context, state) {
            if (state is SocialResetPassErrorState) {
              print(state.error);
              showtoast("هناك مشكلة", 2);
            } else if (state is SocialResetPassSuccState) {
              go_toAnd_finish(context, LogInSrc());
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
                              height: 50,
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
                              height: 20,
                            ),
                            Mybutton(
                                label: "تسجيل الدخول",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    LogInCubit.get(context)
                                        .resetpassword(Email: id.text);
                                  }
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
}
