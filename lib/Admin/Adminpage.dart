import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_pro/Admin/admin_cubit.dart';
import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Theme/appmode_cubit.dart';
import 'package:final_pro/Theme/theme.dart';
import 'package:final_pro/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/botton.dart';

class BlocProviderAdminscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..getallorders(),
      child: Adminscreen(),
    );
  }
}

class Adminscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: const Text(
          "الطلابات",
        ),
        centerTitle: true,
        leading: BlocBuilder<AdminCubit, AdminState>(
            buildWhen: (p, state) => state is Adminchangemodesuccess,
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<AdminCubit>(context).Adminchangemode(
                        BlocProvider.of<AppmodeCubit>(context));
                  },
                  icon: BlocProvider.of<AppmodeCubit>(context).IsDark
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.mode_night_outlined));
            }),
      ),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is Admingetallordersfailure) {
            print(state.error);
          } else if (state is Admindeleteorderfailure) {
            print(state.error);
          }
        },
        buildWhen: (p, state) {
          if (state is Adminloading) {
            return true;
          } else if (state is Admingetallorderssuccess ||
              state is Admindeleteordersuccess) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          print(state);
          if (state is Adminloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Order_Model> orders =
                BlocProvider.of<AdminCubit>(context).orders;
            List<String> ordersid =
                BlocProvider.of<AdminCubit>(context).ordersId;
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: OutlinedButton(
                              onPressed: () {
                                BlocProvider.of<AdminCubit>(context)
                                    .logout(context);
                              },
                              child: const Text(
                                "Log Out",
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                        SizedBox(
                          width: 200.0,
                          height: 50.0,
                          child: OutlinedButton(
                              onPressed: () {
                                print("Update Point To All User");
                                BlocProvider.of<AdminCubit>(context)
                                    .update_point_to_alluser(context);
                              },
                              child: const Text(
                                "Update Point To All User",
                                textAlign: TextAlign.end,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 5),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        print("orders");
                        orders = BlocProvider.of<AdminCubit>(context).orders;
                        ordersid =
                            BlocProvider.of<AdminCubit>(context).ordersId;
                        print(orders);
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => createorderListItem(
                            context, orders[index], ordersid[index]),
                        itemCount: orders.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  createorderListItem(BuildContext context, Order_Model order, String orderid) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.greenAccent.withOpacity(0.4), width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
                // decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                //     color: Colors.blue.shade200,
                //     image: DecorationImage(
                //       //img1
                //       image: NetworkImage(order.postimage1),
                //       fit: BoxFit.cover,
                //     )),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: order.postimage1,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(Icons
                        .signal_wifi_statusbar_connected_no_internet_4_sharp),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //description
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        order.description,
                        style: SubTitlestyle,
                        maxLines: 5,
                      ),
                    ),
                    //number of product
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        "${order.numberofproducts}",
                        style: SubTitlestyle,
                      ),
                    ),
                    //date
                    items(context, "التاريخ : ", order.time.substring(0, 16)),
                  ],
                ),
              ),
            ],
          ),
          Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.greenAccent.withOpacity(0.4)),
          Row(
            children: [
              Text(
                "المتبرع :     ",
                style: Titlestyle,
              ),
              Column(
                children: [
                  items(context, "الاسم : ", order.donorname),
                  items(context, "رقم التليفون : ", order.donornumber),
                  items(context, "العنوان : ", order.donoraddress),
                ],
              )
            ],
          ),
          Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.greenAccent.withOpacity(0.4)),
          Row(
            children: [
              Text(
                "المتبرع لة  ",
                style: Titlestyle,
              ),
              Column(
                children: [
                  items(context, "الاسم : ", order.inneedname),
                  items(context, "رقم التليفون : ", order.inneednumber),
                  items(context, "العنوان : ", order.inneedaddress),
                ],
              )
            ],
          ),
          Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.greenAccent.withOpacity(0.4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("تم توصيل الطلب بنجاح"),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<AdminCubit>(context).deleteorder(orderid);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ))
            ],
          ),
        ],
      ),
    );
  }

  items(context, String title, subtitle) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.8,
      child: ListTile(
        title: Text(
          "${title}",
        ),
        subtitle: Text(
          "${subtitle}",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
