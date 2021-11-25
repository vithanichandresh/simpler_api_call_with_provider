import 'package:chandresh_practicle/common/theme.dart';
import 'package:chandresh_practicle/models/article_model.dart';
import 'package:chandresh_practicle/models/tag_model.dart';
import 'package:chandresh_practicle/pages/articles/controller/article_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleListItem extends StatefulWidget {
  final Article article;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapBookmark;

  const ArticleListItem({Key? key, required this.article, this.onTap, this.onTapBookmark}) : super(key: key);

  @override
  _ArticleListItemState createState() => _ArticleListItemState();
}

class _ArticleListItemState extends State<ArticleListItem> {


  _ArticleListItemState();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap:widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.article.thumbnailUrl??'https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_,__,___){
                        return Container(
                            child: Icon(Icons.error),
                          height: 80,
                          width: 80,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/article_icon.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Article ${getDateStr()}',
                                    style: AppTheme().caption(context),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onTapBookmark,
                              child: Image.asset(
                                ArticleController().bookMarks.contains(widget.article)?'assets/save_grey_icon.png':'assets/save_white_icon.png',
                                height: 20,
                                width: 20,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.article.title??'',
                          style: AppTheme().title(context),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.article.description??'',
                          style: AppTheme().caption(context),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Shared by OnLoop',
                style: AppTheme().body1(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      children: List.generate(widget.article.tags?.length??0, (index) {
                        Tag tag = widget.article.tags![index];
                        return Text(
                          tag.name??'',
                          style: AppTheme().body1(context)?.apply(color: getColorByName(tag.color??'')),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/thumbs_up.png', height: 25),
                        const SizedBox(width: 15),
                        Image.asset('assets/thumbs_down.png', height: 25),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String getDateStr() {
    DateTime? date = DateTime.tryParse(widget.article.createdAt??'');
    if(date is DateTime) {
      return DateFormat.yMMMMd('en_US').format(date);
    }
    return '';
  }

  Color getColorByName(String s) {
    if(s == 'red'){
      return AppTheme().red;
    }else if(s == 'green'){
      return AppTheme().green;
    }else if(s == 'yellow'){
      return AppTheme().yellow;
    }
    return AppTheme().red;
  }
}
