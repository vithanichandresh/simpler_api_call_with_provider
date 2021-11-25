import 'package:chandresh_practicle/models/tag_model.dart';

class Article {
  String? createdAt;
  String? type;
  String? title;
  String? description;
  String? thumbnailUrl;
  String? contentUrl;
  List<Tag>? tags;

  Article({
    this.createdAt,
    this.type,
    this.title,
    this.description,
    this.thumbnailUrl,
    this.contentUrl,
    this.tags,
  });

  Article.clone(Article article){
    createdAt = article.createdAt;
    type = article.type;
    title = article.title;
    description = article.description;
    thumbnailUrl = article.thumbnailUrl;
    contentUrl = article.contentUrl;
    tags = article.tags?.map((e) => Tag.clone(e)).toList();
  }

  Article.fromMap(Map map){
    if(map['created_at'] is String){
      createdAt = map['created_at'];
    }

    if(map['type'] is String){
      type = map['type'];
    }

    if(map['title'] is String){
      title = map['title'];
    }

    if(map['description'] is String){
      description = map['description'];
    }

    if(map['thumbnail_url'] is String){
      thumbnailUrl = map['thumbnail_url'];
    }

    if(map['content_url'] is String){
      contentUrl = map['content_url'];
    }

    if(map['tags'] is List){
      List lst = map['tags'];
      tags = lst.map((e) => Tag.fromMap(e)).toList();
    }
  }

  Map toMap(){
    return {
      'created_at':createdAt,
      'type':createdAt,
      'title':title,
      'description':description,
      'thumbnailUrl':thumbnailUrl,
      'contentUrl':contentUrl,
      'tags':tags?.map((e) => e.toMap()).toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article &&
          runtimeType == other.runtimeType &&
          createdAt == other.createdAt &&
          title == other.title;

  @override
  int get hashCode => createdAt.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'Article{ title: $title}';
  }
}
