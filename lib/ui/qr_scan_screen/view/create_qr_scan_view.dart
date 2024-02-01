import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:personal_injury_networking/ui/qr_scan_screen/view/qr_scan_view.dart';
import 'package:provider/provider.dart';

class CreateQrScanView extends StatefulWidget {
  CreateQrScanView({super.key, required this.from});

  String from;

  @override
  State<CreateQrScanView> createState() => _CreateQrScanViewState();
}

class _CreateQrScanViewState extends State<CreateQrScanView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyProfileController(),
        child: HomeQrScanView(from: widget.from));
  }
}
