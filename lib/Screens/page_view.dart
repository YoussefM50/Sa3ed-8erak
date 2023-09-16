import 'package:final_pro/Screens/splash.dart';
import "package:flutter/material.dart";
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Helper/Share_Pref.dart';
import '../Theme/theme.dart';
import '../imp_func.dart';
import 'LogIn/LogIn.dart';

class pages_v {
  String Img;
  String Title;

  pages_v(this.Img, this.Title);
}

class PageViewScreen extends StatelessWidget {
  PageViewScreen({super.key});
  bool is_last = false;
  var pController = PageController();
  List L_page = [
    pages_v("lib/img/img1.jpg",
        "هذا البرنامج يُستخدم لتمكين المشاركة الفعالة بين الأشخاص"),
    pages_v("lib/img/img2.jpg",
        "الهدف منة مساعدة الأشخاص المحتاجين عن طريق مشاركة معلومات حول احتياجاتهم وطلب المساعدة بطريقة أقل إحراجًا"),
    pages_v("lib/img/img3.jpg",
        "مساعدة المتبرعين في سد احتياج اخرين بطريقة سهلة وآمنة"),
    pages_v("lib/img/img7.jpg", "انضم الينا"),
  ];
  @override
  Widget build(BuildContext context) {
    Widget items(pages_v pv) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(image: AssetImage(pv.Img)),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              pv.Title,
              style: SubHeadingstyle,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        );

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Sharepref.savedata(key: "p_view", value: true);
                go_toAnd_finish(context, MainSplashScreen(LogInSrc()));
              },
              child: Text(
                "تخطي",
                style: Titlestyle.copyWith(color: Colors.green),
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pController,
                onPageChanged: (value) {
                  if (value == L_page.length - 1) {
                    is_last = true;
                    print("last page");
                  } else {
                    is_last = false;
                  }
                },
                itemBuilder: (context, index) => items(L_page[index]),
                itemCount: L_page.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pController,
                    count: L_page.length,
                    effect: const WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: primaryClr,
                    ),
                    onDotClicked: (index) {}),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (is_last) {
                      Sharepref.savedata(key: "p_view", value: true);
                      go_toAnd_finish(context, MainSplashScreen(LogInSrc()));
                    }
                    pController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: const Center(
                      child: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
