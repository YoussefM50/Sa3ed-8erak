import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_pro/imp_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../Admin/Adminpage.dart';
import '../../../Theme/theme.dart';
import '../../LogIn/LogIn.dart';
import '../../splash.dart';
import '../profile/Widget/profileButton.dart';
import '../tabview/tabview.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: primaryClr,
        onRefresh: () async {
          await Check_internet(context);
        },
        child: ListView(
          children: [
            SizedBox(
              height: mediaquery(context).height / 6,
            ),
            const Image(image: AssetImage("lib/img/img6.jpg")),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "هناك مشكلة في الإنترنت",
                    style: Headingstyle.copyWith(color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> Check_internet(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.ethernet) {
      if (UID == null) {
        if (context.mounted) {
          go_toAnd_finish(context, MainSplashScreen(LogInSrc()));
        }
      } else if (UID == "fU7m4HlpLXOq8Dx8W6YyzXjANDg2") {
        if (context.mounted) {
          go_toAnd_finish(context, MainSplashScreen(BlocProviderAdminscreen()));
        }
      } else {
        if (context.mounted) {
          go_toAnd_finish(context, MainSplashScreen(Blockprovidertabview()));
        }
      }
    } else {
      showtoast("😴برجاء فحص الانترنت", 2);
    }
  }
}
