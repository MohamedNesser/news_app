import 'package:flutter/material.dart';
import 'package:news_app/api_utils/model/category/categories.dart';
import 'package:news_app/screens/category_fragment/category_fragment.dart';
import 'package:news_app/screens/drawar/drawer_widget.dart';
import 'package:news_app/screens/news_screen/news_screen.dart';
import 'package:news_app/screens/setting_tap/setting_screen.dart';
import 'package:news_app/them_app/app_color.dart';
import 'package:news_app/them_app/them_app.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var listcatogry = Categories.getCategories();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColor.wightcolor,
          child: Image.asset(
            "assets/images/main_background.png",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              selectedcategory == null ? "News App" : selectedcategory!.title,
              style: Apptheme.Lightmode.textTheme.bodyMedium!.copyWith(
                color: AppColor.wightcolor,
              ),
            ),
          ),
          drawer: Drawer(
            child: Drawerscreen(oncategoryclick: categorybuttom),
            backgroundColor: AppColor.wightcolor,
          ),
          body: newselecteddraweritem == Drawerscreen.settingsindex
              ? SettingScreen()
              : selectedcategory == null
              ? CategoryFragment(oncategoryclick: oncategoryclick)
              : Newsdetals(categoryid: selectedcategory!),
        ),
      ],
    );
  }

  Categories? selectedcategory;

  void oncategoryclick(Categories newscategory) {
    selectedcategory = newscategory;
    setState(() {});
  }

  int newselecteddraweritem = Drawerscreen.categoryindex;
  void categorybuttom(int selectitemdrawer) {
    newselecteddraweritem = selectitemdrawer;
    selectedcategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
