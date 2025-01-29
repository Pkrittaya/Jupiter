import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';

import '../../../../route_names.dart';
import '../../../widgets/text_label.dart';

class DonotHaveAccountRegister extends StatelessWidget {
  const DonotHaveAccountRegister({
    super.key,
    required this.sizeMedia,
  });

  final Size sizeMedia;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeMedia.height * .056,
      width: sizeMedia.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextLabel(
              color: AppTheme.gray9CA3AF,
              text: translate("login_page.do_not_have_account")),
          TextButton(
            child: TextLabel(
                text: translate("button.register"),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: AppTheme.lightBlue),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.register,
              );
            },
          )
        ],
      ),
    );
  }
}
