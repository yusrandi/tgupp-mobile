import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerController extends GetxController {
  Rx<Barcode>? result;
  Rx<QRViewController>? controller;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void onQRViewCreated(QRViewController controllerParam) {
    controller!.value = controllerParam;
    controller!.value.scannedDataStream.listen((scanData) {
      result!.value = scanData;
    });
  }
}
