
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/qr_scan_screen/view/qr_scan_view.dart';
import 'package:provider/provider.dart';

import '../controller/qr_scan_controller.dart';
class CreateQrScanView extends StatefulWidget {
  const CreateQrScanView({super.key});

  @override
  State<CreateQrScanView> createState() => _CreateQrScanViewState();
}

class _CreateQrScanViewState extends State<CreateQrScanView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QrScanController>(
        create: (_) => QrScanController(), child: const HomeQrScanView());
  }
}