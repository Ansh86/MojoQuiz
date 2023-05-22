import 'package:flutter/material.dart';
import 'package:teraquiz/configs/themes/app_colors.dart';
import 'package:teraquiz/configs/themes/ui_parameters.dart';

class ContentAread extends StatelessWidget {
  final bool addPadding;
  final Widget child;
  const ContentAread({Key? key,
     this.addPadding=true,
    required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: customScaffoldColor(context),
        ),
        padding: addPadding?
        EdgeInsets.only(
            top: mobileScreenPadding,
            left: mobileScreenPadding,
            right: mobileScreenPadding,
        ):EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
