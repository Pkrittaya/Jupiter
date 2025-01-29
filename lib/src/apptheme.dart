import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color black = Color(0xFF121212);
  static const Color black80 = Color(0xFF414141);
  static const Color black60 = Color(0xFF717171);
  static const Color black40 = Color(0xFFA0A0A0);
  static const Color black20 = Color(0xFFD0D0D0);
  static const Color black5 = Color(0xFFF3F3F3);

  static const Color grayD4A50 = Color(0x80D4D4DF);
  static const Color grayD1D5DB = Color(0x80D1D5DB);
  static const Color gray9CA3AF = Color(0xFF9CA3AF);
  static const Color grayF1F5F9 = Color(0xFFF1F5F9);
  static const Color borderGray = Color(0xFFE5E7EB);

  static const Color white = Color(0xFFFFFFFF);

  static const Color lightBlue = Color(0xFF009DDE);
  static const Color lightBlue80 = Color(0xFF33B1E5);
  static const Color lightBlue60 = Color(0xFF66C4EB);
  static const Color lightBlue40 = Color(0xFF99D8F2);
  static const Color lightBlue20 = Color(0xFFCCEBF8);
  static const Color lightBlue10 = Color(0xFFEDF7FD);

  static const Color lightBlue20Alpha50 = Color(0x80CCEBF8);
  static const Color lightButtonChargingEnergy = Color(0xFFF1F5F9);
  static const Color lightButtonTextChargingEnergy = Color(0xFF4CAAE8);
  static const Color lightTextFieldChargingEnergy = Color(0xFFEDF7FD);

  static const Color darkBlue = Color(0xFF26285E);
  static const Color darkBlue80 = Color(0xFF51537E);
  static const Color darkBlue60 = Color(0xFF7D7E9E);
  static const Color darkBlue40 = Color(0xFFA8A9BF);
  static const Color darkBlue20 = Color(0xFFD4D4DF);

  static const Color red = Color(0xFFDF2626);
  static const Color red80 = Color(0xFFE55151);
  static const Color red60 = Color(0xFFEC7D7D);
  static const Color red40 = Color(0xFFF2A8A8);
  static const Color red20 = Color(0xFFF9D4D4);

  static const Color redC92D2D = Color(0xFFC92D2D);

  static const Color green = Color(0xFF1CA52A);
  static const Color green80 = Color(0xFF4AB754);
  static const Color green60 = Color(0xFF77C97F);
  static const Color green40 = Color(0xFFA4DBAA);
  static const Color green20 = Color(0xFFD2EDD4);

  static const Color pttBlue = Color(0xFF007EB5);
  static const Color pttBlue80 = Color(0xFF3398C4);
  static const Color pttBlue60 = Color(0xFF66B2D3);
  static const Color pttBlue40 = Color(0xFF99CBE1);
  static const Color pttBlue20 = Color(0xFFCCE5F0);

  static const Color yellow = Color(0xFFFFFD38);
  static const Color yellow80 = Color(0xFFFFFE60);
  static const Color yellow60 = Color(0xFFFFFE88);
  static const Color yellow40 = Color(0xFFFFFEAF);
  static const Color yellow20 = Color(0xFFFFFFD7);
  static const Color yellowPending = Color(0xFFFBAB4A);

  static const Color orange = Color(0xFFFF8038);
  static const Color orange80 = Color(0xFFFF9960);
  static const Color orange60 = Color(0xFFFFB388);
  static const Color orange40 = Color(0xFFFFCCAF);
  static const Color orange20 = Color(0xFFFFE5D7);

  static const Color transparent = Colors.transparent;

  static const Color blueSplashPin = Color(0xFFC8E5F8);

  static const Color blueD = Color(0xFF4CAAE8);

  static const Color blueLight = Color(0xFFE6F8FF);
  static const Color blueLightHover = Color(0xFFD9F4FF);
  static const Color blueLightActive = Color(0xFFB1E8FF);
  static const Color blueNormal = Color(0xFF02B5FF);
  static const Color blueNormalHover = Color(0xFF02B3E6);
  static const Color blueNormalActive = Color(0xFF0291CC);
  static const Color blueDark = Color(0xFF0288BF);
  static const Color blueDarkHover = Color(0xFF016D99);
  static const Color blueDarkActive = Color(0xFF015173);
  static const Color blueDarker = Color(0xFF013F59);

  static const Color lightBlueProgress = Color(0xFF66C4EB);
  static const Color brown = Color(0xFF99582A);

  static ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.lightBlue,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
  static ButtonStyle darkBlueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.darkBlue,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.white,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    side: const BorderSide(
      width: 1.0,
      color: AppTheme.lightBlue,
    ),
  );
  static ButtonStyle disableButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.black20,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  static ButtonStyle rejectButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.red,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  static ButtonStyle stopChargingStyle = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.redC92D2D,
    minimumSize: const Size(88, 36),
    padding: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
  );
  static ButtonStyle whiteButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppTheme.white,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    side: const BorderSide(
      width: 1.0,
      color: AppTheme.white,
    ),
  );
  static const double appBarHeight = 56.0;
}
