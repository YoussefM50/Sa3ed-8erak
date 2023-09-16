part of 'admin_cubit.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class Adminloading extends AdminState {}

class Admingetallorderssuccess extends AdminState {}

class Admingetallordersfailure extends AdminState {
  String error;
  Admingetallordersfailure(this.error);
}

class Admindeleteordersuccess extends AdminState {}

class Admindeleteorderfailure extends AdminState {
  String error;
  Admindeleteorderfailure(this.error);
}

class Adminchangemodesuccess extends AdminState {}

class updatePointsuccess extends AdminState {}

class updatePointfailure extends AdminState {}
class SocialSuccessLogOutState extends AdminState {}
