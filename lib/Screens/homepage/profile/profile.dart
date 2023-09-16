import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Cubit/state.dart';
import 'package:final_pro/Helper/Share_Pref.dart';
import 'package:final_pro/Theme/theme.dart';
import 'package:final_pro/imp_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Theme/appmode_cubit.dart';
import '../../../widgets/ListTile.dart';
import '../../../widgets/postmodel.dart';
import '../search/searchItem.dart';
import 'Widget/myPost.dart';
import 'Widget/profileButton.dart';
import 'deletprofile.dart';
import 'editpassword.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  var lightprofile = LinearGradient(begin: Alignment.bottomRight, stops: const [
    0.3,
    0.7
  ], colors: [
    primaryClr.withOpacity(.8),
    Colors.white.withOpacity(.8),
  ]);
  var darkprofile = LinearGradient(begin: Alignment.bottomRight, stops: const [
    0.2,
    0.8
  ], colors: [
    Colors.black.withOpacity(.8),
    darkHeaderClr,
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          BlocBuilder<AppmodeCubit, AppmodeState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                    gradient: AppmodeCubit.get(context).IsDark
                        ? darkprofile
                        : lightprofile),
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 80,
                          child: CachedNetworkImage(imageUrl: kProfilePhoto),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "${AppCubit.get(context).usermodel!.Fname} ${AppCubit.get(context).usermodel!.Lname}",
                                style: Titlestyle.copyWith(
                                    fontSize: 20,
                                    color: Sharepref.getdata(key: "DarkTheme")
                                        ? white
                                        : darkGreyClr),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Flexible(
                                child: Text(
                              " عدد نقاطك :${AppCubit.get(context).usermodel!.point} نقاط",
                              style: SubHeadingstyle.copyWith(
                                  fontSize: 23,
                                  color: Sharepref.getdata(key: "DarkTheme")
                                      ? white
                                      : darkGreyClr),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  AppCubit.get(context).getmypost();
                },
                child: ListView(
                  padding:
                      const EdgeInsets.only(bottom: 30, left: 10, right: 8),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ExpansionTile(
                      leading: const Icon(Icons.person),
                      title: const Text("البيانات الشخصيه"),
                      children: [
                        const Divider(
                          thickness: 2,
                        ),
                        MYLISTtile(
                            label: "الأسم",
                            sublabel:
                                "${AppCubit.get(context).usermodel!.Fname} ${AppCubit.get(context).usermodel!.Lname}",
                            ontap: () {}),
                        MYLISTtile(
                            label: "العنوان",
                            sublabel: AppCubit.get(context).usermodel!.address,
                            ontap: () {}),
                        MYLISTtile(
                            label: "رقم الهاتف",
                            sublabel:
                                AppCubit.get(context).usermodel!.phonenumber,
                            ontap: () {}),
                        MYLISTtile(
                            label: "البريد الالكتروني",
                            sublabel: AppCubit.get(context).usermodel!.email,
                            ontap: () {}),
                      ],
                    ),
                    Text(
                      "تبرعاتي",
                      style: Titlestyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //list from Posts
                    ConditionalBuilder(
                      condition: AppCubit.get(context).UserPost.isNotEmpty,
                      builder: (context) {
                        return BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => mypostItem(
                                  AppCubit.get(context).UserPost[index],
                                  AppCubit.get(context).UserPostID[index],
                                  context),
                              itemCount: AppCubit.get(context).UserPost.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                            );
                          },
                        );
                      },
                      fallback: (context) {
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        go_to(context, BlocProviderEditpassword());
                      },
                      child: buttoncontainer("تغير كلمة السر"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        go_to(context, Deleteprofile());
                      },
                      child: buttoncontainer("الغاء الحساب"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        AppCubit.get(context).logout();
                      },
                      child: buttoncontainer("تسجيل الخروج"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
