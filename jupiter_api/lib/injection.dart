// กำหนดตัวสำหรับตั้งค่า get_it
// ฟังก์ชันที่ชื่อ $initGetIt จะถูกสร้างเมื่อเราสั่ง build_runner
// @InjectableInit(preferRelativeImports: false)
// Future<void> configureInjection({String? env}) async => getIt.init(environment: env);

// กำหนดว่าอยากให้มี Environment อะไรบ้างตามแต่ใจของเราเลย
abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
