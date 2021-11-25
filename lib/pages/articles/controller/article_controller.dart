import 'dart:convert';

import 'package:chandresh_practicle/common/constants.dart';
import 'package:chandresh_practicle/models/article_model.dart';
import 'package:chandresh_practicle/models/tag_model.dart';
import 'package:chandresh_practicle/repositories/article_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleController extends ChangeNotifier {
  static final ArticleController _singleton = ArticleController._internal();
  ArticleController._internal();
  factory ArticleController() {
    return _singleton;
  }

  ArticleRepository articleRepository = ArticleRepository();

  bool _isLoading = true;
  List<Article> _articleList = [];
  List<Article> bookMarks = [];
  List<Tag> _tagList = [];

  Tag? _selectedTag;


  Tag? get selectedTag => _selectedTag;

  set setSelectedTag(Tag? value) {
    _selectedTag = value;
    Future.delayed(Duration.zero).then((value) => notifyListeners());
  }

  List<Tag> get tagList => _tagList;

  List<Article> get articleList => _articleList;

  bool get isLoading => _isLoading;

  set tagList(List<Tag> value) {
    _tagList = value;
    Future.delayed(Duration.zero).then((value) => notifyListeners());
  }

  set articleList(List<Article> value) {
    _articleList = value;
    Future.delayed(Duration.zero).then((value) => notifyListeners());
  }

  set isLoading(bool value) {
    _isLoading = value;
    Future.delayed(Duration.zero).then((value) => notifyListeners());
  }

  init() async {
    isLoading = true;
    await getTagList();
    await getArticleList();
    await getBookMarks();
    isLoading = false;
  }

  Future getArticleList() async {

    try {
      articleList = [];
      bool isInternet = await Constants.isInternet();
      if(isInternet) {
        List<Article>? articles = await articleRepository.getArticles();
        if (articles?.isNotEmpty ?? false) {
          articleList = articles!;
        }
      }
    } catch (e) {
      debugPrint('Some thing went wrong $e');
    }
  }

  Future getTagList() async {
    try {
      tagList = [];
      bool isInternet = await Constants.isInternet();
      if(isInternet) {
        List<Tag>? tags = await articleRepository.getTags();
        if (tags?.isNotEmpty ?? false) {
          tagList = tags!;
        }
      }
    } catch (e) {
      debugPrint('Some thing went wrong $e');
    }
  }

  Future addToBookMark(Article article) async{
    if(bookMarks.contains(article)){
      bookMarks.remove(article);
    }else{
      bookMarks.add(article);
    }
    List lst = bookMarks.map((e) => e.toMap()).toList();
    String strJson = jsonEncode(lst);
    SharedPreferences pref = await SharedPreferences.getInstance();
    notifyListeners();
    return await pref.setString(Constants.PREF_BOOK,strJson);
  }

  Future<List<Article>> getBookMarks() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? json = pref.getString(Constants.PREF_BOOK);
    if(json is String){
      var decoded = jsonDecode(json);
      if(decoded is List){
        bookMarks =  decoded.map((e) => Article.fromMap(e)).toList();
        return bookMarks;
      }
    }
    return [];
  }
}
