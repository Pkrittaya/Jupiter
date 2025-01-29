import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../../route_names.dart';

class ButtonAtBottom extends StatefulWidget {
  const ButtonAtBottom({
    super.key,
    required StationDetailEntity? stationDetailEntity,
    this.fromMapPage,
    required this.isLoading,
  }) : _stationDetailEntity = stationDetailEntity;

  final StationDetailEntity? _stationDetailEntity;
  final bool? fromMapPage;
  final bool isLoading;
  @override
  State<ButtonAtBottom> createState() => _ButtonAtBottomState();
}

class _ButtonAtBottomState extends State<ButtonAtBottom> {
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  void onPressedNavigation() {
    debugPrint("Direction : lat ${widget._stationDetailEntity?.position[0]}");
    debugPrint("Direction : lng ${widget._stationDetailEntity?.position[1]}");
    Utilities.mapNavigateTo(widget._stationDetailEntity?.position[0] ?? 0,
        widget._stationDetailEntity?.position[1] ?? 0);
  }

  void onPressedBookingNow() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         BookingPage(stationData: widget._stationDetailEntity),
    //   ),
    // );
  }

  void onPressedCheckin() {
    Navigator.pushNamed(context, RouteNames.scan_qrcode);
  }

  void navigateRoutePlanner() {
    jupiterPrefsAndAppData.navigateRoutePlanner = true;
    jupiterPrefsAndAppData.detailForRoute = widget._stationDetailEntity;
    Navigator.of(context).pop();
    Future.delayed(const Duration(milliseconds: 50), () {
      (jupiterPrefsAndAppData.onTapIndex ?? () {})(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !widget.isLoading,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.white,
            border: Border(
              top: BorderSide(width: 1, color: AppTheme.borderGray),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.blueD,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      side: const BorderSide(
                        width: 1.0,
                        color: AppTheme.blueD,
                      ),
                    ),
                    onPressed: navigateRoutePlanner,
                    icon: SvgPicture.asset(
                      ImageAsset.ic_navigate_route,
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      translate('map_page.route_planner.route'),
                      style: TextStyle(
                          color: AppTheme.white,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.big)),
                    ), // <-- Text
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Container(
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      side: const BorderSide(
                        width: 1.0,
                        color: AppTheme.lightBlue,
                      ),
                    ),
                    onPressed: onPressedNavigation,
                    icon: SvgPicture.asset(
                      // ImageAsset.ic_booking_outline,
                      ImageAsset.ic_navigation,
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      // translate('station_details_page.button.book_now'),
                      translate('station_details_page.button.get_direction'),
                      style: TextStyle(
                          color: AppTheme.lightBlue,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.big)),
                    ), // <-- Text
                  ),
                ),
              ),
              const SizedBox(width: 18),
              InkWell(
                onTap: onPressedCheckin,
                child: Container(
                  height: 50,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.blueD,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.gray9CA3AF,
                        blurRadius: 1,
                        offset: Offset(0.5, 1.5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      ImageAsset.ic_qr_code,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
