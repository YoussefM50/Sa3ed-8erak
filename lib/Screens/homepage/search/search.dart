import 'package:final_pro/Screens/homepage/search/searchItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubit/cubit.dart';
import '../../../Cubit/state.dart';
import '../../../imp_func.dart';
import '../tabview/tabview.dart';

class BlocProviderSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getallposts()..GetUserData(),
      child: SearchScreen(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  TextEditingController Searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is searchPostSuccess) {
          print("searchPostSuccess");
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: ()async {
            go_toAnd_finish(context, Blockprovidertabview());
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    go_toAnd_finish(context, Blockprovidertabview());
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                  )),
              title: const Text("البحث"),
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "...بحث",
                      suffixIcon: Icon(Icons.search)),
                  controller: Searchcontroller,
                  onChanged: (value) {
                    print(value);
                    if (value.isNotEmpty) {
                      AppCubit.get(context).SearchPost(value: value);
                    } else {
                      AppCubit.get(context).SearchPost();
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                if (state is searchPostLoading) const LinearProgressIndicator(),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return searchItems(
                            AppCubit.get(context).SearchList[index],
                            AppCubit.get(context).SearchListID[index],
                            context);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: AppCubit.get(context).SearchList.length),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
