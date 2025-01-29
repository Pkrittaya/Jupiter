import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class MovePin extends StatefulWidget {
  const MovePin(
      {Key? key,
      required this.onSetModalInRoutePlannerPage,
      required this.onPressedAddMarker,
      required this.floatLocation,
      required this.placemark,
      required this.currentMapPosition,
      required this.loadingLocation})
      : super(key: key);

  final Function(String, bool) onSetModalInRoutePlannerPage;
  final Function(String) onPressedAddMarker;
  final Widget floatLocation;
  final Placemark placemark;
  final LatLng currentMapPosition;
  final bool loadingLocation;

  @override
  State<MovePin> createState() => _MovePinState();
}

class _MovePinState extends State<MovePin> {
  bool addLocation = true;
  String country = "TH";

  String getNameMovePin() {
    try {
      if (widget.placemark.street != null && widget.placemark.street == '') {
        return '${widget.currentMapPosition.latitude},${widget.currentMapPosition.longitude}';
      } else {
        return '${widget.placemark.street}';
      }
    } catch (e) {
      debugPrint('Error getNameMovePin : $e');
      return '';
    }
  }

  bool getAvailableArea() {
    try {
      if (widget.placemark.isoCountryCode != null &&
          widget.placemark.isoCountryCode == country &&
          widget.placemark.postalCode != '') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error getCountryMovePin : $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  widget.onSetModalInRoutePlannerPage('MOVEPIN', false);
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppTheme.black.withOpacity(0.7),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: AppTheme.white,
                        size: 20,
                      ),
                    )),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: TextLabel(
                  text: translate("map_page.route_planner.drop_pin"),
                  fontSize: AppFontSize.normal,
                  color: AppTheme.black60,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SvgPicture.asset(
                ImageAsset.ic_pin_marker,
                width: 45,
                height: 45,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: addLocation ? 130 : 110,
          left: 16,
          right: 16,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: widget.floatLocation,
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: addLocation,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: widget.loadingLocation
                        ? Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppTheme.blueD,
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              TextLabel(
                                text: getAvailableArea()
                                    ? '${getNameMovePin()}'
                                    : translate(
                                        "map_page.route_planner.not_service_area"),
                                fontSize: AppFontSize.big,
                                fontWeight: FontWeight.bold,
                                color: getAvailableArea()
                                    ? AppTheme.blueDark
                                    : AppTheme.gray9CA3AF,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              (getNameMovePin() != '')
                                  ? InkWell(
                                      onTap: () {
                                        if (getAvailableArea()) {
                                          widget.onPressedAddMarker('');
                                          widget.onSetModalInRoutePlannerPage(
                                              'MOVEPIN', false);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: getAvailableArea()
                                              ? AppTheme.blueD
                                              : AppTheme.gray9CA3AF,
                                          border: Border.all(
                                              color: getAvailableArea()
                                                  ? AppTheme.blueD
                                                  : AppTheme.gray9CA3AF,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(200)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppTheme.gray9CA3AF,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              ImageAsset.ic_pin_marker_white,
                                              width: 16,
                                              height: 16,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            TextLabel(
                                              text: translate(
                                                  "map_page.route_planner.add_location"),
                                              color: AppTheme.white,
                                              fontSize: Utilities
                                                  .sizeFontWithDesityForDisplay(
                                                      context,
                                                      AppFontSize.normal),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
