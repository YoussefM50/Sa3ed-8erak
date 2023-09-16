import '../model/Postmodel.dart';

abstract class AppState {}

class AppInitState extends AppState {}

class Appchangemodesuccess extends AppState {}

class ChangeScreen extends AppState {
  Post_Model post;
  String postID;
  String UsertID;
  String? page;
  int? counter;
  ChangeScreen(this.post, this.postID, this.UsertID, {this.page, this.counter});
}

class ChangeIndecator extends AppState {}

class Tabviewsuccess extends AppState {}

class Tabviewfailure extends AppState {
  Tabviewfailure(this.error);
  String error;
}

class Tabviewloading extends AppState {}

class CartCounterPlus extends AppState {}

class CartCounterMinus extends AppState {}

class ChangeVisState extends AppState {}

class ChangeLogState extends AppState {}

class Gotoediteprofilesuccess extends AppState {}

class Gotocartscreensuccess extends AppState {}

class SocialGetUserLoadingState extends AppState {}

class SocialGetUserSuccState extends AppState {}

class SocialGetUserErrorState extends AppState {
  String error;
  SocialGetUserErrorState(this.error);
}

class SocialSuccessLogOutState extends AppState {}

class selectnewimagesuccess extends AppState {}

class selectnewimagefailure extends AppState {
  selectnewimagefailure(this.error);
  String error;
}

class removeimagesuccess extends AppState {}

class selectcategorysuccess extends AppState {}

class selectnumofproductssuccess extends AppState {}

class uploadimagesfailure extends AppState {
  uploadimagesfailure(this.error);
  String error;
}

class uploadpostsuccess extends AppState {}

class uploadpostfailure extends AppState {
  uploadpostfailure(this.error);
  String error;
}

class uploadpostloading extends AppState {}

class updatePointsuccess extends AppState {}

class updatePointfailure extends AppState {}

class updatenumofproductsuccess extends AppState {}

class updatenumofproductfailure extends AppState {}

class getpostsLoading extends AppState {}
class getpostssuccess extends AppState {}

class getpostsfailure extends AppState {
  String error;
  getpostsfailure(this.error);
}

class addtocartsuccess extends AppState {}

class addtocartfailure extends AppState {
  String error;
  addtocartfailure(this.error);
}

class getfromcartsuccess extends AppState {}

class getfromcartfailure extends AppState {
  String error;
  getfromcartfailure(this.error);
}

class addtofavsuccess extends AppState {}

class addtofavfailure extends AppState {
  String error;
  addtofavfailure(this.error);
}

class getfromfavsuccess extends AppState {}

class getfromfavfailure extends AppState {
  String error;
  getfromfavfailure(this.error);
}

class removecartsuccess extends AppState {}

class removecartfailure extends AppState {
  String error;
  removecartfailure(this.error);
}

class removeFavsuccess extends AppState {}

class removeFavfailure extends AppState {
  String error;
  removeFavfailure(this.error);
}

class uploadNumOfItemsuccess extends AppState {}

class uploadNumOfItemfailure extends AppState {
  String error;
  uploadNumOfItemfailure(this.error);
}

class favuccess extends AppState {}

class updatebooleandatainpostsuccess extends AppState {}

class updatebooleandatainpostfailure extends AppState {
  String error;
  updatebooleandatainpostfailure(this.error);
}

class changefavsuccess extends AppState {}

class gotoSearchScreen extends AppState {}

class searchPostLoading extends AppState {}

class searchPostSuccess extends AppState {}

class searchPostFailure extends AppState {
  String error;
  searchPostFailure(this.error);
}

class sendorderloading extends AppState {}

class sendordersuccess extends AppState {}

class sendorderfailure extends AppState {
  String error;
  sendorderfailure(this.error);
}

class CartFromFavloading extends AppState {}

class CartFromFavsuccess extends AppState {}

class CartFromFavfailure extends AppState {
  String error;
  CartFromFavfailure(this.error);
}

class changepasswordsuccess extends AppState {}

class changepasswordfailure extends AppState {
  String error;
  changepasswordfailure(this.error);
}

class deleteemailsuccess extends AppState {}

class deleteemailfailure extends AppState {
  String error;
  deleteemailfailure(this.error);
}

class removepostLoading extends AppState {}

class removepostsuccess extends AppState {}

class removefailure extends AppState {
  String error;
  removefailure(this.error);
}

class getpost_CategoryLoading extends AppState {}

class getpost_Categorysuccess extends AppState {}

class getpost_Categoryfailure extends AppState {
  String error;
  getpost_Categoryfailure(this.error);
}
class GetfromAPILoading extends AppState {}

class GetfromAPIsuccess extends AppState {}

class GetfromAPIfailure extends AppState {
  String error;
  GetfromAPIfailure(this.error);
}
