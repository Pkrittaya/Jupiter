import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/internet_signal.dart';
import 'package:jupiter/src/presentation/widgets/lifecycle_watcher_state.dart';

class CheckInternetSignal extends StatefulWidget {
  const CheckInternetSignal(
      {Key? key, this.sizeCircle = 30, this.colorCircle = AppTheme.lightBlue10})
      : super(key: key);

  final double sizeCircle;
  final Color colorCircle;

  @override
  State<CheckInternetSignal> createState() => _CheckInternetSignalState();
}

class _CheckInternetSignalState
    extends LifecycleWatcherState<CheckInternetSignal> {
  InternetSignal internetSignal = getIt();

  String imageWifi(int? time) {
    if (time == null) {
      return ImageAsset.signal_lost;
    } else if (time <= 0) {
      return ImageAsset.signal_lost;
    } else if (time >= 100 && time < 200) {
      return ImageAsset.signal_middle;
    } else if (time >= 200) {
      return ImageAsset.signal_weak;
    } else {
      return ImageAsset.signal_lost;
    }
  }

  bool showIconWifi(int? time) {
    if (time == null)
      return false;
    else {
      if (time > 0) {
        if (time > 0 && time < 100)
          return false; // Ping ไม่เกิน 100 = สัญญาณแรง
        if (time >= 100 && time < 200)
          return false; //  Ping อยู่ระหว่าง 100-199 = สัญญาณพอใช้
        if (time >= 200) return true; // Ping ตั้งแต่ 200 = สัญญาณไม่ดี
        return false; // ไม่เข้าเงื่อนไขอะไรเลย
      } else {
        if (time == 0) return true; // ปิด Internet Android ios
        return false; // ไม่เข้าเงื่อนไขอะไรเลย
      }
    }
  }

  @override
  void initState() {
    internetSignal.setCountPingPage(internetSignal.countPingPage + 1);
    internetSignal.startPing();
    super.initState();
  }

  @override
  void dispose() {
    internetSignal.setCountPingPage(internetSignal.countPingPage - 1);
    internetSignal.stopPing();
    super.dispose();
  }

  @override
  void onPaused() {
    internetSignal.setPause(true);
    internetSignal.stopPing();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onResumed() {
    internetSignal.startPing();
    internetSignal.setPause(false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: internetSignal.streamTime.getResponse,
      builder: (context, AsyncSnapshot<int?> snapshot) {
        // debugPrint('response stream : ${snapshot.data?.toString()}');
        return Visibility(
          visible: showIconWifi(snapshot.data),
          // visible: true,
          child: Container(
            width: widget.sizeCircle,
            height: widget.sizeCircle,
            decoration: BoxDecoration(
                color: widget.colorCircle, shape: BoxShape.circle),
            child: Container(
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                imageWifi(snapshot.data ?? -1),
                width: 20,
                height: 20,
              ),
              // child: Text('${snapshot.data?.toString()}'),
            ),
          ),
        );
      },
    );
  }
}
