import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class Facility extends StatefulWidget {
  const Facility({
    super.key,
    required this.data,
    required this.onExpansionChanged,
  });

  final List<String> data;
  final Function(bool) onExpansionChanged;

  @override
  State<Facility> createState() => _FacilityState();
}

class _FacilityState extends State<Facility>
    with SingleTickerProviderStateMixin {
  TextEditingController eneryOptionController = TextEditingController();
  late TabController _tabOptionController;
  final Color _activeColor = AppTheme.white;
  final Color _normalColor = AppTheme.black40;

  int _index = 0;
  @override
  void initState() {
    initTabController();
    super.initState();
  }

  void initTabController() {
    _tabOptionController = TabController(length: 4, vsync: this);
    _tabOptionController.addListener(() {
      if (!_tabOptionController.indexIsChanging) {
        // Your code goes here.
        // To get index of current tab use tabController.index
        _index = _tabOptionController.index;
        setState(() {});
      }
    });
  }

  Color indexColor(int index) {
    return index == _index ? _activeColor : _normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: widget.onExpansionChanged,
      tilePadding: EdgeInsets.zero,
      shape: const Border(),
      collapsedIconColor: AppTheme.blueDark,
      title: TextLabel(
        text: translate("charging_page.facility"),
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
        fontWeight: FontWeight.w700,
        color: AppTheme.blueDark,
      ),
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.grayD4A50),
            ),
            child: renderItemFacility()),
      ],
    );
  }

  Widget renderItemFacility() {
    final sizeMedia = MediaQuery.of(context).size;
    final items = widget.data;
    return Column(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: (sizeMedia.width - 48) / 6,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext ctx, index) {
            final icon = items[index];
            return Container(
              // padding: const EdgeInsets.all(8), // Border width
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  child: ImageNetworkJupiter(
                    url: icon,
                    fit: BoxFit.cover,
                  ),
                  // Image.network(
                  //   icon,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget renderItemFacilityCenter() {
  //   final items = widget.data;
  //   double runSpacing = 4;
  //   double spacing = 4;
  //   int listSize = 15;
  //   final columns = 7;
  //   final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
  //       columns;
  //   return Column(
  //     children: [
  //       Wrap(
  //         runSpacing: runSpacing,
  //         spacing: spacing,
  //         alignment: WrapAlignment.center,
  //         children: List.generate(items.length, (index) {
  //           final icon = items[index];
  //           return Container(
  //             // padding: const EdgeInsets.all(8), // Border width
  //             decoration: const BoxDecoration(
  //               color: Colors.transparent,
  //               shape: BoxShape.circle,
  //             ),
  //             child: ClipOval(
  //               child: SizedBox.fromSize(
  //                 child: Image.network(
  //                   icon,
  //                   fit: BoxFit.cover,
  //                   width: w,
  //                   height: w,
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //       ),
  //     ],
  //   );
  // }
}
