import 'dart:convert';

import 'package:chandresh_practicle/common/constants.dart';
import 'package:chandresh_practicle/models/article_model.dart';
import 'package:chandresh_practicle/models/tag_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class ArticleRepository {
  Future<List<Article>?> getArticles() async {
    try {
      Response response = await get(Uri.parse(Constants.BASE_URL + '742454fc-089b-47df-b7c1-4c1ce4091586'));

      if (response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        List list = map['learn_content']??[];
        return list.map((e) => Article.fromMap(e)).toList();
      }
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  Future<List<Tag>?> getTags() async {
    try {
      Response response = await get(Uri.parse(Constants.BASE_URL + 'c498ac6a-5be7-4ac3-b407-b703af3e2247'));
      if (response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        List list = map['tags']??[];
        return list.map((e) => Tag.fromMap(e)).toList();
      }
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }
}
