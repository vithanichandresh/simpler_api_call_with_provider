import 'package:chandresh_practicle/common/theme.dart';
import 'package:flutter/material.dart';

class TagView extends StatelessWidget {
  final String title;
  final Color color;
  final GestureTapCallback onTap;
  final bool? isSelected;
  final EdgeInsets? padding;

  const TagView(
      {Key? key, required this.title, required this.color, required this.onTap,  this.isSelected, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        padding: padding,
        label: Row(
          children: [
            Text(
              title,
              style: AppTheme().body1(context)?.copyWith(color: color),
            ),
            Visibility(
              visible: isSelected??false,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.close,size: 15,color: color),
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: (isSelected??false)?color:Colors.transparent),
        ),
        backgroundColor: color.withOpacity(0.2),
      ),
    );
  }
}
