import 'dart:developer';
import 'dart:io';

import 'package:emeeting_flutter/app/cores/core_colors.dart';
import 'package:emeeting_flutter/app/cores/core_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../routes/app_pages.dart';
import '../controllers/scanner_controller.dart';

class ScannerView extends StatefulWidget {
  ScannerView({Key? key}) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            cameraFacing: CameraFacing.back,
            onQRViewCreated: _onQRViewCreated,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 120),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: (result != null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Meet Code: ${result!.code}',
                          style: CoreStyles.uSubTitle
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.MEETDETAIL,
                              arguments: result!.code),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: CoreColor.primary),
                            child: Text(
                              'NEXT',
                              style: CoreStyles.uSubTitle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Scan a code',
                      style: CoreStyles.uSubTitle.copyWith(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      // Get.toNamed(Routes.BASE, arguments: result!.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
