import 'package:chandresh_practicle/pages/articles/controller/article_controller.dart';
import 'package:chandresh_practicle/pages/articles/ui/article_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/string.dart';
import 'common/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ArticleController>(create: (_) => ArticleController()),
      ],
      child: MaterialApp(
        title: Strings().appName,
        theme: AppTheme().getLightTheme(context),
        debugShowCheckedModeBanner: false,
        home: const ArticleListPage(),
      ),
    );
  }
}
