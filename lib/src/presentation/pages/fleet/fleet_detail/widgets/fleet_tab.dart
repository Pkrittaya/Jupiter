import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class FleetTab extends StatefulWidget {
  const FleetTab({
    Key? key,
    required this.fleetType,
    required this.onPressedTab,
    required this.tabController,
    required this.selectedTab,
  }) : super(key: key);

  final String fleetType;
  final Function(int) onPressedTab;
  final TabController tabController;
  final int selectedTab;

  @override
  _FleetTabState createState() => _FleetTabState();
}

class _FleetTabState extends State<FleetTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Material(
              child: TabBar(
                unselectedLabelColor: AppTheme.white,
                indicatorColor: AppTheme.blueDark,
                controller: widget.tabController,
                labelPadding: const EdgeInsets.all(0.0),
                tabs: [
                  Tab(
                    child: SizedBox.expand(
                      child: Container(
                        child: Center(
                          child: TextLabel(
                            text: translate('fleet_page.tab.charging_station'),
                            color: (widget.selectedTab == 0
                                ? AppTheme.blueDark
                                : AppTheme.gray9CA3AF),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.large),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(color: AppTheme.white),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox.expand(
                      child: Container(
                        child: Center(
                          child: TextLabel(
                            text: translate('fleet_page.tab.history'),
                            color: (widget.selectedTab == 1
                                ? AppTheme.blueDark
                                : AppTheme.gray9CA3AF),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.large),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(color: AppTheme.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
