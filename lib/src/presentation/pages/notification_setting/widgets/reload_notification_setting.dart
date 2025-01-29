import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/cubit/notification_setting_cubit.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReloadNotificationSetting extends StatefulWidget {
  const ReloadNotificationSetting(
      {super.key,
      required this.loadingPage,
      required this.loadingFalse,
      required this.message});

  final bool loadingPage;
  final bool loadingFalse;
  final String message;

  @override
  State<ReloadNotificationSetting> createState() =>
      _ReloadNotificationSettingState();
}

class _ReloadNotificationSettingState extends State<ReloadNotificationSetting> {
  void onTapReload() {
    try {
      BlocProvider.of<NotiSettingCubit>(context).getNotificationSetting();
    } catch (e) {
      debugPrint('Reload Notification Setting Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.loadingPage) {
    //   return Container(
    //     padding: EdgeInsets.symmetric(vertical: 20),
    //     alignment: Alignment.center,
    //     child: Skeletonizer(
    //       child: Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Center(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Bone.text(
    //                       words: 2,
    //                       fontSize: Utilities.sizeFontWithDesityForDisplay(
    //                           context, AppFontSize.big),
    //                     ),
    //                     const SizedBox(height: 8),
    //                     Bone.text(
    //                       words: 1,
    //                       fontSize: Utilities.sizeFontWithDesityForDisplay(
    //                           context, AppFontSize.normal),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Bone.circle(size: 24)
    //             ],
    //           ),
    //           const SizedBox(height: 16),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Center(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Bone.text(
    //                       words: 2,
    //                       fontSize: Utilities.sizeFontWithDesityForDisplay(
    //                           context, AppFontSize.big),
    //                     ),
    //                     const SizedBox(height: 8),
    //                     Bone.text(
    //                       words: 1,
    //                       fontSize: Utilities.sizeFontWithDesityForDisplay(
    //                           context, AppFontSize.normal),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Bone.circle(size: 24)
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // } else
    if (widget.loadingFalse) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: AppTheme.borderGray),
        ),
        child: Column(
          children: [
            TextLabel(
              text: '${widget.message}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              color: AppTheme.gray9CA3AF,
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () => onTapReload(),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  // border: Border.all(color: AppTheme.borderGray),
                  color: AppTheme.blueD,
                ),
                width: 130,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh, color: AppTheme.white, size: 24),
                      SizedBox(width: 8),
                      TextLabel(
                        text: translate('button.try_again'),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                        color: AppTheme.white,
                        // maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
