import 'package:flutter/material.dart';
import 'package:news_app/api_utils/api_method/api_utils.dart';
import 'package:news_app/api_utils/model/model_response/responsenews.dart';
import 'package:news_app/api_utils/model/news_model.dart';
import 'package:news_app/screens/news_detales/news_detales_screen.dart';
import 'package:news_app/screens/news_screen/item_news/item_news_widget.dart';
import 'package:news_app/them_app/app_color.dart';

// ignore: must_be_immutable
class NewsItems extends StatefulWidget {
  Source source;
  NewsItems({required this.source});
  static const String routeName = "NewsItems";
  @override
  State<NewsItems> createState() => _NewsItemsState();
}

class _NewsItemsState extends State<NewsItems> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Responsenews?>(
      future: ApiUtils.getdatanewsid(widget.source.id ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.primarycolor),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text("Some thing went wrong"),
                ElevatedButton(
                  onPressed: () {
                    ApiUtils.getdatanewsid(widget.source.id ?? '');
                    setState(() {});
                  },
                  child: Text("try agin"),
                ),
              ],
            ),
          ); //server => succses , error
        } else if (snapshot.data!.status != "ok") {
          return Column(
            children: [
              Text(snapshot.data!.message ?? ''),
              ElevatedButton(
                onPressed: () {
                  ApiUtils.getdatanewsid(widget.source.id ?? '');
                  setState(() {});
                },
                child: Text("try agin"),
              ),
            ],
          );
        }
        var newslist = snapshot.data!.articles!;
        return ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsDetalesScreen(sourcenews: newslist[index]),
                  ),
                );
              },
              child: ItemNewsWidget(sourcenews: newslist[index]),
            );
          },
          itemCount: newslist.length,
        );
      },
    );
  }
}
