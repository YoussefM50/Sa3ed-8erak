// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_pro/Helper/Share_Pref.dart';
import 'package:final_pro/Screens/homepage/description/Description.dart';
import 'package:final_pro/Screens/homepage/home_no_internet/NoInternetHome.dart';
import 'package:final_pro/Screens/homepage/search/search.dart';
import 'package:final_pro/Theme/appmode_cubit.dart';
import 'package:final_pro/Theme/theme.dart';
import 'package:final_pro/imp_func.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../Cubit/cubit.dart';
import '../../../Cubit/state.dart';
import '../../LogIn/LogIn.dart';

class Blockprovidertabview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..GetUserData()
        ..getallposts(),
      child: tabview(),
    );
  }
}

class tabview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.ethernet) {
          if (state is ChangeScreen) {
            go_to(
                context,
                BlockproviderDescription(
                    state.post, state.postID, "t", state.UsertID,
                    counter: state.counter));
          } else if (state is SocialSuccessLogOutState) {
            go_toAnd_finish(context, LogInSrc());
          } else if (state is gotoSearchScreen) {
            AppCubit.get(context).SearchList = [];
            AppCubit.get(context).SearchListID = [];
            go_to(context, BlocProviderSearchScreen());
          } else if (state is deleteemailsuccess) {
            go_toAnd_finish(context, LogInSrc());
          } else if (state is removepostsuccess) {
            AppCubit.get(context).getmypost();
          } 
        } else {
          go_toAnd_finish(context, const NoInternet());
        }
      },
      buildWhen: (p, state) {
        if (state is Tabviewsuccess ||
            state is Tabviewloading ||
            state is Appchangemodesuccess) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is Tabviewloading) {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        } else {
          return mainscreen(context);
        }
      },
    );
  }

  List<PersistentBottomNavBarItem> navBarsItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.cart),
      title: ("العربة"),
      textStyle: const TextStyle(fontSize: 13),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.profile_circled),
      title: ("الملف الشخصي"),
      textStyle: const TextStyle(fontSize: 11),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      textStyle: const TextStyle(fontSize: 12),
      icon: const Icon(
        CupertinoIcons.home,
        color: Colors.white,
      ),
      title: ("الصفحة الرئيسية"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.activeGreen,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.upload_circle),
      title: ("اضافة منتج"),
      textStyle: const TextStyle(fontSize: 11),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.square_favorites_alt),
      title: ("المفضلات "),
      textStyle: const TextStyle(fontSize: 13),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];

  Scaffold mainscreen(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1.5,
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<AppCubit>(context)
                    .Appchangemode(BlocProvider.of<AppmodeCubit>(context));
              },
              icon: AppmodeCubit.get(context).IsDark
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.mode_night_outlined)),
          title: Text(
            AppCubit.get(context).title,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {
                  print("Go To Search Screen");
                  AppCubit.get(context).go_toSearchScreen();
                },
              ),
            ),
          ],
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: PersistentTabView(
            context,
            controller: BlocProvider.of<AppCubit>(context).controller,
            onItemSelected: (index) {
              BlocProvider.of<AppCubit>(context)
                  .change_screen(PersistentTabController(initialIndex: index));
            },
            screens: BlocProvider.of<AppCubit>(context).screens,
            items: navBarsItems,
            confineInSafeArea: true,
            backgroundColor:
                AppmodeCubit.get(context).IsDark ? darkGreyClr : lightgray,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar:
                  AppmodeCubit.get(context).IsDark ? darkGreyClr : lightgray,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style15, // Choose the nav bar style with this property.
          ),
        ));
  }
}
