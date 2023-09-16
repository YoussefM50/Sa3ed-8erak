import 'package:bloc/bloc.dart';
import 'package:final_pro/Helper/Share_Pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'appmode_state.dart';

class AppmodeCubit extends Cubit<AppmodeState> {
  AppmodeCubit() : super(ThemeInitial());
  static AppmodeCubit get(context)=>BlocProvider.of(context);
  bool IsDark = Sharepref.getdata(key: "DarkTheme");
  void ChangeMode({bool? is_dark}) {
    if (is_dark != null) {
      IsDark = is_dark;
    } else {
      IsDark = !IsDark;
    }
    print("IS Dark ${IsDark}");
    Sharepref.savedata(key: "DarkTheme", value: IsDark).then((value) {
      emit(ChangeLightDark());
    });
  }
}