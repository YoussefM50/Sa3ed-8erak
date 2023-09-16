import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:final_pro/Cubit/cubit.dart';
import 'package:final_pro/Cubit/state.dart';
import 'package:final_pro/Theme/theme.dart';
import 'package:final_pro/imp_func.dart';
import 'package:final_pro/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatelessWidget {
  late String selectedCategory;

  late int numofproducts;
  TextEditingController descriptiontext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(builder: (context, state) {
      if (state is uploadpostloading) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text("جاري رفع المنشور....")
          ],
        ));
      } else {
        selectedCategory = BlocProvider.of<AppCubit>(context).category;
        numofproducts = BlocProvider.of<AppCubit>(context).numofproducts;
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 35),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              //child 1 for images
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "تحميل صور المنتج",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConditionalBuilder(
                            condition:
                                BlocProvider.of<AppCubit>(context).image1 !=
                                    null,
                            builder: (context) {
                              return addimagecontainer(
                                  BlocProvider.of<AppCubit>(context).image1,
                                  "image1",
                                  context);
                            },
                            fallback: (context) {
                              return addimagebutton("selectimage1", context);
                            }),
                        const SizedBox(height: 10),
                        ConditionalBuilder(
                            condition:
                                BlocProvider.of<AppCubit>(context).image2 !=
                                    null,
                            builder: (context) {
                              return addimagecontainer(
                                  BlocProvider.of<AppCubit>(context).image2,
                                  "image2",
                                  context);
                            },
                            fallback: (context) {
                              return addimagebutton("selectimage2", context);
                            }),
                        const SizedBox(height: 10),
                        ConditionalBuilder(
                            condition:
                                BlocProvider.of<AppCubit>(context).image3 !=
                                    null,
                            builder: (context) {
                              return addimagecontainer(
                                  BlocProvider.of<AppCubit>(context).image3,
                                  "image3",
                                  context);
                            },
                            fallback: (context) {
                              return addimagebutton("selectimage3", context);
                            }),
                        const SizedBox(height: 10),
                        ConditionalBuilder(
                            condition:
                                BlocProvider.of<AppCubit>(context).image4 !=
                                    null,
                            builder: (context) {
                              return addimagecontainer(
                                  BlocProvider.of<AppCubit>(context).image4,
                                  "image4",
                                  context);
                            },
                            fallback: (context) {
                              return addimagebutton("selectimage4", context);
                            }),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                  height: 100,
                  child: TEXTFIELD(
                      descriptiontext,
                      TextInputType.multiline,
                      "الوصف",
                      "اكتب اكثر عن المنتج",
                      const Icon(Icons.description_outlined),
                      false)),
              const SizedBox(height: 15),
              Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 1),
                    color: const Color.fromARGB(255, 173, 231, 175),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.category_sharp,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "التصنيف",
                          style: Titlestyle.copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 20),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(35),
                          focusColor: primaryClr,
                          value: selectedCategory,
                          dropdownColor:
                              const Color.fromARGB(255, 105, 156, 106),
                          items: BlocProvider.of<AppCubit>(context)
                              .repeatList
                              .map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                "$e",
                                style: Titlestyle.copyWith(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            BlocProvider.of<AppCubit>(context)
                                .selectedCategory(value as String);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 4,
                          underline: Container(height: 0),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 15),
              Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 1),
                    color: const Color.fromARGB(255, 173, 231, 175),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.numbers,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "العدد",
                          style: Titlestyle.copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 20),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(35),
                          focusColor: primaryClr,
                          value: numofproducts,
                          dropdownColor:
                              const Color.fromARGB(255, 105, 156, 106),
                          items: BlocProvider.of<AppCubit>(context)
                              .numbers
                              .map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                "$e",
                                style: Titlestyle.copyWith(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            BlocProvider.of<AppCubit>(context)
                                .selectnumofproducts(value as int);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 4,
                          underline: Container(height: 0),
                        ),
                      ],
                    ),
                  )),
              //child 4 for button
              const SizedBox(height: 35),
              Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryClr,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  child: Text(
                    "حفظ",
                    style: Titlestyle.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    if (descriptiontext.text.isEmpty||
                        BlocProvider.of<AppCubit>(context).image4 == null ||
                        BlocProvider.of<AppCubit>(context).image3 == null ||
                        BlocProvider.of<AppCubit>(context).image2 == null ||
                        BlocProvider.of<AppCubit>(context).image1 == null ||
                        BlocProvider.of<AppCubit>(context).category == null)
                    {
                      if(descriptiontext.text.isEmpty ){
                        showtoast("يجب ان تكتب وصف",2);
                      }else{
                        showtoast("يجب ان تدخل 4 صور",2);
                      }
                    } else {
                      BlocProvider.of<AppCubit>(context).uploadimagestofirestorage(
                          numberofproducts:
                              BlocProvider.of<AppCubit>(context).numofproducts,
                          pointsofproduct:
                              BlocProvider.of<AppCubit>(context).numofpoints,
                          description: descriptiontext.text,
                          category: BlocProvider.of<AppCubit>(context).category,
                          username:
                              "${AppCubit.get(context).usermodel!.Fname[0]} ${AppCubit.get(context).usermodel!.Lname[0]}",
                          useraddress: AppCubit.get(context).usermodel!.address,
                          usernumber:
                              AppCubit.get(context).usermodel!.phonenumber,
                          userid: AppCubit.get(context).usermodel!.id);
                    }
                  },
                ),
              )
            ],
          ),
        );
      }
    }, listener: (context, state) {
      if (state is uploadpostsuccess) {
        BlocProvider.of<AppCubit>(context).removeimage("image1");
        BlocProvider.of<AppCubit>(context).removeimage("image2");
        BlocProvider.of<AppCubit>(context).removeimage("image3");
        BlocProvider.of<AppCubit>(context).removeimage("image4");
        BlocProvider.of<AppCubit>(context).category = "اخري";
        BlocProvider.of<AppCubit>(context).numofproducts = 1;
        BlocProvider.of<AppCubit>(context).numofpoints = 3;
        descriptiontext.clear();
      }
    });
  }

  addimagebutton(String selectimage, context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 171, 218, 173),
        ),
        child: IconButton(
          onPressed: () {
            if (selectimage == "selectimage1") {
              BlocProvider.of<AppCubit>(context).selectimage1();
            } else if (selectimage == "selectimage2") {
              BlocProvider.of<AppCubit>(context).selectimage2();
            } else if (selectimage == "selectimage3") {
              BlocProvider.of<AppCubit>(context).selectimage3();
            } else {
              BlocProvider.of<AppCubit>(context).selectimage4();
            }
          },
          icon: const Icon(Icons.add_a_photo),
          iconSize: 50,
        ));
  }

  addimagecontainer(postimage, imagenumber, context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 300,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Image.file(
              postimage,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<AppCubit>(context).removeimage(imagenumber);
            },
            child: const Icon(
              Icons.highlight_remove_sharp,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
