import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ModalBottomDeleteNotification extends StatefulWidget {
  const ModalBottomDeleteNotification({
    Key? key,
    required this.onPressedRemove,
    required this.onCloseModal,
  }) : super(key: key);

  final Function() onPressedRemove;
  final Function() onCloseModal;
  @override
  _ModalBottomDeleteNotificationState createState() =>
      _ModalBottomDeleteNotificationState();
}

class _ModalBottomDeleteNotificationState
    extends State<ModalBottomDeleteNotification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          height: 250,
          decoration: const BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerAndIconClose(),
              const SizedBox(height: 16),
              TextLabel(
                text: translate('notification_page.modal.description'),
                color: AppTheme.gray9CA3AF,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 24),
              renderListButton(),
            ],
          ),
        ));
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLabel(
          text: translate('notification_page.modal.title'),
          fontWeight: FontWeight.bold,
          color: AppTheme.black,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
        ),
        Material(
          color: AppTheme.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onCloseModal,
            child: Icon(Icons.close, color: AppTheme.black),
          ),
        )
      ],
    );
  }

  Widget renderListButton() {
    return Container(
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            child: Button(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                backgroundColor: AppTheme.blueD,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              ),
              text: translate('button.remove'),
              onPressed: widget.onPressedRemove,
              textColor: AppTheme.white,
            ),
          ),
          Container(
            width: double.infinity,
            child: Button(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                backgroundColor: AppTheme.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              ),
              text: translate('button.keep'),
              onPressed: widget.onCloseModal,
              textColor: AppTheme.gray9CA3AF,
            ),
          ),
        ],
      ),
    );
  }
}
