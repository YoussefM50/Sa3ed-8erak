// ignore_for_file: deprecated_member_use
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_pro/Helper/Share_Pref.dart';
import 'package:final_pro/Screens/homepage/home/home.dart';
import 'package:final_pro/Screens/homepage/home_no_internet/NoInternetHome.dart';
import 'package:final_pro/Theme/theme.dart';
import 'package:final_pro/imp_func.dart';
import 'package:final_pro/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Cubit/cubit.dart';
import '../../../Cubit/state.dart';
import '../../../model/cartmodel.dart';


class Cart_screen extends StatelessWidget {
  int totalpoint = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          // List<Cart_Model> carts = AppCubit.get(context).mycart;
          // print(carts);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Builder(
              builder: (context) {
                totalpoint = 0;
                for (int i = 0; i < AppCubit.get(context).mycart.length; i++) {
                  totalpoint += (AppCubit.get(context).numofproduct[i]! *
                      AppCubit.get(context).mycart[i].pointsofproduct);
                  print(totalpoint);
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    AppCubit.get(context).getfromcart();
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    children: [
                      createHeader(),
                      createSubTitle(AppCubit.get(context).mycart),
                      createCartList(AppCubit.get(context).mycart),
                      footer(context, AppCubit.get(context).mycart)
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  footer(BuildContext context, List<Cart_Model> carts) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                " اجمالي النقط : ",
                style: SubHeadingstyle,
              ),
              Text(
                " $totalpoint",
                style: (totalpoint <= AppCubit.get(context).usermodel!.point)
                    ? Headingstyle.copyWith(color: primaryClr)
                    : Headingstyle.copyWith(color: Colors.red),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Utils.getSizedBox(height: 8),
          Mybutton(
              label: "تأكيد الطلب",
              onTap: () {
                if (carts.isNotEmpty) {
                  if (totalpoint <= AppCubit.get(context).usermodel!.point) {
                    //confirm number of items
                    AppCubit.get(context).buythisitems(totalpoint);
                    showtoast("تم التأكيد 👌", 1, gry: ToastGravity.TOP);
                    // go_to(context,const Order_Done());
                  } else {
                    showtoast("ليس لديك عدد كافي من النقط 😞", 2,
                        gry: ToastGravity.TOP);
                  }
                } else {
                  showtoast("العربة فارغة😊", 2, gry: ToastGravity.TOP);
                }
              }),
          const SizedBox(
            height: 50,
          )
          //  Utils.getSizedBox(height: 8),
        ],
      ),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(right: 12, top: 12),
      // ignore: prefer_const_constructors
      child: Text(
        "عربة التسوق",
        style: Headingstyle,
      ),
    );
  }

  createSubTitle(List<Cart_Model> carts) {
    return Container(
      alignment: Alignment.topRight,
      // ignore: sort_child_properties_last
      child: Text(
        " عدد المنتجات ${carts.length}",
        style: Bodylestyle.copyWith(color: primaryClr),
      ),
      margin: const EdgeInsets.only(right: 12, top: 4),
    );
  }

  createCartList(List<Cart_Model> carts) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(
            context, position, carts.length, carts[position]);
      },
      itemCount: carts.length,
    );
  }

  createCartListItem(
      BuildContext context, int position, carts_len, Cart_Model cart) {
    return InkWell(
      onTap: () {
        print(position);
        AppCubit.get(context).move_decribtionScreen(
            AppCubit.get(context)
                .allposts[AppCubit.get(context).get_postfrom_fav(fav: cart)],
            AppCubit.get(context).usermodel!.id,
            AppCubit.get(context)
                .PostsId[AppCubit.get(context).get_postfrom_fav(fav: cart)],
            counter: AppCubit.get(context).numofproduct[position]!);
      },
      child: Card(
        shadowColor: primaryClr,
        elevation: 2,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
                  // decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.all(Radius.circular(10)),
                  //     color: Colors.blue.shade200,
                  //     image: DecorationImage(
                  //       image: NetworkImage(cart.postimage1),
                  //       fit: BoxFit.fill,
                  //     )),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: cart.postimage1,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      errorWidget: (context, url, error) => const Icon(Icons
                          .signal_wifi_statusbar_connected_no_internet_4_sharp),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.category,
                        maxLines: 1,
                        softWrap: true,
                        style: Headingstyle,
                      ),
                      Text(
                        cart.description,
                        style: SubTitlestyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '${cart.pointsofproduct} من النقاط',
                  style: Bodylestyle.copyWith(color: primaryClr),
                ),
                IconButton(
                    onPressed: () {
                      if (AppCubit.get(context).numofproduct[position]! > 1) {
                        AppCubit.get(context).minus(index: position);
                      } else {
                        AppCubit.get(context).removefromcart(
                            CartId: AppCubit.get(context).mycartId[position],
                            cart: cart);
                      }
                    },
                    icon: const Icon(Icons.remove)),
                Text(
                  '${AppCubit.get(context).numofproduct[position]}',
                  style: Body2lestyle.copyWith(color: primaryClr),
                ),
                IconButton(
                    onPressed: () {
                      if (AppCubit.get(context).numofproduct[position]! <
                          cart.numberofproducts) {
                        AppCubit.get(context).plus(index: position);
                      }
                    },
                    icon: const Icon(Icons.add)),
                IconButton(
                    tooltip: 'حذف',
                    onPressed: () {
                      for (int i = 0; i < carts_len; i++) {
                        AppCubit.get(context).updatepointforcart(
                            AppCubit.get(context).numofproduct[i]!,
                            AppCubit.get(context).mycartId[i]);
                      }
                      AppCubit.get(context).removefromcart(
                          CartId: AppCubit.get(context).mycartId[position],
                          cart: cart);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
