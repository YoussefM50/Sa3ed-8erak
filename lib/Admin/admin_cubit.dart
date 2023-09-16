import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Screens/LogIn/LogIn.dart';
import 'package:final_pro/imp_func.dart';
import 'package:final_pro/model/order_model.dart';

import '../Cubit/cubit.dart';
import '../Helper/Share_Pref.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  //get all orders
  List<Order_Model> orders = [];
  List<String> ordersId = [];
  getallorders() {
    emit(Adminloading());
    orders = [];
    ordersId = [];
    FirebaseFirestore.instance.collection('Admin_Orders').get().then((value) {
      if (value.docs.length > 0) {
        value.docs.forEach((element) {
          Order_Model order = Order_Model.fromJson(element.data());
          orders.add(order);
          ordersId.add(element.id);
        });
      }
      emit(Admingetallorderssuccess());
    }).catchError((error) {
      emit(Admingetallordersfailure(error.toString()));
    });
  }

  //delete order
  deleteorder(String orderid) {
    FirebaseFirestore.instance
        .collection('Admin_Orders')
        .doc(orderid)
        .delete()
        .then((value) {
      getallorders();
      emit(Admindeleteordersuccess());
    }).catchError((error) {
      emit(Admindeleteorderfailure(error.toString()));
    });
  }

  Adminchangemode(var line) {
    line.ChangeMode();
    emit(Adminchangemodesuccess());
  }

  void logout(context) {
    Sharepref.Deletedata(key: 'UID').then((value) {
      go_toAnd_finish(context, LogInSrc());
      emit(SocialSuccessLogOutState());
    });
  }

  update_point_to_alluser(context) {
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        print(element.id);
        FirebaseFirestore.instance
            .collection('Users')
            .doc(element.id)
            .update({"point": 30}).then((value) {
          emit(updatePointsuccess());
        }).catchError((Error) {
          emit(updatePointfailure());
        });
      });
    });
  }
}
