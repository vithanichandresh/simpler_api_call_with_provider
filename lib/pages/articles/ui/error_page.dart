import 'package:chandresh_practicle/common/string.dart';
import 'package:chandresh_practicle/common/theme.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? title;
  final String? message;
  const ErrorPage({Key? key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title??Strings().oops,style: AppTheme().title(context),),
          const SizedBox(height: 10),
          Text(title??Strings().notFound,style: AppTheme().body1(context)),
        ],
      ),
    );
  }
}
