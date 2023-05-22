import 'package:flutter/material.dart';
import 'package:teraquiz/configs/themes/app_colors.dart';
import 'package:teraquiz/configs/themes/custom_text_styles.dart';
import 'package:teraquiz/configs/themes/ui_parameters.dart';
import 'package:teraquiz/screens/question/test_overview.dart';
import 'package:teraquiz/widgets/app_circle_button.dart';
import 'package:teraquiz/widgets/app_icon.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key,
   this.title='',
    this.titleWidget,
    this.showActionIcon=false,
    this.onMenuActionTap,
    this.leading
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final bool showActionIcon;
  final Widget? leading;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mobileScreenPadding,
          vertical: mobileScreenPadding),
          child: Stack(
            children: [
              Positioned.fill(
                  child: titleWidget==null?Center(
                    child: Text(title, style: appBarTS,),
                  ) :Center(child: titleWidget,)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading??Transform.translate(offset: const Offset(-14, 0),
                  child: const BackButton(),),
                  if(showActionIcon)
                    Transform.translate(offset: const Offset(10, 0),
                    child: IconButton(

                      icon:Icon(AppIcons.menu, color: onSurfaceTextColor,),
                      onPressed:onMenuActionTap??()=>Get.toNamed(TestOverView.routeName),
                      iconSize: 19,


                    ),),
                ],
              )
            ],
          ),
        )
    ) ;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
