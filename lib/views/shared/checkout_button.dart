import 'package:flutter/material.dart';

import 'appstyle.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              label,
              style: appstyle(20, Colors.white, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
