import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class QRScannerScreen extends StatefulWidget {
  QRScannerScreen({required this.eventId, super.key});

  var eventId;

  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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

        final firestore = FirebaseFirestore.instance;
        final ticketsCollection = firestore
            .collection('events')
            .doc(widget.eventId)
            .collection('tickets'); // Replace with your collection name

        final querySnapshot = await ticketsCollection.get();

        if (querySnapshot.docs.isNotEmpty) {
          bool matchFound = false;
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            final data = doc.data() as Map<String, dynamic>?;

            if (data != null) {
              final ticketId = data['uId'] as String?;
              if (ticketId != null && ticketId == scannedCode) {
                matchFound = true;
                break;
              }
            }
          }

          if (matchFound) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            showAlertDialog('User is registered');
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            showAlertDialog('User is not registered');
          }
        } else {}
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
