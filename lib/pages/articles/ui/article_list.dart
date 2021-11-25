import 'package:chandresh_practicle/common/loader_screen.dart';
import 'package:chandresh_practicle/common/string.dart';
import 'package:chandresh_practicle/common/theme.dart';
import 'package:chandresh_practicle/models/article_model.dart';
import 'package:chandresh_practicle/models/tag_model.dart';
import 'package:chandresh_practicle/pages/articles/controller/article_controller.dart';
import 'package:chandresh_practicle/pages/articles/ui/article_list_item.dart';
import 'package:chandresh_practicle/pages/articles/ui/tag_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'book_mark_list.dart';
import 'error_page.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  @override
  void initState() {
    Provider.of<ArticleController>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArticleController provider = Provider.of<ArticleController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings().learn),
        actions: [
          IconButton(
            onPressed: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => const BookMarkList());
              Navigator.of(context).push(route);
            },
            icon: Container(
              decoration: BoxDecoration(
                  color: AppTheme().backgroundColor,
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/save_white_icon.png'),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Selector<ArticleController, List<Tag>>(
            builder: (context, tagList, child) {
              return Visibility(
                visible: tagList.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      children: List.generate(tagList.length, (index) {
                        Tag tag = tagList[index];
                        double left = index == 0 ? 12 : 0;
                        double right = index == (tagList.length - 1) ? 12 : 0;
                        return Padding(
                          padding: EdgeInsets.only(left: left, right: right),
                          child: TagView(
                            title: tag.name ?? '',
                            color: getColorByName(tag.color ?? 'red'),
                            onTap: () {
                              Tag? val = tag;
                              if (provider.selectedTag == tag) {
                                val = null;
                              }
                              provider.setSelectedTag = val;
                            },
                            isSelected: provider.selectedTag == tag,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              );
            },
            selector: (buildContext, tagList) => provider.tagList,
          ),
          Expanded(
            child: Selector<ArticleController, List<Article>>(
              builder: (context, articleList, child) {
                if((!provider.isLoading) && articleList.isEmpty){
                  return const ErrorPage();
                }
                return Visibility(
                  visible: articleList.isNotEmpty,
                  child: ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: articleList.length,
                    itemBuilder: (context, index) {
                      Article article = articleList[index];
                      bool visible = provider.selectedTag == null ||
                          (article.tags?.contains(provider.selectedTag) ??
                              false);
                      return Visibility(
                        visible: visible,
                        child: ArticleListItem(
                          article: article,
                          onTap: () {
                            canLaunch(article.contentUrl ?? '').then((value) {
                              if (value) {
                                launch(article.contentUrl ?? '');
                              }
                            });
                          },
                          onTapBookmark: (){
                            provider.addToBookMark(article);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              selector: (buildContext, articleList) => provider.articleList,
            ),
          ),
          Selector<ArticleController, bool>(
            builder: (context, isLoading, child) {
              return Visibility(
                visible: provider.isLoading,
                child: const Loader(),
              );
            },
            selector: (buildContext, isLoading) => provider.isLoading,
          ),
        ],
      ),
    );
  }

  Color getColorByName(String s) {
    if (s == 'red') {
      return AppTheme().red;
    } else if (s == 'green') {
      return AppTheme().green;
    } else if (s == 'yellow') {
      return AppTheme().yellow;
    }
    return AppTheme().red;
  }
}
