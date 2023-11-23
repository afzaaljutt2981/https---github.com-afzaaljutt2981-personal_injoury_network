import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/myProfile/view/create_my_profile.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class QRScannerScreenForAdmin extends StatefulWidget {
  const QRScannerScreenForAdmin({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerScreenForAdminState();
}

class _QRScannerScreenForAdminState extends State<QRScannerScreenForAdmin> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: AppColors.kPrimaryColor,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                  ),
                  onPermissionSet: (ctrl, p) =>
                      _onPermissionSet(context, ctrl, p),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scanning QR Code'),
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.04,
            left: screenWidth * 0.025,
            child: IconButton(
              icon: Container(
                width: 30.sp,
                height: 40.sp,
                child: Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                  size: 35.sp,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      try {
        final scannedCode = scanData.code;
        print("Code -> " + (scannedCode ?? ""));
        Navigator.pop(context);
        Navigator.push(
          context,
          PageTransition(
            childCurrent: widget,
            type: PageTransitionType.bottomToTop,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            child: CreateMyProfileView(
              from: "1",
              uid: scannedCode ?? "",
            ),
          ),
        );
      } catch (_) {}
    });
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Status'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
