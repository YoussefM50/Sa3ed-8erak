import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Screens/homepage/description/Description.dart';
import 'package:final_pro/imp_func.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Theme/theme.dart';
import '../../../model/Postmodel.dart';

Widget imageitem({required String img, String? LR}) {
  if (LR == 'R') {
    return Expanded(
        child: ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
      child: CachedNetworkImage(
        imageUrl: img,
        fit: BoxFit.cover,
        height: 150,
        errorWidget: (context, url, error) => const Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4_sharp),
      ),
    ));
  } else if (LR == "L") {
    return Expanded(
        child: ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
      child: CachedNetworkImage(
        imageUrl: img,
        fit: BoxFit.cover,
        height: 150,
        errorWidget: (context, url, error) => const Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4_sharp),
      ),
    ));
  } else {
    return Expanded(
        child: CachedNetworkImage(
      imageUrl: img,
      fit: BoxFit.cover,
      height: 150,
      errorWidget: (context, url, error) =>
          const Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_sharp),
    ));
  }
}

Widget searchItems(Post_Model post, String postID, context) {
  return InkWell(
    onTap: () {
      go_to(
          context,
          BlockproviderDescription(
            post,
            postID,
            "s",
            AppCubit.get(context).usermodel!.id,
            counter: AppCubit.get(context).getnumofitemfromcart(postID),
          ));
    },
    child: Container(
      padding: const EdgeInsets.all(2),
      height: 300,
      decoration: BoxDecoration(
          border: Border.all(color: primaryClr),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageitem(img: post.postimage1, LR: "L"),
                    imageitem(img: post.postimage2),
                    imageitem(img: post.postimage3),
                    imageitem(img: post.postimage4, LR: "R"),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                ' ${post.numberofproducts}',
                                style: Titlestyle.copyWith(color: primaryClr),
                              ),
                              Text(
                                ' : العدد الكلي   ',
                                style: SubTitlestyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                ' ${post.pointsofproduct}',
                                style: Titlestyle.copyWith(color: primaryClr),
                              ),
                              Text(
                                " : تكلفة العنصر",
                                style: SubTitlestyle,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "المفضلات",
                                    style: Body2lestyle,
                                  ),
                                  //problem fav
                                  (AppCubit.get(context)
                                          .finditeminfavlist(postID))
                                      ? const Icon(
                                          Icons.done_outline,
                                          size: 15,
                                          color: primaryClr,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Colors.red,
                                        )
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "العربة",
                                    style: Body2lestyle,
                                  ),
                                  //problem
                                  (AppCubit.get(context)
                                          .finditemincartlist(postID))
                                      ? const Icon(
                                          Icons.done_outline,
                                          size: 15,
                                          color: primaryClr,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Colors.red,
                                        )
                                ],
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Text(
                            post.category,
                            style: Headingstyle.copyWith(color: primaryClr),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            post.description,
                            style: SubTitlestyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          (post.available == true)
              ? RotationTransition(
                  turns: const AlwaysStoppedAnimation(30 / 360),
                  child: Container(
                      decoration: BoxDecoration(
                          color: primaryClr.withOpacity(.9),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("متاح"),
                      )),
                )
              : const SizedBox(
                  height: 10,
                ),
        ],
      ),
    ),
  );
}
