import 'package:flutter/material.dart';
import 'package:jupiter/src/presentation/pages/more/more_page.dart';
import 'package:jupiter/src/presentation/pages/more/widgets/more_item_menu.dart';

// ignore: must_be_immutable
class MoreListAllItem extends StatelessWidget {
  MoreListAllItem({
    super.key,
    required this.data,
    required this.onPressedItemMenu,
  });

  final List<MoreMenuItemData> data;
  final Function(String) onPressedItemMenu;
  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    if (data.length <= 0) {
      return Column();
    } else {
      for (int i = 0; i < data.length; i++) {
        items.add(MoreItemMenu(
          data: data[i],
          onPressedItemMenu: onPressedItemMenu,
        ));
      }
      return Column(
        children: items,
      );
    }
  }
}
