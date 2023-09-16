import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Core/api_service.dart';
import '../Helper/Share_Pref.dart';
import '../Screens/homepage/cart/Cart_screen.dart';
import '../Screens/homepage/fav/fav.dart';
import '../Screens/homepage/home/home.dart';
import '../Screens/homepage/post/Add_screen.dart';
import '../Screens/homepage/profile/profile.dart';
import '../imp_func.dart';
import '../model/Postmodel.dart';
import '../model/Sa3edUserData.dart';
import 'package:firebase_storage/firebase_storage.dart' as firestorage;

import '../model/cartmodel.dart';
import '../model/order_model.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

//************************* Dark Mode *************************************//
//************************************************************************//
  Appchangemode(var line) {
    line.ChangeMode();
    emit(Appchangemodesuccess());
  }

//*********************** Tab view ****************************************//
//************************************************************************//
  String title = "الصفحة الرئيسية";
  PersistentTabController controller = PersistentTabController(initialIndex: 2);

  List<String> titles = [
    "العربة",
    "الملف الشخصي",
    "الصفحة الرئيسية",
    "اضافة منتج",
    "المفضلات "
  ];
  List<Widget> screens = [
    Cart_screen(),
    ProfilePage(),
    homescreen(),
    AddScreen(),
    Favscreen()
  ];

  change_screen(PersistentTabController tabcontroller) {
    title = titles[tabcontroller.index];
    controller = tabcontroller;
    emit(Tabviewsuccess());
    if (tabcontroller.index == 0) {
      getfromcart();
    } else if (tabcontroller.index == 1) {
      getmypost();
    } else if (tabcontroller.index == 2) {
      // getallposts();
    } else if (tabcontroller.index == 4) {
      print("Get from Fav");
      getfromfav();
    }
  }

  void move_decribtionScreen(post, postID, userid, {int? counter}) {
    emit(ChangeScreen(post, postID, userid, counter: counter));
  }

  void Change_Indecator() {
    emit(ChangeIndecator());
  }

//*********************** Profile Screen **********************************//
//************************************************************************//
  bool Vispass = false;

  void ChangepasswordVisiability() {
    Vispass = !Vispass;
    emit(ChangeVisState());
  }

  void logout() {
    Sharepref.Deletedata(key: 'UID').then((value) {
      emit(SocialSuccessLogOutState());
    });
  }

  //*********************** Get User Data **********************************//
//************************************************************************//
  Social_model? usermodel;
  Future<void> GetUserData() async {
    emit(SocialGetUserLoadingState());
    print(UID);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .get()
        .then((value) {
      print(
          "**********************************************************************");
      print(value.data());
      print(
          "**********************************************************************");
      usermodel = Social_model.fromJson(value.data() as Map<String, dynamic>);
      print(usermodel!.Uid);
      emit(SocialGetUserSuccState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SocialGetUserErrorState(Error.toString()));
    });
  }

  //************************* UpDate Point *************************************//
//************************************************************************//
//to update points every month
  // void checkdate() {
  //   if (DateTime.now().day == 1) {
  //     updatepoint(30);
  //   }
  // }

  Future<void> updatepoint(int point) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .update({"point": point}).then((value) {
      emit(updatePointsuccess());
    }).catchError((Error) {
      emit(updatePointfailure());
    });
  }

  //************************* Posts *************************************//
//************************************************************************//

  File? image1;
  File? image2;
  File? image3;
  File? image4;
  var imagepicker = ImagePicker();

  selectimage1() async {
    final filepicker = await imagepicker.pickImage(source: ImageSource.gallery);
    if (filepicker != null) {
      image1 = File(filepicker.path);
      emit(selectnewimagesuccess());
    } else {
      print("No photo selected");
      emit(selectnewimagefailure("No photo selected"));
    }
  }

  selectimage2() async {
    final filepicker = await imagepicker.pickImage(source: ImageSource.gallery);
    if (filepicker != null) {
      image2 = File(filepicker.path);
      emit(selectnewimagesuccess());
    } else {
      print("No photo selected");
      emit(selectnewimagefailure("No photo selected"));
    }
  }

  selectimage3() async {
    final filepicker = await imagepicker.pickImage(source: ImageSource.gallery);
    if (filepicker != null) {
      image3 = File(filepicker.path);
      emit(selectnewimagesuccess());
    } else {
      print("No photo selected");
      emit(selectnewimagefailure("No photo selected"));
    }
  }

  selectimage4() async {
    final filepicker = await imagepicker.pickImage(source: ImageSource.gallery);
    if (filepicker != null) {
      image4 = File(filepicker.path);
      emit(selectnewimagesuccess());
    } else {
      print("No photo selected");
      emit(selectnewimagefailure("No photo selected"));
    }
  }

  //remove images
  removeimage(String image) {
    if (image == "image1") {
      image1 = null;
      emit(removeimagesuccess());
    } else if (image == "image2") {
      image2 = null;
      emit(removeimagesuccess());
    } else if (image == "image3") {
      image3 = null;
      emit(removeimagesuccess());
    } else {
      image4 = null;
      emit(removeimagesuccess());
    }
  }

  //select number of product
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int numofproducts = 1;

  selectnumofproducts(int value) {
    numofproducts = value;
    emit(selectnumofproductssuccess());
  }

//select category
  List repeatList = [
    'كتب',
    'ادوات مدرسية',
    'ادوات منزلية',
    'ملابس',
    'اثاث',
    'اجهزة كهربائية',
    'اخري'
  ];
  String category = "اخري";

  selectedCategory(String value) {
    category = value;
    pointsofcategory(category);
  }

//points of category
  int numofpoints = 3;

  pointsofcategory(String category) {
    if (category == "كتب") {
      numofpoints = 4;
    } else if (category == "اجهزة كهربائية") {
      numofpoints = 10;
    } else if (category == "ملابس") {
      numofpoints = 6;
    } else if (category == "ادوات مدرسية") {
      numofpoints = 5;
    } else if (category == "ادوات منزلية") {
      numofpoints = 9;
    } else if (category == "اثاث") {
      numofpoints = 8;
    } else {
      numofpoints = 3;
    }
    emit(selectcategorysuccess());
  }

//upload images to firestorage
  String? image1url;
  String? image2url;
  String? image3url;
  String? image4url;

  uploadimagestofirestorage(
      {required description,
      required category,
      required username,
      required useraddress,
      required usernumber,
      required userid,
      required numberofproducts,
      required pointsofproduct,
      bool? available}) {
    emit(uploadpostloading());
    //upload image1
    firestorage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(image1!.path).pathSegments.last}')
        .putFile(image1!)
        .then((value) {
      value.ref.getDownloadURL().then((value2) {
        image1url = value2;
        //upload image2
        firestorage.FirebaseStorage.instance
            .ref()
            .child('Posts/${Uri.file(image2!.path).pathSegments.last}')
            .putFile(image2!)
            .then((value) {
          value.ref.getDownloadURL().then((value2) {
            image2url = value2;
            //upload image3
            firestorage.FirebaseStorage.instance
                .ref()
                .child('Posts/${Uri.file(image3!.path).pathSegments.last}')
                .putFile(image3!)
                .then((value) {
              value.ref.getDownloadURL().then((value2) {
                image3url = value2;
                //upload image4
                firestorage.FirebaseStorage.instance
                    .ref()
                    .child('Posts/${Uri.file(image4!.path).pathSegments.last}')
                    .putFile(image4!)
                    .then((value) {
                  value.ref.getDownloadURL().then((value2) {
                    image4url = value2;
                    uploadpost(
                      numberofproducts: numberofproducts,
                      pointsofproduct: pointsofproduct,
                      description: description,
                      category: category,
                      username: username,
                      useraddress: useraddress,
                      usernumber: usernumber,
                      userid: userid,
                    );
                  }).catchError((error) {
                    emit(uploadimagesfailure(error.toString()));
                  });
                }).catchError((error) {
                  emit(uploadimagesfailure(error.toString()));
                });
              }).catchError((error) {
                emit(uploadimagesfailure(error.toString()));
              });
            }).catchError((error) {
              emit(uploadimagesfailure(error.toString()));
            });
          }).catchError((error) {
            emit(uploadimagesfailure(error.toString()));
          });
        }).catchError((error) {
          emit(uploadimagesfailure(error.toString()));
        });
      }).catchError((error) {
        emit(uploadimagesfailure(error.toString()));
      });
    }).catchError((error) {
      emit(uploadimagesfailure(error.toString()));
    });
  }

  //upload posts to firebasefirestore
  uploadpost(
      {required description,
      required category,
      required username,
      required useraddress,
      required usernumber,
      required userid,
      required numberofproducts,
      required pointsofproduct,
      bool? available}) {
    Post_Model post = Post_Model(
      time: DateTime.now().toString(),
      numberofproducts: numberofproducts,
      pointsofproduct: pointsofproduct,
      postimage1: image1url!,
      postimage2: image2url!,
      postimage3: image3url!,
      postimage4: image4url!,
      description: description,
      category: category,
      username: username,
      useraddress: useraddress,
      userid: userid,
      usernumber: usernumber,
      available: (available == null) ? false : available,
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(post.ToMap())
        .then((value) {
      emit(uploadpostsuccess());
      getallposts();
    }).catchError((error) {
      emit(uploadpostfailure(error.toString()));
    });
  }

  //************************* Get Posts *************************************//
//************************************************************************//

  //select home category
  List homerepeatList = [
    'الكل',
    'كتب',
    'ادوات مدرسية',
    'ادوات منزلية',
    'ملابس',
    'اثاث',
    'اجهزة كهربائية',
    'اخري'
  ];
  String homecategory = "الكل";

  homeselectedCategory(String value) {
    homecategory = value;
    emit(selectcategorysuccess());
  }

  List<Post_Model> books = [];
  List<Post_Model> school = [];
  List<Post_Model> home = [];
  List<Post_Model> furniture = [];
  List<Post_Model> electrical_devices = [];
  List<Post_Model> clothes = [];
  List<Post_Model> others = [];
  List<Post_Model> allposts = [];
  List<String> PostsId = [];
  List<String> booksId = [];
  List<String> schoolId = [];
  List<String> homeId = [];
  List<String> furnitureId = [];
  List<String> electrical_devicesId = [];
  List<String> clothesId = [];
  List<String> othersId = [];

  List<Post_Model> UserPost = [];
  List<String> UserPostID = [];
  Future<void> getallposts() async {
    emit(getpostsLoading());
    UserPost = [];
    UserPostID = [];
    books = [];
    school = [];
    home = [];
    furniture = [];
    electrical_devices = [];
    clothes = [];
    others = [];
    allposts = [];
    PostsId = [];
    booksId = [];
    schoolId = [];
    homeId = [];
    furnitureId = [];
    electrical_devicesId = [];
    clothesId = [];
    othersId = [];
    getfromcart();
    print("getfromcart");
    getfromfav();
    print("getfromfav");
    await FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        Post_Model post = Post_Model.fromJson(element.data());
        if (post.category == "كتب") {
          books.add(post);
          booksId.add(element.id);
        } else if (post.category == "اجهزة كهربائية") {
          electrical_devices.add(post);
          electrical_devicesId.add(element.id);
        } else if (post.category == "ملابس") {
          clothes.add(post);
          clothesId.add(element.id);
        } else if (post.category == "ادوات مدرسية") {
          school.add(post);
          schoolId.add(element.id);
        } else if (post.category == "ادوات منزلية") {
          home.add(post);
          homeId.add(element.id);
        } else if (post.category == "اثاث") {
          furniture.add(post);
          furnitureId.add(element.id);
        } else {
          others.add(post);
          othersId.add(element.id);
        }
        allposts.add(post);
        PostsId.add(element.id);
      });
      print(allposts.length);
      emit(getpostssuccess());
      if (controller.index == 1) {
        getmypost();
      }
      print(allposts);
    }).catchError((error) {
      print(error.toString());
      emit(getpostsfailure("get all posts error"));
    });
  }

//*************************  cart *************************************//
//************************************************************************//
//update boolean data in post
  bool finditemincartlist(String postid) {
    for (int i = 0; i < mycart.length; i++) {
      if (mycart[i].postid == postid) {
        return true;
      }
    }
    return false;
  }

//add to cart
  addtocart(
      {required Post_Model post, int? mynumofproduct, required String postid}) {
    Cart_Model model = Cart_Model(
        available: post.available,
        category: post.category,
        description: post.description,
        mynumProduct: mynumofproduct ?? 1,
        pointsofproduct: post.pointsofproduct,
        postid: postid,
        postimage1: post.postimage1,
        useraddress: post.useraddress,
        username: post.username,
        usernumber: post.usernumber,
        numberofproducts: post.numberofproducts);
    FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(UID)
        .collection('Cart')
        .add(model.ToMap())
        .then((value) {
      emit(addtocartsuccess());
      getfromcart();
    }).catchError((error) {
      emit(addtocartfailure(error.toString()));
    });
  }

//remove from cart
  void removefromcart({String? CartId, Cart_Model? cart, String? postid}) {
    late String cart_id;
    if (CartId == null) {
      for (int i = 0; i < mycart.length; i++) {
        if (mycart[i].postid == postid) {
          cart_id = mycartId[i];
          break;
        }
      }
    } else {
      cart_id = CartId;
    }
    FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(UID)
        .collection('Cart')
        .doc(cart_id)
        .delete()
        .then((value) {
      getfromcart();
      emit(removecartsuccess());
    }).catchError((error) {
      emit(removecartfailure(error.toString()));
    });
  }

  //get from cart
  List<Cart_Model> mycart = [];
  List<String> mycartId = [];
  List<int?> numofproduct = [];

  getfromcart() async {
    mycart = [];
    mycartId = [];
    numofproduct = [];
    await FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(UID)
        .collection('Cart')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          Cart_Model post = Cart_Model.fromJson(element.data());
          mycart.add(post);
          mycartId.add(element.id);
          numofproduct.add(post.mynumProduct);
        });
      }
      print(mycart);
      emit(getfromcartsuccess());
    }).catchError((error) {
      emit(getfromcartfailure(error.toString()));
    });
  }

  void minus({required int index}) {
    numofproduct[index] = numofproduct[index]! - 1;
    print(numofproduct);
    emit(CartCounterMinus());
  }

  void plus({required int index}) {
    numofproduct[index] = numofproduct[index]! + 1;
    print(numofproduct);
    emit(CartCounterPlus());
  }

  void minusDes() {
    emit(CartCounterMinus());
  }

  void plusDes() {
    emit(CartCounterPlus());
  }

//upload point for cart
  void updatepointforcart(int numproduct, Cartid) {
    FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(UID)
        .collection('Cart')
        .doc(Cartid)
        .update({"mynumProduct": numproduct}).then((value) {
      emit(updatenumofproductsuccess());
    }).catchError((Error) {
      emit(updatenumofproductfailure());
    });
  }

  int? getnumofitemfromcart(String postID) {
    for (int i = 0; i < mycart.length; i++) {
      if (mycart[i].postid == postID) {
        return numofproduct[i];
      }
    }
    return null;
  }

//************************* Favorite *************************************//
//************************************************************************//
//add to fav
  bool finditeminfavlist(String postid) {
    for (int i = 0; i < myfav.length; i++) {
      if (myfav[i].postid == postid) {
        return true;
      }
    }
    return false;
  }

  addtofav(
      {required Post_Model post, required String PostId, int? mynumofproduct}) {
    Cart_Model model = Cart_Model(
        available: post.available,
        category: post.category,
        description: post.description,
        postimage1: post.postimage1,
        pointsofproduct: post.pointsofproduct,
        useraddress: post.useraddress,
        postid: PostId,
        username: post.username,
        usernumber: post.usernumber,
        numberofproducts: post.numberofproducts,
        mynumProduct: mynumofproduct ?? 0);

    FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(UID)
        .collection('Fav')
        .add(model.ToMap())
        .then((value) {
      emit(addtofavsuccess());
      getfromfav();
    }).catchError((error) {
      emit(addtofavfailure(error.toString()));
    });
  }

//remove from fav
  void removefromFav({String? FavId, Cart_Model? fav, String? postid}) {
    late String fav_id;
    if (FavId == null) {
      for (int i = 0; i < myfav.length; i++) {
        if (myfav[i].postid == postid) {
          fav_id = myfavId[i];
          break;
        }
      }
    } else {
      fav_id = FavId;
    }
    FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(UID)
        .collection('Fav')
        .doc(fav_id)
        .delete()
        .then((value) {
      getfromfav();
    }).catchError((error) {
      emit(removeFavfailure(error.toString()));
    });
  }

  //get from fav
  List<Cart_Model> myfav = [];
  List<String> myfavId = [];

  getfromfav() async {
    myfav = [];
    myfavId = [];
    await FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(UID)
        .collection('Fav')
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        value.docs.forEach((element) {
          Cart_Model post = Cart_Model.fromJson(element.data());
          myfav.add(post);
          myfavId.add(element.id);
        });
      }
      emit(getfromfavsuccess());
    }).catchError((error) {
      emit(getfromfavfailure(error.toString()));
    });
  }

  int get_postfrom_fav({required Cart_Model fav}) {
    emit(CartFromFavloading());
    for (int i = 0; i < PostsId.length; i++) {
      if (PostsId[i] == fav.postid) {
        emit(CartFromFavsuccess());
        return i;
      }
    }
    emit(CartFromFavfailure("Not Found"));
    return -1;
  }

  //************************* Search *************************************//
//************************************************************************//
  void go_toSearchScreen() {
    emit(gotoSearchScreen());
  }

  List<Post_Model> SearchList = [];
  List<String> SearchListID = [];

  void SearchPost({String? value}) {
    SearchList = [];
    SearchListID = [];
    if (value == null) {
      emit(searchPostSuccess());
    } else {
      try {
        emit(searchPostLoading());
        for (int i = 0; i < allposts.length; i++) {
          if (allposts[i].category.contains(value) ||
              (allposts[i].description.contains(value))) {
            SearchList.add(allposts[i]);
            SearchListID.add(PostsId[i]);
            print(SearchList);
            print(SearchListID);
            emit(searchPostSuccess());
          }
        }
        print(SearchListID);
      } catch (e) {
        emit(searchPostFailure(e.toString()));
      }
    }
  }

  //************************* Admin *************************************//
//************************************************************************//
  //update post
  updatepost(String postid, int num) {
    removefromcart(postid: postid);
    FirebaseFirestore.instance.collection('Posts').doc(postid).update(
        {"numberofproducts": num, "available": true}).catchError((error) {
      emit(sendorderfailure(error.toString()));
    });
  }

  // send order to admin
  buythisitems(int points) async {
    if (usermodel!.point >= points) {
      for (int i = 0; i < mycart.length; i++) {
        await sendordertoadmin(mycart[i]);
        String postid = mycart[i].postid;
        int numofproducts = mycart[i].numberofproducts;
        int mynumofproduct = numofproduct[i]!;
        if (numofproducts > mynumofproduct) {
          int result = mycart[i].numberofproducts - numofproduct[i]!;
          await updatepost(postid, result);
          await getallposts();
        } else {
          await removepost(PostID: postid);
        }
      }
      int result = usermodel!.point - points;
      await updatepoint(result);
      await GetUserData();
      emit(sendordersuccess());
    } else {
      emit(sendorderfailure("you don't have enough point "));
    }
  }

  sendordertoadmin(Cart_Model order_from_cart) async {
    emit(sendorderloading());
    Order_Model order = Order_Model(
      postimage1: order_from_cart.postimage1,
      description: order_from_cart.description,
      available: order_from_cart.available,
      numberofproducts: order_from_cart.mynumProduct!,
      time: DateTime.now().toString(),
      donorname: order_from_cart.username,
      donoraddress: order_from_cart.useraddress,
      donornumber: order_from_cart.usernumber,
      inneedname: "${usermodel!.Fname[0]} ${usermodel!.Lname[0]}",
      inneedaddress: usermodel!.address,
      inneednumber: usermodel!.phonenumber,
    );
    await FirebaseFirestore.instance
        .collection('Admin_Orders')
        .add(order.ToMap())
        .catchError((error) {
      emit(sendorderfailure(error.toString()));
    });
  }

  //************************* change password  *************************************//
//************************************************************************//
  changePassword(
      {required String currentPassword, required String newPassword}) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);
    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((value) {
        emit(changepasswordsuccess());
      }).catchError((error) {
        print(error.toString());
        emit(changepasswordfailure(
            " حدث خطأ في تغيير كلمة السر او كلمة السر السابقة غير صحيحة حاول مرة اخري"));
      });
    }).catchError((err) {
      print(err.toString());
      emit(changepasswordfailure(
          " حدث خطأ في تغيير كلمة السر او كلمة السر السابقة غير صحيحة حاول مرة اخري"));
    });
  }
//************************* delete email *************************************//
//************************************************************************//

  deleteemail(String currentPassword) async {
    await FirebaseFirestore.instance
        .collection("Posts")
        .where("userid", isEqualTo: usermodel!.Uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) async {
          removepost(PostID: element.id);
        });
      }
    });
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);
    user.reauthenticateWithCredential(cred).then((value) {
      user.delete().then((value) async {
        print(user.email);
        await FirebaseFirestore.instance.collection("Users").doc(UID).delete();
        print("done");
        Sharepref.Deletedata(key: 'UID').then((value) {
          emit(deleteemailsuccess());
        });
      }).catchError((error) {
        print(error.toString());
        emit(deleteemailfailure("كلمةالسر غير صحيح"));
      });
    }).catchError((err) {
      print(err.toString());
      emit(deleteemailfailure("كلمةالسر غير صحيح"));
    });
  }

  //************************* get my Post *************************************//
//************************************************************************//
  getmypost() {
    UserPost = [];
    UserPostID = [];
    for (int i = 0; i < allposts.length; i++) {
      if (allposts[i].userid == usermodel!.id) {
        UserPost.add(allposts[i]);
        UserPostID.add(PostsId[i]);
      }
    }
    emit(getpostssuccess());
  }

//************************* Remove Post *************************************//
//************************************************************************//
  //get all user
  List<String> alluasrsid = [];
  Future<void> getallusersid() async {
    alluasrsid = [];
    await FirebaseFirestore.instance
        .collection("Users")
        .get()
        .then((uservalue) {
      uservalue.docs.forEach((userelement) {
        alluasrsid.add(userelement.id);
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  //remove from fav
  Future<void> deletepostfromfav(String userid, String favelementid) async {
    await FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(userid)
        .collection('Fav')
        .doc(favelementid)
        .delete()
        .then((value) {
      print("delete");
    }).catchError((error) {
      emit(removefailure(error.toString()));
    });
  }

  //remove from all fav
  Future<void> removepostfromallfav(String PostID) async {
    print("all users  $alluasrsid");
    alluasrsid.forEach((userid) async {
      print(userid);
      await FirebaseFirestore.instance
          .collection('Cart_Fav')
          .doc(userid)
          .collection('Fav')
          .get()
          .then((favvalue) {
        favvalue.docs.forEach((favelement) async {
          Cart_Model post = Cart_Model.fromJson(favelement.data());
          print("favelement id ${post.postid}");
          if (post.postid == PostID) {
            print("find post in fav");
            await deletepostfromfav(userid, favelement.id);
          }
        });
      }).catchError((error) {
        emit(removefailure(error.toString()));
      });
    });
  }

  //remove from cart
  Future<void> deletepostfromCart(String userid, String cartelementid) async {
    await FirebaseFirestore.instance
        .collection('Cart_Fav')
        .doc(userid)
        .collection('Cart')
        .doc(cartelementid)
        .delete()
        .then((value) {
      print("delete");
    }).catchError((error) {
      emit(removefailure(error.toString()));
    });
  }

  //remove from all cart
  Future<void> removepostfromallCart(String PostID) async {
    alluasrsid.forEach((userid) async {
      print(userid);
      await FirebaseFirestore.instance
          .collection('Cart_Fav')
          .doc(userid)
          .collection('Cart')
          .get()
          .then((favvalue) {
        favvalue.docs.forEach((favelement) async {
          Cart_Model post = Cart_Model.fromJson(favelement.data());
          print("Cart element id ${post.postid}");
          if (post.postid == PostID) {
            print("find post in Cart");
            await deletepostfromCart(userid, favelement.id);
          }
        });
      }).catchError((error) {
        emit(removefailure(error.toString()));
      });
    });
  }

  Future<void> removepost({required String PostID}) async {
    emit(removepostLoading());
    await getallusersid();
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(PostID)
        .delete()
        .then((value) async {
      await removepostfromallfav(PostID);
      await removepostfromallCart(PostID);
      await getallposts();
      print("removepostsuccess");
      emit(removepostsuccess());
    }).catchError((error) {
      emit(removefailure(error.toString()));
    });
  }

  List<Post_Model> recommend_item = [];
  List<String> recommend_item_ID = [];
  getpostbelongtocategory({required String category, required postID}) async {
    // await getallposts();
    // emit(getpost_CategoryLoading());
    // if (category == "كتب") {
    //   print(books);
    //   return books;
    // } else if (category == "اجهزة كهربائية") {
    //   print(electrical_devices);
    //   return electrical_devices;
    // } else if (category == "ملابس") {
    //   print(clothes);
    //   return clothes;
    // } else if (category == "ادوات مدرسية") {
    //   print(school);
    //   return school;
    // } else if (category == "ادوات منزلية") {
    //   print(home);
    //   return home;
    // } else if (category == "اثاث") {
    //   print(furniture);
    //   return furniture;
    // } else {
    //   print(others);
    //   return others;
    // }
    recommend_item = [];
    emit(getpost_CategoryLoading());
    FirebaseFirestore.instance
        .collection("Posts")
        .where("category", isEqualTo: category)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (postID != element.id) {
          recommend_item_ID.add(element.id);
          recommend_item.add(Post_Model.fromJson(element.data()));
        }
      });
      getrondomvariable();
      emit(getpost_Categorysuccess());
    }).catchError((error) {
      emit(getpost_Categoryfailure(error.toString()));
    });
  }

  late int numofrecommeded;
  List<int> Recommended_index = [];
  getrondomvariable() {
    Recommended_index = [];
    if (recommend_item.length > 2) {
      numofrecommeded = 2 + Random().nextInt(recommend_item.length - 2);
      Recommended_index = List<int>.generate(recommend_item.length, (index) {
        return index;
      });
      Recommended_index.shuffle();
      print(numofrecommeded);
      print(Recommended_index);
    } else {
      Recommended_index = List<int>.generate(recommend_item.length, (index) {
        return index;
      });
      numofrecommeded = recommend_item.length;
    }
  }

  List<Post_Model> AI_Post = [];
  List<Post_Model> Rec_AI_Post = [];
  List<String> REC_AI_PostID = [];
  getDataFromAPI({required String postID, required ApiService API}) async {
    AI_Post = [];
    Rec_AI_Post = [];
    REC_AI_PostID = [];
    emit(GetfromAPILoading());
    try {
      var AI_result = await API.get(end_point: postID);
      AI_result.forEach((k, post) {
        AI_Post.add(Post_Model.fromJson(post));
      });
/****************************************************************************** */
      print(AI_Post.length);
      await FirebaseFirestore.instance.collection('Posts').get().then((value) {
        value.docs.forEach((element) {
          Post_Model post = Post_Model.fromJson(element.data());
          AI_Post.forEach((AI) {
            if (AI.description == post.description &&
                AI.userid == post.userid) {
              Rec_AI_Post.add(AI);
              REC_AI_PostID.add(element.id);
            }
          });
          print(Rec_AI_Post.length);
        });
        emit(GetfromAPIsuccess());
      }).catchError((error) {});
    } on Exception catch (e) {
      emit(GetfromAPIfailure(e.toString()));
    }
  }
}
