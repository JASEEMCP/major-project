import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/main_screen/layout/mobile_layout.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:app/router/router.dart';
import 'package:dio/dio.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key, required this.id});

  final String id;

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (mounted && result?.code != scanData.code) {
        setState(() {
          result = scanData;
        });
        controller.pauseCamera();
        _showResult(scanData.code ?? 'No data');
      }
    });
  }

  final ValueNotifier<bool> _isMarking = ValueNotifier(false);

  _markAttendence() async {
    try {
      _isMarking.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/my-events-list/');
      if (response.statusCode == 200) {
        _isMarking.value = false;
        AppRouter.rootKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (ctx) => const MobileLayout()),
        );
        if (mounted) {
          context.showCustomSnackBar('Participation Marked', Colors.green);
        }
      }
    } on DioException catch (_) {
       if (mounted) {
          context.showCustomSnackBar('Marking failed', Colors.red);
        }
      _isMarking.value = false;
    }
  }

  void _showResult(String data) {
    final inset = $style.insets;

    final dataList = data.split('.');
    if (!(widget.id == dataList[5])) {
      controller?.resumeCamera();
      result = null;
      return context.showCustomSnackBar('Registration Mismatching', Colors.red);
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Session Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              rowTitleText('Name', dataList[3]),
              rowTitleText(
                  'Session', "Session ${(stringToInt(dataList[4])! + 1)}"),
              rowTitleText('Time', dataList[2]),
              const SizedBox(height: 10),
              CustomButton(
                width: double.maxFinite,
                name: "Mark Participation",
                color: Colors.green,
                onTap: () {
                  _markAttendence();
                },
              ),
              Gap(inset.sm),
              CustomButton(
                name: "Cancel",
                width: double.maxFinite,
                color: Colors.red,
                onTap: () {
                  AppRouter.rootKey.currentState?.pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const MobileLayout()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
