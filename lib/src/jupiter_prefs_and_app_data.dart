//load data from share pref
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JupiterPrefsAndAppData {
  JupiterPrefsAndAppData({
    required this.prefs,
  });

  String? refreshToken;
  bool? language;
  String? pinCode;
  String? username;
  bool? notification;
  bool? faceOrTouchId;
  bool? supoortFaceOrTouchId;
  List<String>? filterMapList;
  final SharedPreferences prefs;
  String? deviceId;
  bool? tooltipDistance;
  String? filterRecommendedToMap;
  bool? hasInitNotification;
  bool? checkFirstLogin;
  bool navigateRoutePlanner = false;
  FavoriteRouteItemEntity? routeFavorite;
  Function(int)? onTapIndex;
  FlutterSecureStorage? flutterSecureStorage;
  StationDetailEntity? detailForRoute;
  String notiToken = '';
  bool isLocked = false;

  Future<void> initSharePrefsValue() async {
    debugPrint("initSharePrefsValueStart");
    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    flutterSecureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    // prefs = await SharedPreferences.getInstance();
    refreshToken = await getRefreshToken();
    language = await getSettingLanguage();
    pinCode = await getPinCode();
    username = await getUsername();
    notification = await getSettingNotification();
    faceOrTouchId = await getSettingFaceOrTouchId();
    supoortFaceOrTouchId = await getSupportFaceOrTouchId();
    filterMapList = await getFilterMapList();
    deviceId = await getDeviceId();

    tooltipDistance = await getToolTipDistance();
    filterRecommendedToMap = await getFilterRecommendedToMap();
    notiToken = await getNotiToken();

    debugPrint("initSharePrefsValueRefreshToken $refreshToken");
  }

  void saveFilterMapList(List<String> filterMap) async {
    this.filterMapList = filterMap;
    await prefs.setStringList(ConstValue.prefsFilterMapList, filterMap);
    debugPrint('SaveFilter : $filterMap');
  }

  Future<List<String>?> getFilterMapList() async {
    List<String>? filterMap =
        await prefs.getStringList(ConstValue.prefsFilterMapList);

    return filterMap;
  }

  void saveRefreshToken(String refreshToken) async {
    this.refreshToken = refreshToken;
    await flutterSecureStorage?.write(
        key: ConstValue.prefsRefreshToken, value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    debugPrint("getRefreshToken");

    // #####
    //todo remove refreshOld after user change version
    String? refreshOld = await prefs.getString(ConstValue.prefsRefreshToken);
    if (!(refreshOld == null || refreshOld.isEmpty)) {
      saveRefreshToken(refreshOld);
      await prefs.remove(ConstValue.prefsRefreshToken);
    }
    //#######
    String? refreshToken =
        await flutterSecureStorage?.read(key: ConstValue.prefsRefreshToken);
    return refreshToken;
  }

  void saveUsername(String username) async {
    this.username = username;
    await prefs.setString(ConstValue.prefsUsername, username);
  }

  Future<String?> getUsername() async {
    String? username = prefs.getString(ConstValue.prefsUsername);
    return username;
  }

  void savePinCode(String pinCode) async {
    this.pinCode = encrypt(pinCode);
    await flutterSecureStorage?.write(
        key: ConstValue.prefsPinCode, value: encrypt(pinCode));
  }

  void removePinCode() async {
    pinCode = null;
    await flutterSecureStorage?.delete(key: ConstValue.prefsPinCode);
  }

  Future<String?> getPinCode() async {
    // #####
    //todo remove pincodeOld after user change version
    String? pinCodeOld = await prefs.getString(ConstValue.prefsPinCode);
    if (!(pinCodeOld == null || pinCodeOld.isEmpty)) {
      await flutterSecureStorage?.write(
          key: ConstValue.prefsPinCode, value: pinCodeOld);
      await prefs.remove(ConstValue.prefsPinCode);
    }
    // #####
    String? pinCode =
        await flutterSecureStorage?.read(key: ConstValue.prefsPinCode);
    debugPrint("GPinCode $pinCode");
    return pinCode;
  }

  void saveSettingLanguage(bool language) async {
    this.language = language;
    await prefs.setBool(ConstValue.prefsLanguage, language);
  }

  Future<bool?> getSettingLanguage() async {
    bool? language = prefs.getBool(ConstValue.prefsLanguage);
    return language;
  }

  void saveSettingNotification(bool notification) async {
    this.notification = notification;
    await prefs.setBool(ConstValue.prefsNotification, notification);
  }

  Future<bool?> getSettingNotification() async {
    bool? notification = prefs.getBool(ConstValue.prefsNotification);
    return notification;
  }

  void saveSettingFaceOrTouchId(bool faceOrTouchId) async {
    this.faceOrTouchId = faceOrTouchId;
    await prefs.setBool(ConstValue.prefsFaceOrTouchId, faceOrTouchId);
  }

  Future<bool?> getSettingFaceOrTouchId() async {
    bool? faceOrTouchId = prefs.getBool(ConstValue.prefsFaceOrTouchId);
    return faceOrTouchId;
  }

  void setSupportFaceOrTouchId(bool support) async {
    this.supoortFaceOrTouchId = support;
    await prefs.setBool(ConstValue.prefsSupportFaceOrTouchId, support);
  }

  Future<bool?> getSupportFaceOrTouchId() async {
    bool? faceOrTouchId = prefs.getBool(ConstValue.prefsSupportFaceOrTouchId);
    return faceOrTouchId;
  }

  String encrypt(String text) {
    var bytes = utf8.encode(text); // data being hashed

    var digest = sha256.convert(bytes);

    // print("Digest as bytes: ${digest.bytes}");
    // print("Digest as hex string: $digest");
    return digest.toString();
  }

  Future<String?> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    debugPrint('deviceId $deviceId');
    return deviceId;
  }

  Future<bool?> getToolTipDistance() async {
    bool? tooltipDistance = prefs.getBool(ConstValue.tooltipDistance);
    return tooltipDistance;
  }

  void setToolTipDistance(bool tooltipDistance) async {
    this.tooltipDistance = tooltipDistance;
    await prefs.setBool(ConstValue.tooltipDistance, tooltipDistance);
  }

  Future<String?> getFilterRecommendedToMap() async {
    String? filterRecommendedToMap =
        prefs.getString(ConstValue.filterRecommendedToMap);
    return filterRecommendedToMap;
  }

  void setFilterRecommendedToMap(String recommended) async {
    this.filterRecommendedToMap = recommended;
    await prefs.setString(ConstValue.filterRecommendedToMap, recommended);
  }

  void removeFilterRecommendedToMap() async {
    filterRecommendedToMap = null;
    await prefs.remove(ConstValue.filterRecommendedToMap);
  }

  Future<bool?> getCheckFirstLogin() async {
    bool? checkFirstLogin = prefs.getBool(ConstValue.checkFirstLogin);
    return checkFirstLogin;
  }

  void setCheckFirstLogin(bool checkFirstLogin) async {
    this.checkFirstLogin = checkFirstLogin;
    await prefs.setBool(ConstValue.checkFirstLogin, checkFirstLogin);
  }

  void removeCheckFirstLogin() async {
    checkFirstLogin = null;
    await prefs.remove(ConstValue.checkFirstLogin);
  }

  void funcOnTapIndex(Function(int)? onTap) {
    onTapIndex = onTap;
  }

  Future<bool?> getHasInitNotification() async {
    bool? hasInitNotification = prefs.getBool(ConstValue.hasInitNotification);
    return hasInitNotification;
  }

  void setHasInitNotification(bool hasInitNotification) async {
    this.hasInitNotification = hasInitNotification;
    await prefs.setBool(ConstValue.hasInitNotification, hasInitNotification);
  }

  void removeHasInitNotification() async {
    hasInitNotification = null;
    await prefs.remove(ConstValue.hasInitNotification);
  }

  Future<String> getNotiToken() async {
    String notiToken = prefs.getString(ConstValue.notiToken) ?? '';
    return notiToken;
  }

  void setNotiToken(String notiToken) async {
    this.notiToken = notiToken;
    await prefs.setString(ConstValue.notiToken, notiToken);
  }

  void removeNotiToken() async {
    notiToken = '';
    await prefs.remove(ConstValue.notiToken);
  }

  Future<bool> getIsLocked() async {
    bool isLocked = prefs.getBool(ConstValue.isLocked) ?? false;
    return isLocked;
  }

  void setIsLocked(bool isLocked) async {
    this.isLocked = isLocked;
    await prefs.setBool(ConstValue.isLocked, isLocked);
  }
}
