import 'package:flutter/material.dart';
import 'package:teraquiz/configs/themes/app_colors.dart';
import 'package:get/get.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final  enabled;
  final Widget? child;
  final Color? color;

  const MainButton({Key? key,
    this.title=" ",
    required this.onTap,
    this.enabled=true,
    this.child,
    this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
    child: SizedBox(
      height: 55,
      child: InkWell(

          onTap: enabled==false?null: onTap,

          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color??Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: child??Center(
                child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode? onSurfaceTextColor:Theme.of(context).primaryColor,

                  ),),
              ),
            ),
          ),


      ),
    ),
    );
  }
}
