import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Cubit/cubit.dart';
import '../../../Cubit/state.dart';
import '../../../model/Postmodel.dart';
import '../../../widgets/postmodel.dart';

class homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        if (state is getpostsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ConditionalBuilder(
            condition: AppCubit.get(context).allposts.isNotEmpty,
            builder: (context) {
              List<Post_Model> postinhomescreen =
                  AppCubit.get(context).allposts;
              List<String> postinhomeid = AppCubit.get(context).PostsId;
              if (AppCubit.get(context).homecategory == "كتب") {
                postinhomescreen = AppCubit.get(context).books;
                postinhomeid = AppCubit.get(context).booksId;
              } else if (AppCubit.get(context).homecategory == "ادوات مدرسية") {
                postinhomescreen = AppCubit.get(context).school;
                postinhomeid = AppCubit.get(context).schoolId;
              } else if (AppCubit.get(context).homecategory == "ادوات منزلية") {
                postinhomescreen = AppCubit.get(context).home;
                postinhomeid = AppCubit.get(context).homeId;
              } else if (AppCubit.get(context).homecategory == "ملابس") {
                postinhomescreen = AppCubit.get(context).clothes;
                postinhomeid = AppCubit.get(context).clothesId;
              } else if (AppCubit.get(context).homecategory == "اثاث") {
                postinhomescreen = AppCubit.get(context).furniture;
                postinhomeid = AppCubit.get(context).furnitureId;
              } else if (AppCubit.get(context).homecategory ==
                  "اجهزة كهربائية") {
                postinhomescreen = AppCubit.get(context).electrical_devices;
                postinhomeid = AppCubit.get(context).electrical_devicesId;
              } else if (AppCubit.get(context).homecategory == "اخري") {
                postinhomescreen = AppCubit.get(context).others;
                postinhomeid = AppCubit.get(context).othersId;
              }

              return postbody(context, postinhomescreen.length,
                  postinhomescreen, postinhomeid);
            },
            fallback: (context) => const Center(
              child: Text("لا يوجد اي منتجات لعرضها"),
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is getpostsfailure) {
          print(state.error);
        }
      },
    );
  }
}

postbody(context, len, posts, postsid) {
  return RefreshIndicator(
    onRefresh: () async {
      AppCubit.get(context).getallposts();
    },
    child: CustomScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverAppBar(
          floating: true,
          expandedHeight: 120.0,
          flexibleSpace: categories(),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return postmodel(context, postsid[index], posts[index], index: index);
        }, childCount: len)),
      ],
    ),
  );
}

ListView categories() {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => categoriesitem(index, context),
    itemCount: listofcategories.length,
  );
}

List<String> listofcategories = [
  'الكل',
  'كتب',
  'ادوات مدرسية',
  'ادوات منزلية',
  'ملابس',
  'اثاث',
  'اجهزة كهربائية',
  'اخري'
];
List<String> listofimage = [
  "https://img.freepik.com/free-vector/hand-drawn-world-kindness-day-illustration_52683-95835.jpg",
  "https://img.freepik.com/free-photo/pile-paperback-books-table_93675-129054.jpg?w=740&t=st=1677686855~exp=1677687455~hmac=9952217de70dcf6465210fc0f6ded4ea213939bdfc0e9dc9f9aa30acd37c6ca4",
  "https://img.freepik.com/premium-photo/back-school-supplies-accessories_200402-3973.jpg?w=740",
  "https://img.freepik.com/free-photo/flat-lay-wooden-kitchen-tools-arrangement_23-2149552373.jpg?w=740&t=st=1677687528~exp=1677688128~hmac=d67121fee2d7905f4c47b38ff8dea7951a185dbb0b3d67390009397cd817245b",
  "https://img.freepik.com/premium-photo/close-up-colorful-t-shirts-hangers_51195-3880.jpg?w=740",
  "https://img.freepik.com/premium-photo/brown-sofa-wooden-table-living-room-interior-with-plant-concrete-wall_41470-3721.jpg?w=740",
  "https://img.freepik.com/premium-photo/household-appliances-set-white-background-3d-rendering_476612-10966.jpg?w=740",
  "https://img.freepik.com/free-photo/love-concept-represented-by-hands-extended-each-other_1098-18923.jpg?w=740&t=st=1677688000~exp=1677688600~hmac=d0793161f14e5f7c7dd258c6737701cfc20809db96179c4b02636da680c3bea0",
];

Widget categoriesitem(int index, context) {
  return InkWell(
    onTap: () {
      AppCubit.get(context)
          .homeselectedCategory(AppCubit.get(context).homerepeatList[index]);
    },
    child: FittedBox(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: 100,
        height: MediaQuery.of(context).size.height / 6,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Column(
          children: [
            SizedBox(
              width: 80,
              height: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: CachedNetworkImage(
                  imageUrl: listofimage[index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                  errorWidget: (context, url, error) => const Icon(Icons
                      .signal_wifi_statusbar_connected_no_internet_4_sharp),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(listofcategories[index]),
          ],
        ),
      ),
    ),
  );
}
