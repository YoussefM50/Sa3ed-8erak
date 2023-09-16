import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Screens/homepage/description/Description.dart';
import 'package:final_pro/imp_func.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Theme/theme.dart';
import '../../../../model/Postmodel.dart';
import '../../search/searchItem.dart';

Widget mypostItem(Post_Model post, String postID, context) {
  return Stack(
    children: [
      Container(
        padding: const EdgeInsets.all(2),
        height: 300,
        decoration: BoxDecoration(
            border: Border.all(color: primaryClr),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  imageitem(img: post.postimage1, LR: "R"),
                  imageitem(img: post.postimage2),
                  imageitem(img: post.postimage3),
                  imageitem(img: post.postimage4, LR: "L"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.category,
                    style: SubHeadingstyle.copyWith(color: primaryClr),
                  ),
                  Text(
                    post.description,
                    style: Body2lestyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      IconButton(
          onPressed: () {
            print("Cancel");
            AppCubit.get(context).removepost(PostID: postID);
          },
          icon: const Icon(
            Icons.cancel,
            size: 35,
            color: Colors.red,
          ))
    ],
  );
}
