import 'package:flutter_translate/flutter_translate.dart';

class ConstValue {
  static const String orgCode = String.fromEnvironment(ORG_CODE);
  static const String androidUpdate = String.fromEnvironment(ANDROID_UPDATE);
  static const String iosUpdate = String.fromEnvironment(IOS_UPDATE);

  static const int countDownOTPCanResend = 3;
  static const String navHome = "Home";
  static const String navStation = "Stations";
  static const String navScan = "Scan";
  static const String navHistory = "History";
  static const String navMore = "Menu";
  static const String navCharging = "Charging";
  static const String prefsRefreshToken = "refreshToken";
  static const String prefsUsername = "username";
  static const String prefsPinCode = "pinCode";
  static const String prefsLanguage = "language";
  static const String prefsNotification = "notification";
  static const String prefsFaceOrTouchId = "faceOrTouchId";
  static const String OUTOFSERVICE = "outofservice";
  static const String AVAILABLE = "available";
  static const String OCCUPIED = "occupied";
  static const String PREPARING = "preparing";
  static const String MAINTENANCE = "maintenance";
  static const String prefsFilterMapList = "filterMapList";
  static const String checkFirstLogin = "checkFirstLogin";
  static const String hasInitNotification = "hasInitNotification";
  static const String filterRecommendedToMap = "recommendedToMap";
  static const String tooltipDistance = "tooltipDistance";
  static const String prefsSupportFaceOrTouchId = "prefsSupportFaceOrTouchId";
  static const String notiToken = "notiToken";
  static const String isLocked = "isLocked";
  static const String ANDROID_UPDATE = "ANDROID_UPDATE";
  static const String IOS_UPDATE = "IOS_UPDATE";
  static const String ORG_CODE = "ORG_CODE";
}

class ConnectorPosition {
  static const String LEFT = "L";
  static const String MIDDLE = "M";
  static const String RIGHT = "R";
}

class CardBrand {
  static const String MASTERCARD = "MASTERCARD";
  static const String VISA = "VISA";
  static const String AMEX = "AMEX";
  static const String DISCOVER = "DISCOVER";
  static const String DINERSCLUB = "DINERSCLUB";
  static const String MAESTRO = "MAESTRO";
  static const String STRIPE = "STRIPE";
  static const String PAYPAL = "PAYPAL";
  static const String INTERAC = "INTERAC";
  static const String VERIFONE = "VERIFONE";
  static const String GOOGLEPAY = "GOOGLEPAY";
  static const String APPLEPAY = "APPLEPAY";
  static const String BITPAY = "BITPAY";
  static const String BITCOIN = "BITCOIN";
  static const String ETHERIUM = "ETHERIUM";
  static const String BITCOINCASH = "BITCOINCASH";
  static const String LIGHTCOIN = "LIGHTCOIN";
  static const String YANDEX = "YANDEX";
  static const String QIWI = "QIWI";
  static const String ELO = "ELO";
  static const String SHOPPAY = "SHOPPAY";
  static const String AMAZONPAY = "AMAZONPAY";
  static const String ALIPAY = "ALIPAY";
  static const String WECHAT = "WECHAT";
  static const String IDEAL = "IDEAL";
  static const String GIROPAY = "GIROPAY";
  static const String UNIONPAY = "UNIONPAY";
  static const String JCB = "JCB";
  static const String WEBMONEY = "WEBMONEY";
  static const String CITADELE = "CITADELE";
  static const String SOFORT = "SOFORT";
  static const String KLARNA = "KLARNA";
  static const String SKRILL = "SKRILL";
  static const String BANCONTACT = "BANCONTACT";
  static const String SEPA = "SEPA";
  static const String FORBRUGSFORENINGEN = "FORBRUGSFORENINGEN";
  static const String PAYONEER = "PAYONEER";
  static const String AFFIRM = "AFFIRM";
  static const String PAYSAFE = "PAYSAFE";
  static const String FACEBOOKPAY = "FACEBOOKPAY";
  static const String POLI = "POLI";
  static const String VENMO = "VENMO";
}

class AppFontSize {
  static const double xxl = 48;
  static const double title = 32;
  static const double huge = 30;
  static const double superlarge = 28;
  static const double normallarge = 26;
  static const double large = 24;
  static const double big = 22;
  static const double normal = 20;
  static const double little = 18;
  static const double small = 16;
  static const double mini = 14;
  static const double supermini = 12;
}

class AppAlertType {
  static const String WARNING = 'WARNING';
  static const String DEFAULT = 'DEFAULT';
  static const String SUCCESS = 'SUCCESS';
}

class ActionPassword {
  static const String FORGOT = 'FORGOT';
  static const String UPDATE = 'UPDATE';
}

class NotificationType {
  static const String SYSTEMS = 'system';
  static const String NEWS = 'news';
  static const String PROMOTION = 'promotions';
}

class MonthWordList {
  static List<String> MONTHS = [
    translate('month.jan'),
    translate('month.feb'),
    translate('month.mar'),
    translate('month.apr'),
    translate('month.may'),
    translate('month.jun'),
    translate('month.jul'),
    translate('month.aug'),
    translate('month.seb'),
    translate('month.oct'),
    translate('month.nov'),
    translate('month.dec'),
  ];
}

class FleetType {
  static const String OPERATION = 'OPERATION';
  static const String CARD = 'CARD';
}

enum Gender { male, female }

class FleetOperationStatus {
  static const String READY = 'READY';
  static const String CHARGING = 'CHARGING';
  static const String RECEIPT = 'RECEIPT';
  static const String CHARGING_RFID = 'CHARGING_RFID';
  static const String CHARGING_AUTOCHARGE = 'CHARGING_AUTOCHARGE';
}

class FleetCardType {
  static const String DEFAULT = 'default';
  static const String FLEET = 'fleet';
  static const String RFID = 'rfid';
  static const String AUTOCHARGE = 'autocharge';
}

class Charging_Auth {
  static const String MOBILE = 'MOBILE';
  static const String RFID = 'RFID';
  static const String EVCC = 'EVCC';
}

class RoutePlanner {
  static const String ROUTE_CURRENT = 'ROUTE_CURRENT';
}
