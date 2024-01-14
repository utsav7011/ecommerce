import 'package:flutter/material.dart';

import 'appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.btnClr,
    required this.label,
    required this.onPress,
  });
  final Color btnClr;
  final String label;
  final void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: btnClr,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            label,
            style: appstyle(20, btnClr, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
