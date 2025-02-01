//import 'dart:html' as html; // For Web
import 'package:flutter/foundation.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CertificateGenerator {
  static Future<void> generateCertificate(String name, String eventName) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat:
            const PdfPageFormat(250 * PdfPageFormat.mm, 200 * PdfPageFormat.mm),
        //orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text("Certificate of Participation",
                    style: pw.TextStyle(
                      fontSize: 30,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue,
                    )),
                pw.SizedBox(height: 20),
                pw.Text("This is to certify that",
                    style: const pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 10),
                pw.Text(name,
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text("has successfully participated in",
                    style: const pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 10),
                pw.Text(eventName,
                    style: pw.TextStyle(
                        fontSize: 22, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();

    if (kIsWeb) {
      // // ✅ Open in a new browser tab (Flutter Web)
      // final blob = html.Blob([pdfBytes], 'application/pdf');
      // final url = html.Url.createObjectUrlFromBlob(blob);
      // html.window.open(url, "_blank");
      // html.Url.revokeObjectUrl(url);
    } else {
      // ✅ Save & Open PDF (Mobile)
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/certificate.pdf");
      await file.writeAsBytes(pdfBytes);
      OpenFile.open(file.path);
      // OpenFilex.open(file.path);
    }
  }
}
