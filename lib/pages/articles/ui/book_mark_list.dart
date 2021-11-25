import 'package:chandresh_practicle/common/string.dart';
import 'package:chandresh_practicle/common/theme.dart';
import 'package:chandresh_practicle/models/article_model.dart';
import 'package:chandresh_practicle/pages/articles/controller/article_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'article_list_item.dart';

class BookMarkList extends StatefulWidget {
  const BookMarkList({Key? key}) : super(key: key);

  @override
  _BookMarkListState createState() => _BookMarkListState();
}

class _BookMarkListState extends State<BookMarkList> {
  @override
  Widget build(BuildContext context) {
    // ArticleController provider = Provider.of<ArticleController>(context,listen: false);

    return Consumer<ArticleController>(
        builder: (BuildContext context, provider, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: Container(
              decoration: BoxDecoration(
                  color: AppTheme().backgroundColor,
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/x_button.png',
                height: 15,
              ),
            ),
          ),
          title: Text(Strings().saveForLater),
        ),
        body: ListView(
          primary: true,
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: List.generate(provider.bookMarks.length, (index) {
            Article article = ArticleController().bookMarks[index];
            bool visible = ArticleController().selectedTag == null ||
                (article.tags?.contains(ArticleController().selectedTag) ??
                    false);
            return Visibility(
              visible: visible,
              child: ArticleListItem(
                key: ObjectKey(
                    '${article.title ?? ''}-${article.createdAt ?? ''}'),
                article: article,
                onTap: () {
                  canLaunch(article.contentUrl ?? '').then((value) {
                    if (value) {
                      launch(article.contentUrl ?? '');
                    }
                  });
                },
                onTapBookmark: () {
                  provider.addToBookMark(article);
                },
              ),
            );
          }),
        ),
      );
    });
  }
}
