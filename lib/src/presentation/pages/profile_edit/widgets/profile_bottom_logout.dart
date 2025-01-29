// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ProfileBottomLogout extends StatefulWidget {
  const ProfileBottomLogout({
    super.key,
    required this.versionApp,
    required this.heightBottom,
    required this.onPressedLogout,
    required this.isLogoutProcess,
  });

  final String versionApp;
  final double heightBottom;
  final Function() onPressedLogout;
  final bool isLogoutProcess;

  @override
  _ProfileBottomLogoutState createState() => _ProfileBottomLogoutState();
}

class _ProfileBottomLogoutState extends State<ProfileBottomLogout> {
  double heightChangeImageProgile = 230;
  DateTime? lastTap;
  int counter = 0;
  String? fcmToken = '';
  @override
  void initState() {
    initFirebaseFcm();
    super.initState();
  }

  Future<void> initFirebaseFcm() async {
    // final firebaseMessaging = FirebaseMessaging.instance;
    // fcmToken = await firebaseMessaging.getToken();
    // debugPrint('FIREBASE TOKEN : ${fcmToken}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      width: double.infinity,
      height: widget.heightBottom,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          widget.isLogoutProcess
              ? Container(
                  padding: EdgeInsets.all(14),
                  width: 43,
                  height: 43,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.blueD,
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                )
              : Material(
                  color: AppTheme.white,
                  child: InkWell(
                    onTap: widget.onPressedLogout,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextLabel(
                        text: translate('profile_page.button.logout'),
                        color: AppTheme.gray9CA3AF,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context,
                          AppFontSize.big,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () async {
              // final currentTap = DateTime.now();
              // if (lastTap == null ||
              //     currentTap.difference(lastTap!) <
              //         const Duration(seconds: 1)) {
              //   lastTap = currentTap;
              //   counter++;
              //   if (counter == 5) {
              //     await Clipboard.setData(ClipboardData(text: fcmToken ?? ''));
              //     counter = 0;
              //     debugPrint("Copy to clipboard $fcmToken");
              //   }
              // } else {
              //   counter = 0;
              // }
            },
            child: TextLabel(
              text: widget.versionApp,
              color: AppTheme.black40,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                context,
                AppFontSize.little,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
