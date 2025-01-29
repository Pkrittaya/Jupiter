import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../../route_names.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //* Forgot password *//
          Container(
            width: 100,
            child: TextButton(
              child: TextLabel(
                // textDecoration: TextDecoration.underline,
                text: translate("login_page.forgot_password"),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                color: AppTheme.lightBlue,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.forgot_password);
              },
            ),
          ),
          TextLabel(
              text: translate("login_page.or"),
              color: AppTheme.gray9CA3AF,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big)),
          //* Resend verify email *//
          Container(
            width: 175,
            child: TextButton(
              child: TextLabel(
                // textDecoration: TextDecoration.underline,
                text: translate("login_page.resent_verify_email"),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                color: AppTheme.lightBlue,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ForgotPasswordPage(verifyemail: true)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
