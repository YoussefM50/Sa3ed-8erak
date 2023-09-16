import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_pro/Helper/Share_Pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Cubit/cubit.dart';
import '../../../Cubit/state.dart';
import '../../../Theme/theme.dart';
import '../../../model/cartmodel.dart';

class Favscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // if(state is CartFromFavsuccess)
        //   fav = AppCubit.get(context).myfav;
      },
      builder: (context, state) {
        List<Cart_Model> fav = AppCubit.get(context).myfav;
        print(fav);
        return createCartList(fav, context);
      },
    );
  }

  createCartList(List<Cart_Model> fav, context) {
    return RefreshIndicator(
      onRefresh: () async {
        AppCubit.get(context).getfromfav();
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        itemBuilder: (context, position) {
          return createCartListItem(context, position, fav[position]);
        },
        itemCount: fav.length,
      ),
    );
  }

  createCartListItem(BuildContext context, int position, Cart_Model fav) {
    return InkWell(
      onTap: () {
        print("favorite");
        AppCubit.get(context).move_decribtionScreen(
            AppCubit.get(context)
                .allposts[AppCubit.get(context).get_postfrom_fav(fav: fav)],
            AppCubit.get(context)
                .PostsId[AppCubit.get(context).get_postfrom_fav(fav: fav)],
            AppCubit.get(context).usermodel!.id,
            counter: AppCubit.get(context).getnumofitemfromcart(AppCubit.get(
                    context)
                .PostsId[AppCubit.get(context).get_postfrom_fav(fav: fav)]));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 2,
        shadowColor: primaryClr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
                  // decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                  //     color: Colors.blue.shade200,
                  //     image: DecorationImage(
                  //       image: NetworkImage(fav.postimage1),
                  //       fit: BoxFit.fill,
                  //     )),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: fav.postimage1,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fav.category,
                        maxLines: 2,
                        softWrap: true,
                        style: Headingstyle,
                      ),
                      Text(
                        fav.description,
                        style: SubTitlestyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '${fav.pointsofproduct} من النقاط',
                  style: Bodylestyle.copyWith(color: primaryClr),
                ),
                Text(
                  'يوجد ${fav.numberofproducts} عناصر',
                  style: Sharepref.getdata(key: "DarkTheme")
                      ? Body2lestyle.copyWith(color: Colors.white)
                      : Body2lestyle.copyWith(color: Colors.black),
                ),
                IconButton(
                    tooltip: 'حذف',
                    onPressed: () {
                      AppCubit.get(context).removefromFav(
                          FavId: AppCubit.get(context).myfavId[position],
                          fav: fav);
                    },
                    icon: const Icon(
                      Icons.sentiment_dissatisfied,
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
