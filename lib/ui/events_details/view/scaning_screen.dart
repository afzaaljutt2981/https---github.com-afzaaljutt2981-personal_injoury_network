import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
    return Scaffold(
      body: Column(
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
              )),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text('Scaning QR Code'),
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
            Navigator.pop(context);
            showAlertDialog('User is registered');
          } else {
            Navigator.pop(context);
            showAlertDialog('User is not registered');
          }
        } else {
          print('No documents found in the collection');
        }
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  // void _onQRViewCreated(QRViewController controller) {
  // setState(() {
  //   this.controller = controller;
  // });
  // controller.scannedDataStream.listen((scanData) async {
  //   try {
  //     final scannedCode = scanData.code;

  //     final firestore = FirebaseFirestore.instance;
  //     final ticketsCollection = firestore.collection('events').doc(widget.eventId).collection('tickets'); // Replace with your collection name

  //     final querySnapshot = await ticketsCollection.get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //      bool matchFound = false;
  //       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //         var ticketId = doc.data()?['id'];
  //         if (ticketId != null && ticketId == scannedCode) {
  //           matchFound = true;
  //           break;
  //         }
  //       }
  //       showAlertDialog('User is registered');

  //       // if (matchFound) {
  //       //    showAlertDialog('User is registered');
  //       // } else {
  //       //   showAlertDialog('User is not registered');
  //       // }
  //     } else {

  //     }
  //   } catch (_) {

  //   }
  // });
//}

  // void _onQRViewCreated(QRViewController controller) {
  //   setState(() {
  //     this.controller = controller;
  //   });
  //   controller.scannedDataStream.listen((scanData) async {
  //     try {
  //       print('Scanned data: ${scanData.code}');
  //       final scannedCode = scanData.code;

  //       final firestore = FirebaseFirestore.instance;
  //       // final eventsCollection = firestore.collection('events').doc(widget.eventId).collection('tickets');

  //       // final querySnapshot =
  //       //     await eventsCollection.where(doc, isEqualTo: scannedCode).get();

  //        final eventDoc = firestore.collection('events').doc(widget.eventId);

  //     final ticketsCollection = eventDoc.collection('tickets');

  //     final querySnapshot = await ticketsCollection.where('ticketId', isEqualTo: scannedCode).get();

  //       if (querySnapshot.docs.isNotEmpty) {
  //         // Event found with a matching ID
  //         // Now, you can check the tickets subcollection to verify if the user is registered.
  //         final eventDoc = querySnapshot.docs.first;
  //         final ticketsCollection = eventDoc.reference.collection('tickets');

  //         // Replace 'ticketId' with the field that contains the ticket ID in the ticket document
  //         final ticketQuerySnapshot = await ticketsCollection
  //             .where('ticketId', isEqualTo: scannedCode)
  //             .get();

  //         if (ticketQuerySnapshot.docs.isNotEmpty) {
  //           // User is registered
  //           showAlertDialog('User is registered');
  //         } else {
  //           // User is not registered
  // showAlertDialog('User is not registered');
  //         }
  //       } else {
  //         // Event not found
  //         showAlertDialog('Event not found');
  //       }
  //     } catch (e) {
  //       print('Error: $e');
  //     }
  //   });
  // }

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

  // void _onQRViewCreated(QRViewController controller) {
  //   setState(() {
  //     this.controller = controller;
  //   });
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       print('Scanned data: ${scanData.code}');

  //     });

  //     Navigator.pop(context);
  //   });
  // }

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
