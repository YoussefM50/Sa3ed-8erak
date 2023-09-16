// ignore_for_file: file_names, deprecated_member_use
// import 'package:badges/badges.dart' as badges;
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:final_pro/Core/api_service.dart';
import 'package:final_pro/Helper/Share_Pref.dart';
import 'package:final_pro/Screens/homepage/search/search.dart';
import 'package:final_pro/Screens/homepage/tabview/tabview.dart';

import 'package:final_pro/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Cubit/cubit.dart';
import '../../../Cubit/state.dart';
import '../../../imp_func.dart';
import '../../../model/Postmodel.dart';
import '../../../model/cartmodel.dart';

class BlockproviderDescription extends StatelessWidget {
  Post_Model post;
  String postID;
  String page;
  int? counter;
  String id;

  BlockproviderDescription(this.post, this.postID, this.page, this.id,
      {this.counter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getfromcart()
        ..getfromfav()
        // ..getpostbelongtocategory(category: post.category, postID: postID)
        ..getDataFromAPI(postID: postID, API: ApiService(Dio())),
      child: Description(post, postID, page, counter ?? 1, id),
    );
  }
}

class Description extends StatelessWidget {
  Post_Model post;
  String postID;
  int counter;
  String page;
  String id;

  Description(this.post, this.postID, this.page, this.counter, this.id);

  late List imglist;
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (page == "s") {
          go_toAnd_finish(context, BlocProviderSearchScreen());
        } else {
          go_toAnd_finish(context, Blockprovidertabview());
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                if (page == "s") {
                  go_toAnd_finish(context, BlocProviderSearchScreen());
                } else {
                  go_toAnd_finish(context, Blockprovidertabview());
                }
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
              )),
          title: const Text("الوصف"),
        ),
        body: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: const Alignment(0, 0.65),
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text(
                          "صور المنتج",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<AppCubit, AppState>(buildWhen: (p, state) {
                        if (state is ChangeIndecator) {
                          print("ChangeIndecator");
                          return true;
                        } else {
                          return false;
                        }
                      }, builder: (context, state) {
                        imglist = [
                          post.postimage1,
                          post.postimage2,
                          post.postimage3,
                          post.postimage4,
                        ];
                        return Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  initialPage: 0,
                                  onPageChanged: (index, reason) {
                                    currentindex = index;
                                    AppCubit.get(context).Change_Indecator();
                                  },
                                  height: 300,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1),
                                  autoPlayCurve: Curves.linear),
                              items: imglist.map((imageurl) {
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: imageurl,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons
                                                .signal_wifi_statusbar_connected_no_internet_4_sharp),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 10),
                            CarouselIndicator(
                              count: imglist.length,
                              index: currentindex,
                              activeColor: primaryClr,
                              color: Colors.grey,
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0.8, 0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.9)),
                      child: BlocBuilder<AppCubit, AppState>(
                          buildWhen: (p, state) {
                        if (state is getfromfavsuccess) {
                          print("getfromfavsuccess");
                          return true;
                        } else {
                          return false;
                        }
                      }, builder: (context, state) {
                        return Center(
                          child: InkWell(
                            onTap: (() {
                              if (AppCubit.get(context)
                                      .finditeminfavlist(postID) ==
                                  false) {
                                BlocProvider.of<AppCubit>(context)
                                    .addtofav(post: post, PostId: postID);
                              } else {
                                BlocProvider.of<AppCubit>(context)
                                    .removefromFav(postid: postID);
                              }
                            }),
                            child: Icon(
                              (AppCubit.get(context).finditeminfavlist(postID))
                                  ? Icons.favorite
                                  : Icons.favorite_outline_sharp,
                              color: (AppCubit.get(context)
                                      .finditeminfavlist(postID))
                                  ? Colors.red
                                  : white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(10),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(4),
                    1: FlexColumnWidth(2),
                  },
                  textDirection: TextDirection.ltr,
                  border: TableBorder.all(
                      width: 2.0,
                      color: Sharepref.getdata(key: "DarkTheme")
                          ? Colors.white70
                          : Colors.black54,
                      borderRadius: BorderRadius.circular(20)),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          style: TextStyle(
                              color: Sharepref.getdata(key: "DarkTheme")
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w200,
                              fontSize: 15),
                          post.description,
                          textScaleFactor: 2,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                          "الوصف",
                          textScaleFactor: 3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${post.pointsofproduct}",
                            style: TextStyle(
                                color: Sharepref.getdata(key: "DarkTheme")
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            textScaleFactor: 2,
                            textAlign: TextAlign.end),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "النقط",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                          textScaleFactor: 3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(post.category,
                            style: TextStyle(
                                color: Sharepref.getdata(key: "DarkTheme")
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w200,
                                fontSize: 15),
                            textScaleFactor: 2,
                            textAlign: TextAlign.end),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "الصنف",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                          textScaleFactor: 3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${post.numberofproducts}',
                            style: TextStyle(
                                color: Sharepref.getdata(key: "DarkTheme")
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            textScaleFactor: 2,
                            textAlign: TextAlign.end),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "عدد العنصر ",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 8),
                          textScaleFactor: 3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              // BlocBuilder<AppCubit, AppState>(
              //   builder: (context, state) {
              //     if (AppCubit.get(context).Recommended_index.isNotEmpty) {
              //       return Padding(
              //         padding: const EdgeInsets.only(left: 15),
              //         child: SizedBox(
              //           height: 180,
              //           child: ListView.builder(
              //             shrinkWrap: true,
              //             itemBuilder: (context, index) {
              //               return Padding(
              //                 padding: const EdgeInsets.all(5.0),
              //                 child: RecommendedItem(
              //                   AppCubit.get(context)
              //                       .recommend_item[AppCubit.get(context)
              //                           .Recommended_index[index]]
              //                       .postimage1,
              //                   AppCubit.get(context)
              //                       .recommend_item[AppCubit.get(context)
              //                           .Recommended_index[index]]
              //                       .description,
              //                   () {
              //                     go_to(
              //                         context,
              //                         BlockproviderDescription(
              //                             AppCubit.get(context).recommend_item[
              //                                 AppCubit.get(context)
              //                                     .Recommended_index[index]],
              //                             AppCubit.get(context)
              //                                     .recommend_item_ID[
              //                                 AppCubit.get(context)
              //                                     .Recommended_index[index]],
              //                             "D",
              //                             id));
              //                   },
              //                 ),
              //               );
              //             },
              //             // itemCount:
              //             //     AppCubit.get(context).Recommended_index.length,
              //             itemCount: AppCubit.get(context).numofrecommeded,
              //             scrollDirection: Axis.horizontal,
              //             physics: const BouncingScrollPhysics(),
              //           ),
              //         ),
              //       );
              //     } else {
              //       return Container();
              //     }
              //   },
              // ),
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  if (AppCubit.get(context).Rec_AI_Post.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RecommendedItem(
                                AppCubit.get(context).Rec_AI_Post[index].postimage1,
                                AppCubit.get(context)
                                    .Rec_AI_Post[index]
                                    .description,
                                () {
                                  go_to(
                                      context,
                                      BlockproviderDescription(
                                          AppCubit.get(context).Rec_AI_Post[index],
                                          AppCubit.get(context)
                                                  .REC_AI_PostID[index],
                                          "D",
                                          id));
                                },
                              ),
                            );
                          },
                          itemCount: AppCubit.get(context).Rec_AI_Post.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              post.userid != id
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlurryContainer(
                          height: 60,
                          blur: 5,
                          color: primaryClr,
                          child: BlocBuilder<AppCubit, AppState>(
                            builder: (context, state) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (counter > 1) {
                                        counter--;
                                        AppCubit.get(context).minusDes();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    )),
                                Text(
                                  '$counter',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (counter < post.numberofproducts) {
                                        counter++;
                                        AppCubit.get(context).plusDes();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )),
                                TextButton.icon(
                                  onPressed: () {
                                    if (AppCubit.get(context)
                                            .finditemincartlist(postID) ==
                                        false) {
                                      BlocProvider.of<AppCubit>(context)
                                          .addtocart(
                                              post: post,
                                              postid: postID,
                                              mynumofproduct: counter);
                                      showtoast(
                                          "تم الاضافه $counter من العناصر", 1,
                                          gry: ToastGravity.CENTER);
                                    } else {
                                      showtoast("موجود بالفعل", 1,
                                          gry: ToastGravity.CENTER);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    "اضف الي العربة",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

InkWell RecommendedItem(String imageurl, String title, Function Func) {
  return InkWell(
    onTap: () => Func(),
    child: FittedBox(
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Sharepref.getdata(key: "DarkTheme")
                    ? Colors.white60
                    : Colors.black26,
                width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              // child: Image.network(
              //   imageurl,
              //   fit: BoxFit.fill,
              //   height: 120,
              //   width: 140,
              // ),
              child: CachedNetworkImage(
                imageUrl: imageurl,
                fit: BoxFit.fill,
                height: 120,
                width: 140,
                errorWidget: (context, url, error) => const Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4_sharp),
              ),
            ),
            Expanded(
              child: Card(
                  color: Colors.white24,
                  elevation: 3,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "...$title",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ))),
            ),
          ],
        ),
      ),
    ),
  );
}
