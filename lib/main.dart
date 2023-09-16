import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_pro/Admin/Adminpage.dart';
import 'package:final_pro/Screens/homepage/home_no_internet/NoInternetHome.dart';
import 'package:final_pro/Theme/appmode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Helper/Share_Pref.dart';
import 'Screens/LogIn/LogIn.dart';
import 'Screens/homepage/tabview/tabview.dart';
import 'Screens/page_view.dart';
import 'Screens/splash.dart';
import 'Theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'imp_func.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  await Sharepref.init();
  var p_view = Sharepref.getdata(key: "p_view");
  //Sharepref.Deletedata(key:  "UID");
  UID = Sharepref.getdata(key: "UID");
  final connectivityResult = await (Connectivity().checkConnectivity());
  print(UID);
  IsDark = Sharepref.getdata(key: "DarkTheme");
  if (IsDark == null) {
    Sharepref.savedata(key: "DarkTheme", value: false);
    IsDark = Sharepref.getdata(key: "DarkTheme");
  }
  Widget S_page;
  if (connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.ethernet) {
    print("WI_FI");
    if (p_view == null) {
      S_page = PageViewScreen();
    } else {
      if (UID == null) {
        S_page = MainSplashScreen(LogInSrc());
      } else if (UID == "fU7m4HlpLXOq8Dx8W6YyzXjANDg2") {
        S_page = MainSplashScreen(BlocProviderAdminscreen());
      } else {
        S_page = MainSplashScreen(Blockprovidertabview());
      }
    }
  } else {
    S_page = const NoInternet();
  }
  runApp(BlockproviderMyapp(Start_Screen: S_page, IsDark: IsDark));
}

class BlockproviderMyapp extends StatelessWidget {
  Widget Start_Screen;
  var IsDark;
  BlockproviderMyapp({required this.Start_Screen, this.IsDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppmodeCubit(),
      child: MyApp(Start_Screen: Start_Screen, IsDark: IsDark),
    );
  }
}

class MyApp extends StatelessWidget {
  Widget Start_Screen;
  var IsDark;

  MyApp({required this.Start_Screen, this.IsDark});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppmodeCubit, AppmodeState>(builder: (context, state) {
      print("material app state");
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode:
            AppmodeCubit.get(context).IsDark ? ThemeMode.dark : ThemeMode.light,
        home: Directionality(
            textDirection: TextDirection.rtl, child: Start_Screen),
      );
    });
  }
}
