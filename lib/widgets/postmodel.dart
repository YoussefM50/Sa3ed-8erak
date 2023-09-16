import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Cubit/state.dart';
import 'package:final_pro/Screens/homepage/description/Description.dart';
import 'package:final_pro/Theme/theme.dart';
import 'package:final_pro/imp_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Directionality postmodel(context, postID, post, {index = 0}) {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          AppCubit.get(context).move_decribtionScreen(
              post, postID, AppCubit.get(context).usermodel!.id,
              counter: AppCubit.get(context).getnumofitemfromcart(postID));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        index % 2 == 0 ? kProfilePhoto : kProfilePhoto2,
                        fit: BoxFit.fill,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.username,
                              style: Body2lestyle,
                            ),
                            const Icon(
                              Icons.check_circle_sharp,
                              color: primaryClr,
                              size: 20,
                            )
                          ],
                        ),
                        Text(
                          '${post.time.substring(0, 10)} ${post.time.substring(10, 16)}',
                          style:
                              const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              // color: Colors.white,
              child: Text(
                post.category,
                style: Titlestyle,
              ),
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 10,
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius:
              //         const BorderRadius.vertical(top: Radius.circular(10)),
              //     image: DecorationImage(
              //       image: NetworkImage(post.postimage1),
              //       fit: BoxFit.fill,
              //     )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: post.postimage1,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  errorWidget: (context, url, error) => const Icon(Icons
                      .signal_wifi_statusbar_connected_no_internet_4_sharp),
                ),
              ),
            ),
            Card(
                elevation: 4,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    post.userid != AppCubit.get(context).usermodel!.id
                        ? Expanded(
                            child: SizedBox(
                              height: 50,
                              child: InkWell(
                                  onTap: () {
                                    // BlocProvider.of<AppCubit>(context)
                                    //     .addtofav(post);
                                    if (AppCubit.get(context)
                                        .finditemincartlist(postID)) {
                                      BlocProvider.of<AppCubit>(context)
                                          .removefromcart(postid: postID);
                                    } else {
                                      BlocProvider.of<AppCubit>(context)
                                          .addtocart(
                                              post: post, postid: postID);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //problem cart
                                        child: (AppCubit.get(context)
                                                    .finditemincartlist(
                                                        postID) ==
                                                false)
                                            ? const Icon(
                                                // Icons.star_outline_outlined,
                                                // color: Colors.amberAccent,
                                                Icons.add_shopping_cart_sharp,
                                                color: Colors.amberAccent,
                                              )
                                            : const Icon(
                                                // Icons.star_outline_outlined,
                                                // color: Colors.amberAccent,
                                                Icons.shopping_cart,
                                                color: Colors.amberAccent,
                                              ),
                                      ),
                                      Text(
                                        //problem cart
                                        (AppCubit.get(context)
                                                    .finditemincartlist(
                                                        postID) ==
                                                false)
                                            ? "اضف الي العربة"
                                            : "ازل من العربة ",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      )
                                    ],
                                  )),
                            ),
                          )
                        : Container(), //may add remove post here
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: InkWell(
                            onTap: () {
                              //problem fav
                              if (AppCubit.get(context)
                                      .finditeminfavlist(postID) ==
                                  false) {
                                BlocProvider.of<AppCubit>(context)
                                    .addtofav(post: post, PostId: postID);
                              } else {
                                BlocProvider.of<AppCubit>(context)
                                    .removefromFav(postid: postID);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  //problem fav
                                  child: (AppCubit.get(context)
                                              .finditeminfavlist(postID) ==
                                          false)
                                      ? const Icon(
                                          // Icons.add_shopping_cart_sharp,
                                          // color: Colors.amberAccent,
                                          Icons.star_outline_outlined,
                                          color: Colors.redAccent,
                                        )
                                      : const Icon(
                                          // Icons.add_shopping_cart_sharp,
                                          // color: Colors.amberAccent,
                                          Icons.star,
                                          color: Colors.redAccent,
                                        ),
                                ),
                                Text(
                                  (AppCubit.get(context)
                                              .finditeminfavlist(postID) ==
                                          false)
                                      ? "اضف الي المفضلة"
                                      : "ازل من المفضلة ",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ));
}
