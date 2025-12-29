import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as fl;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:reporting_app/util/app_colors.dart';

class PdfPreviewPage extends StatefulWidget {
  final String fileName;
  final Future<Uint8List> generatePdf;
  const PdfPreviewPage(
      {super.key, required this.generatePdf, required this.fileName});

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewState();
}

class _PdfPreviewState extends State<PdfPreviewPage> {
  @override
  fl.Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fl.Color(AppColors.primaryColor),
        iconTheme: fl.IconThemeData(color: Colors.white),
        title: fl.Text(
          widget.fileName,
          style: fl.TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const fl.Icon(Icons.send),
            onPressed: () async {
              Uint8List pdf = await widget.generatePdf;
              sendEmail(recipients: [
                "ssami299@gmail.com",
                //"safiullah.parvez123@gmail.com",
                //"ratexh2025@outlook.com",
                //"fahadkhanr@gmail.com",
              ], pdfFileName: "${widget.fileName}.pdf", pdfBytes: pdf);
            },
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) => widget.generatePdf,
        allowPrinting: false, // Disable direct printing if needed
        allowSharing: true, // Enable sharing
        pdfFileName: "${widget.fileName}.pdf",
        actionBarTheme:
            PdfActionBarTheme(backgroundColor: Color(AppColors.primaryColor)),
      ),
    );
  }

  sendEmail(
      {required List<String> recipients,
      required Uint8List pdfBytes,
      required String pdfFileName}) async {
    // Your credentials
    String username = dotenv.env["ERP_MAIL"]!;
    String password = dotenv.env["ERP_PASSWORD"]!;
    String smtpAddress = dotenv.env["ERP_HOST"]!;

    final tmpDir = await getTemporaryDirectory();
    final file = File('${tmpDir.path}/$pdfFileName');
    await file.writeAsBytes(pdfBytes, flush: true);

    // Configure SMTP server
    final smtpServer = SmtpServer(
      smtpAddress,
      username: username,
      password: password,
      port: 587,
      ssl: false,
      allowInsecure: false,
    );

    // Create email message
    final message = Message()
      ..from = Address(username, "Asif Rice Mills")
      ..recipients.addAll(recipients) // Receiver email
      ..subject = 'Report From Rice ERP'
      ..text =
          "Mon, 01 Dec 25\nDear Sir,\n\n*PAKISTANI WHITE RICE IRRI-6\n\n5%   BROKEN \$ 350\n10%  BROKEN \$ 347\n\n15%  BROKEN \$ 344\n20%  BROKEN \$ 342\n\n25% BROKEN  Regular \$ 325\n\n\n100% BROKEN \$ 312\n\n\nALL OTHER WHITE RICE VARITIES\n\n1121 KAINAAT \$ 1247\nSUPER KERNEL BASMATI \$ 1376\nPK-386 LAL \$ 730\nC9-RICE \$ 588\n\nAll given Prices are FOB Basis including THC for Any Karachi Port, in 50KG 120 gram PP Bag.\n\nThanks & Regards,\nAsif Ali\nAsif Rice Mills"
      ..attachments.add(FileAttachment(file, fileName: pdfFileName));

    try {
      final sendReport = await send(message, smtpServer);
      print("Email sent: $sendReport");
      showEmailDialog(context, Icons.check_circle, "Email Sent Successfully");
    } catch (e) {
      print("Error: $e");
      showEmailDialog(
          context, Icons.error, "Email could not be sent. Please try again.");
    }
  }

  void showEmailDialog(
      BuildContext context, fl.IconData statusIcon, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: fl.Icon(
            statusIcon, // Success icon
            color: Color(AppColors.primaryColor),
            size: 60,
          ),
          content: fl.Text(
            message,
            textAlign: fl.TextAlign.center,
            style: const fl.TextStyle(fontSize: 18),
          ),
          actions: <fl.Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const fl.Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Source - https://stackoverflow.com/a
// Posted by Rohit, modified by community. See post 'Timeline' for change history
// Retrieved 2025-11-18, License - CC BY-SA 4.0
}
