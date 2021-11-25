import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double? height;
  final double? width;
  const Loader({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?? MediaQuery.of(context).size.height /1.5,
      width: width??MediaQuery.of(context).size.width,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
