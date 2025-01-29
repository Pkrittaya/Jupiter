import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ModalSaveRoute extends StatefulWidget {
  ModalSaveRoute({
    Key? key,
    required this.onActionFavorite,
    required this.routeNameController,
  }) : super(key: key);
  final Function(String, String) onActionFavorite;
  final TextEditingController routeNameController;

  @override
  _ModalSaveRouteState createState() => _ModalSaveRouteState();
}

class _ModalSaveRouteState extends State<ModalSaveRoute> {
  bool checkSaveButton = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        height: (MediaQuery.of(context).viewInsets.bottom > 0 ? 240 : 180),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _headerAndIconClose(),
                _inputNameRoute(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.3,
          child: IconButton(
            icon: const Icon(Icons.close, color: AppTheme.black40),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              if (!checkSaveButton) {
                checkSaveButton = true;
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        Expanded(
          child: TextLabel(
            text: translate("map_page.route_planner.save_route"),
            fontWeight: FontWeight.bold,
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextButton(
              onPressed: () {
                if (!checkSaveButton) {
                  if (widget.routeNameController.text != '') {
                    checkSaveButton = true;
                    widget.onActionFavorite('ADD', '');
                    Future.delayed(Duration(milliseconds: 3000), () async {
                      checkSaveButton = false;
                    });
                  }
                }
              },
              child: TextLabel(
                text: translate("map_page.route_planner.done"),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
                color: AppTheme.blueD,
              )),
        ),
      ],
    );
  }

  Widget _inputNameRoute() {
    return Container(
      child: Column(children: [
        TextInputForm(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          controller: widget.routeNameController,
          hintText: translate("map_page.route_planner.route_name"),
          hintStyle: TextStyle(
            color: AppTheme.black60,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
          ),
          style: TextStyle(
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal)),
          fillColor: AppTheme.white,
          borderColor: AppTheme.black40,
          onTap: () {},
          onChanged: (val) {},
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 22,
              color: AppTheme.blueDark,
            ),
            const SizedBox(width: 4),
            TextLabel(
              text: translate("map_page.route_planner.save_to_favorite"),
              textAlign: TextAlign.left,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            )
          ],
        )
      ]),
    );
  }
}
