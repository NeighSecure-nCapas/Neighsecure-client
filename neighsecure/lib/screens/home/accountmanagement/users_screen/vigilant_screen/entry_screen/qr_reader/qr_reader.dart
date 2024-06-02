import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    bool isProcessing = false;

    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      if(isProcessing){
        return;
      }

      setState(() {
        result = scanData;
      });

      if (result != null ) {
        isProcessing = true;
        controller.pauseCamera();

        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text('Listo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 20),
                const Text(
                    'El código QR se ha escaneado exitosamente. Acceso concedido. ¡Bienvenido/a!.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFF001E2C),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 28,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Listo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xFF001E2C),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        //Return icon button
        Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Scan QR Code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.qr_code,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            )),
        Expanded(flex: 15, child: _buildQrView(context)),
      ],
    )));
  }
}
