import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reporting_app/screen/rpt_demo.dart' as rpt_demo;
import 'package:reporting_app/screen/rpt_demo.dart';
import 'package:reporting_app/screen/rpt_marvel.dart' as rpt_marvel;
import 'package:reporting_app/util/app_colors.dart';
import 'package:reporting_app/util/pdf_preview.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Dummy report data
  List<dynamic> reportList = [
    {
      "S.No": "1",
      "Node No": "1",
      "Product Name": "IRRI-6 10%",
      "Quality": "WHITE-FG",
      "Type Name": "FINISHED RICE",
      "No Of Bags": "46,416",
      "Ex Net Weight": "1,791,695",
      "Net Weight KGs": "1,791,695",
      "Billing Weight": "1,787,011",
      "Vehicles": "11",
      "Amount": "152,024,062",
      "Out No Of Bags": "1544",
      "Out Net Weight KGs": "54,036.00",
      "Out Vehicles": "2",
      "Out Amount": "5,203,008",
    },
    {
      "S.No": "1",
      "Node No": "1",
      "Product Name": "IRRI-6 10%",
      "Quality": "WHITE-FG",
      "Type Name": "FINISHED RICE",
      "No Of Bags": "46,416",
      "Ex Net Weight": "1,791,695",
      "Net Weight KGs": "1,791,695",
      "Billing Weight": "1,787,011",
      "Vehicles": "11",
      "Amount": "152,024,062",
      "Out No Of Bags": "1544",
      "Out Net Weight KGs": "54,036.00",
      "Out Vehicles": "2",
      "Out Amount": "5,203,008",
    },
    {
      "S.No": "1",
      "Node No": "1",
      "Product Name": "IRRI-6 10%",
      "Quality": "WHITE-FG",
      "Type Name": "FINISHED RICE",
      "No Of Bags": "46,416",
      "Ex Net Weight": "1,791,695",
      "Net Weight KGs": "1,791,695",
      "Billing Weight": "1,787,011",
      "Vehicles": "11",
      "Amount": "152,024,062",
      "Out No Of Bags": "1544",
      "Out Net Weight KGs": "54,036.00",
      "Out Vehicles": "2",
      "Out Amount": "5,203,008",
    },
    {
      "S.No": "1",
      "Node No": "1",
      "Product Name": "IRRI-6 10%",
      "Quality": "WHITE-FG",
      "Type Name": "FINISHED RICE",
      "No Of Bags": "46,416",
      "Ex Net Weight": "1,791,695",
      "Net Weight KGs": "1,791,695",
      "Billing Weight": "1,787,011",
      "Vehicles": "11",
      "Amount": "152,024,062",
      "Out No Of Bags": "1544",
      "Out Net Weight KGs": "54,036.00",
      "Out Vehicles": "2",
      "Out Amount": "5,203,008",
    },
  ];

  /// ONLY for demo button (unchanged)
  // void showThanks(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text("Thanks for clicking the demo button 😊"),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppColors.primaryColor),
        title: const Text("Home", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 SIMPLE REPORT DEMO (NO CHANGE)
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(220, 45),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfPreviewPage(
                      fileName: "Product Sales Report",
                      generatePdf:
                          generateProductsalesReport(reportList, context),
                      // generatePdf: rpt_marvel.generatePurchaseReport(
                      //     reportList, context),
                    ),
                  ),
                );
              },
              child: const Text("Grouping Report"),
            ),

            const SizedBox(height: 20),

            /// 🔹 OPEN PRODUCT SALES REPORT (MAIN BUTTON)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(220, 45),
              ),
              onPressed: generateReportPdf,
              child: const Text("Simple report"),
            ),
          ],
        ),
      ),
    );
  }

  // report Product sales Report function
  Future<Uint8List> generateProductsalesReport(
      List<dynamic> jsonData, BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }

    try {
      final pdf = pw.Document();
      final imageData = await rootBundle.load('assets/logob.png');
      final image = pw.MemoryImage(imageData.buffer.asUint8List());

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: pw.EdgeInsets.fromLTRB(20, 20, 20, 0),
          build: (context) {
            return [
              pw.Row(children: [
                pw.Image(image, width: 80, height: 80),
                pw.SizedBox(
                  width: 30,
                ),
                pw.Container(
                  width: 650,
                  child: pw.Column(children: [
                    pw.Center(
                      child: pw.Text(
                        'Marvel Agro Commodities',
                        style: pw.TextStyle(
                            fontSize: 23, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      color: PdfColors.grey300,
                      child: pw.Center(
                        child: pw.Text(
                          'Product Sales Report',
                          style: pw.TextStyle(
                              fontSize: 21, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      width: 1050,
                      child: pw.Text(
                          "From: 01-Aug-2025, Till Date: 27-Jun-2025",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    )
                  ]),
                )
              ]),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                columnWidths: {
                  0: const pw.FixedColumnWidth(22),
                  1: const pw.FixedColumnWidth(24),
                  2: const pw.FixedColumnWidth(65),
                  3: const pw.FixedColumnWidth(43),
                  4: const pw.FixedColumnWidth(43),
                },
                children: [
                  // 🔹 Header Row 1
                  pw.TableRow(
                    children: [
                      // Account Code (merged vertically)
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 4, bottom: 4),
                        child: pw.Text(
                          "S.No",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 6),
                          textAlign: pw.TextAlign.center,
                        ),
                        // We'll leave its spot blank in next header row
                      ),

                      // Account Title (merged vertically)
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          "Node No",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 6),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Product Name",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 6),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 4, bottom: 4),
                        child: pw.Text(
                          "Quality",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 6),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 4, bottom: 4),
                        child: pw.Text(
                          "Type Name",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 6),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      // "Local Sales" spans two columns → we use a nested table
                      pw.Table(
                        columnWidths: {
                          0: pw.FixedColumnWidth(44),
                          1: pw.FixedColumnWidth(54),
                          2: pw.FixedColumnWidth(40),
                          3: pw.FixedColumnWidth(50),
                          4: pw.FixedColumnWidth(30),
                          5: pw.FixedColumnWidth(40),
                        },
                        border: pw.TableBorder.all(width: 0),
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Local Sales",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 6),
                                  textAlign: pw.TextAlign.center,
                                ),

                                // colSpan: 2, // doesn't exist — handled manually
                              ),
                              // filler
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "No Of Bags",
                                  style: pw.TextStyle(
                                      fontSize: 7,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Net Weight KGs",
                                  style: pw.TextStyle(
                                      fontSize: 7,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Vehicles",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Amount",
                                  style: pw.TextStyle(
                                      fontSize: 7,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Vehicles",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Amount",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      // ready sale nested table
                      pw.Table(
                        columnWidths: {
                          0: pw.FixedColumnWidth(44),
                          1: pw.FixedColumnWidth(54),
                          2: pw.FixedColumnWidth(40),
                          3: pw.FixedColumnWidth(50),
                          4: pw.FixedColumnWidth(30),
                          5: pw.FixedColumnWidth(40),
                        },
                        border: pw.TableBorder.all(width: 0),
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Ready Sales",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 6),
                                  textAlign: pw.TextAlign.center,
                                ),

                                // colSpan: 2, // doesn't exist — handled manually
                              ),
                              // filler
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "No Of Bags",
                                  style: pw.TextStyle(
                                      fontSize: 7,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Net Weight KGs",
                                  style: pw.TextStyle(
                                      fontSize: 7,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Vehicles",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Amount",
                                  style: pw.TextStyle(
                                      fontSize: 7,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Vehicles",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Amount",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      //Exprot Sales nested table
                      pw.Table(
                        columnWidths: {
                          0: pw.FixedColumnWidth(44),
                          1: pw.FixedColumnWidth(50),
                          2: pw.FixedColumnWidth(45),
                          3: pw.FixedColumnWidth(50),
                          4: pw.FixedColumnWidth(30),
                          5: pw.FixedColumnWidth(40),
                        },
                        border: pw.TableBorder.all(width: 0),
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(5),
                                child: pw.Text(
                                  "Exprot Sales",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 6),
                                  textAlign: pw.TextAlign.center,
                                ),

                                // colSpan: 2, // doesn't exist — handled manually
                              ),
                              // filler
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "No Of Bags",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Net Weight KGs",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Vehicles",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Amount",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Vehicles",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Amount",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      pw.Table(
                        columnWidths: {
                          0: pw.FixedColumnWidth(44),
                          1: pw.FixedColumnWidth(50),
                          2: pw.FixedColumnWidth(45),
                          3: pw.FixedColumnWidth(50),
                          4: pw.FixedColumnWidth(30),
                          5: pw.FixedColumnWidth(40),
                        },
                        border: pw.TableBorder.all(width: 0),
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(8.5),
                                child: pw.Text(
                                  "POS",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 6),
                                  textAlign: pw.TextAlign.center,
                                ),

                                // colSpan: 2, // doesn't exist — handled manually
                              ),
                              // filler
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "No Of Bags",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Net Weight KGs",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Vehicles",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  "Amount",
                                  style: pw.TextStyle(
                                      fontSize: 6,
                                      fontWeight: pw.FontWeight.bold),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Vehicles",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                              // pw.Container(
                              //   alignment: pw.Alignment.center,
                              //   padding: const pw.EdgeInsets.all(6),
                              //   child: pw.Text(
                              //     "Amount",
                              //     style: pw.TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: pw.FontWeight.bold),
                              //     textAlign: pw.TextAlign.center,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  // 🔹 Header Row 2 (for Debit / Credit under Opening)

                  // 🔹 Data Rows
                ],
              ),
              // Table data rows width adjustment
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                columnWidths: {
                  0: const pw.FixedColumnWidth(6.5),
                  1: const pw.FixedColumnWidth(6.7),
                  2: const pw.FixedColumnWidth(22),
                  3: const pw.FixedColumnWidth(14),
                  4: const pw.FixedColumnWidth(14.5),
                  //local sales
                  5: const pw.FixedColumnWidth(10),
                  6: const pw.FixedColumnWidth(18),
                  7: const pw.FixedColumnWidth(11),
                  8: const pw.FixedColumnWidth(18),
                  //ready sales
                  9: const pw.FixedColumnWidth(17.5),
                  10: const pw.FixedColumnWidth(31),
                  11: const pw.FixedColumnWidth(28),
                  12: const pw.FixedColumnWidth(31.8),
                  //export sales
                  13: const pw.FixedColumnWidth(17.5),
                  14: const pw.FixedColumnWidth(25),
                  15: const pw.FixedColumnWidth(25),
                  16: const pw.FixedColumnWidth(28),
                  //pos
                  17: const pw.FixedColumnWidth(19),
                  18: const pw.FixedColumnWidth(31.6),
                  19: const pw.FixedColumnWidth(28),
                  20: const pw.FixedColumnWidth(19),
                },
                children: reportList.map((item) {
                  return pw.TableRow(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["S.No"] ?? "",
                          style: pw.TextStyle(fontSize: 6),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Node No"] ?? "",
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Product Name"] ?? "",
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Quality"] ?? "",
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Type Name"] ?? "",
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["No Of Bags"] ?? "",
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Ex Net Weight"] ?? "",
                          style: pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Net Weight KGs"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Billing Weight"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Vehicles"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Amount"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Out No Of Bags"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Out Net Weight KGs"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Out Vehicles"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          item["Out Amount"] ?? "",
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              // pw.TableHelper.fromTextArray(
              //   headers:
              //       jsonData.isNotEmpty ? jsonData.first.keys.toList() : [],
              //   data: jsonData
              //       .map<List<dynamic>>(
              //           (item) => item.values.map((v) => v.toString()).toList())
              //       .toList(),
              //   columnWidths: {
              //     0: pw.FixedColumnWidth(70),
              //     1: pw.FixedColumnWidth(170),
              //     2: pw.FixedColumnWidth(90),
              //     3: pw.FixedColumnWidth(90),
              //   },
              //   headerAlignments: {
              //     0: pw.Alignment.center,
              //     1: pw.Alignment.center,
              //     2: pw.Alignment.center,
              //     3: pw.Alignment.center,
              //   },
              //   cellAlignments: {
              //     0: pw.Alignment.topLeft,
              //     1: pw.Alignment.topLeft,
              //     2: pw.Alignment.topRight,
              //     3: pw.Alignment.topRight,
              //   },
              //   headerStyle: pw.TextStyle(fontWeight: FontWeight.bold),
              // ),
            ];
          },
        ),
      );

      return pdf.save();

      // ✅ Save to Downloads
      //   final downloadsDir = Directory('/storage/emulated/0/Download');
      //   if (!await downloadsDir.exists())
      //     await downloadsDir.create(recursive: true);

      //   final filePath =
      //       '${downloadsDir.path}/update_after_post_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
      //   final file = File(filePath);
      //   await file.writeAsBytes(await pdf.save());

      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('✅ PDF saved in Downloads: $filePath')),
      //   );
    } catch (e, st) {
      debugPrint('PDF generation error: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
      return Uint8List(2);
    }
  }
}


// report generation function
//   Future<Uint8List> generatePurchaseReport(
//       List<dynamic> jsonData, BuildContext context) async {
//     final status = await Permission.storage.request();
//     if (!status.isGranted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Storage permission denied')),
//       );
//     }

//     try {
//       final pdf = pw.Document();
//       final imageData = await rootBundle.load('assets/logob.png');
//       final image = pw.MemoryImage(imageData.buffer.asUint8List());

//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat(1600, PdfPageFormat.a4.height),
//           margin: pw.EdgeInsets.fromLTRB(20, 50, 20, 0),
//           build: (context) {
//             return [
//               pw.Row(children: [
//                 pw.Image(image, width: 80, height: 80),
//                 pw.SizedBox(
//                   width: 30,
//                 ),
//                 pw.Container(
//                   width: 1450,
//                   child: pw.Column(children: [
//                     pw.Center(
//                       child: pw.Text(
//                         'Marvel Agro Commodities',
//                         style: pw.TextStyle(
//                             fontSize: 23, fontWeight: pw.FontWeight.bold),
//                       ),
//                     ),
//                     pw.Container(
//                       color: PdfColors.grey300,
//                       child: pw.Center(
//                         child: pw.Text(
//                           'Product Sales Report',
//                           style: pw.TextStyle(
//                               fontSize: 21, fontWeight: pw.FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     pw.Container(
//                       alignment: pw.Alignment.center,
//                       width: 1050,
//                       child: pw.Text(
//                           "From: 01-Aug-2025, Till Date: 27-Jun-2025",
//                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                     )
//                   ]),
//                 )
//               ]),
//               pw.SizedBox(height: 10),
//               pw.Table(
//                 border: pw.TableBorder.all(width: 0.5),
//                 columnWidths: {
//                   0: const pw.FixedColumnWidth(20),
//                   1: const pw.FixedColumnWidth(22),
//                   2: const pw.FixedColumnWidth(100),
//                   3: const pw.FixedColumnWidth(100),
//                   4: const pw.FixedColumnWidth(100),
//                 },
//                 children: [
//                   // 🔹 Header Row 1
//                   pw.TableRow(
//                     children: [
//                       // Account Code (merged vertically)
//                       pw.Container(
//                         alignment: pw.Alignment.center,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           "S No",
//                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           textAlign: pw.TextAlign.center,
//                         ),
//                         // We'll leave its spot blank in next header row
//                       ),

//                       // Account Title (merged vertically)
//                       pw.Container(
//                         alignment: pw.Alignment.center,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           "Node No",
//                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           textAlign: pw.TextAlign.center,
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.center,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           "Product Name",
//                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           textAlign: pw.TextAlign.center,
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.center,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           "Quality",
//                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           textAlign: pw.TextAlign.center,
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.center,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           "Type Name",
//                           style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           textAlign: pw.TextAlign.center,
//                         ),
//                       ),
//                       // "Opening" spans two columns → we use a nested table
//                       pw.Table(
//                         columnWidths: {
//                           0: pw.FixedColumnWidth(44),
//                           1: pw.FixedColumnWidth(50),
//                           2: pw.FixedColumnWidth(45),
//                           3: pw.FixedColumnWidth(50),
//                           4: pw.FixedColumnWidth(30),
//                           5: pw.FixedColumnWidth(40),
//                         },
//                         border: pw.TableBorder.all(width: 0),
//                         children: [
//                           pw.TableRow(
//                             children: [
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "IN-HOUSE PURCHASES",
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),

//                                 // colSpan: 2, // doesn't exist — handled manually
//                               ),
//                               // filler
//                             ],
//                           ),
//                           pw.TableRow(
//                             children: [
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "No Of Bags",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Ex Net Weight",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Net Weight KGs",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Billing Weight",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Vehicles",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Amount",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       pw.Table(
//                         columnWidths: {
//                           0: pw.FixedColumnWidth(40),
//                           1: pw.FixedColumnWidth(45),
//                           2: pw.FixedColumnWidth(30),
//                           3: pw.FixedColumnWidth(50),
//                         },
//                         border: pw.TableBorder.all(width: 0),
//                         children: [
//                           pw.TableRow(
//                             children: [
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "OUT STATION",
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),

//                                 // colSpan: 2, // doesn't exist — handled manually
//                               ),
//                               // filler
//                             ],
//                           ),
//                           pw.TableRow(
//                             children: [
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "No Of Bags",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Net Weight KGs",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Vehicles",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                               pw.Container(
//                                 alignment: pw.Alignment.center,
//                                 padding: const pw.EdgeInsets.all(6),
//                                 child: pw.Text(
//                                   "Amount",
//                                   style: pw.TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: pw.FontWeight.bold),
//                                   textAlign: pw.TextAlign.center,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   // 🔹 Header Row 2 (for Debit / Credit under Opening)

//                   // 🔹 Data Rows
//                 ],
//               ),
//               pw.Table(
//                 border: pw.TableBorder.all(width: 0.5),
//                 columnWidths: {
//                   0: const pw.FixedColumnWidth(12.4),
//                   1: const pw.FixedColumnWidth(13.7),
//                   2: const pw.FixedColumnWidth(62.5),
//                   3: const pw.FixedColumnWidth(62.5),
//                   4: const pw.FixedColumnWidth(62.5),
//                   5: const pw.FixedColumnWidth(27.5),
//                   6: const pw.FixedColumnWidth(31),
//                   7: const pw.FixedColumnWidth(28),
//                   8: const pw.FixedColumnWidth(31.8),
//                   9: const pw.FixedColumnWidth(17.5),
//                   10: const pw.FixedColumnWidth(25),
//                   11: const pw.FixedColumnWidth(25),
//                   12: const pw.FixedColumnWidth(28),
//                   13: const pw.FixedColumnWidth(19),
//                   14: const pw.FixedColumnWidth(31.6),
//                 },
//                 children: reportLists.map((item) {
//                   return pw.TableRow(
//                     children: [
//                       pw.Container(
//                         alignment: pw.Alignment.center,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["S.No"] ?? "",
//                           textAlign: pw.TextAlign.center,
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerLeft,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Node No"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerLeft,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Product Name"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerLeft,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Quality"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerLeft,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Type Name"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["No Of Bags"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Ex Net Weight"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Net Weight KGs"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Billing Weight"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Vehicles"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Amount"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Out No Of Bags"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Out Net Weight KGs"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Out Vehicles"] ?? "",
//                         ),
//                       ),
//                       pw.Container(
//                         alignment: pw.Alignment.centerRight,
//                         padding: const pw.EdgeInsets.all(6),
//                         child: pw.Text(
//                           item["Out Amount"] ?? "",
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//               // pw.TableHelper.fromTextArray(
//               //   headers:
//               //       jsonData.isNotEmpty ? jsonData.first.keys.toList() : [],
//               //   data: jsonData
//               //       .map<List<dynamic>>(
//               //           (item) => item.values.map((v) => v.toString()).toList())
//               //       .toList(),
//               //   columnWidths: {
//               //     0: pw.FixedColumnWidth(70),
//               //     1: pw.FixedColumnWidth(170),
//               //     2: pw.FixedColumnWidth(90),
//               //     3: pw.FixedColumnWidth(90),
//               //   },
//               //   headerAlignments: {
//               //     0: pw.Alignment.center,
//               //     1: pw.Alignment.center,
//               //     2: pw.Alignment.center,
//               //     3: pw.Alignment.center,
//               //   },
//               //   cellAlignments: {
//               //     0: pw.Alignment.topLeft,
//               //     1: pw.Alignment.topLeft,
//               //     2: pw.Alignment.topRight,
//               //     3: pw.Alignment.topRight,
//               //   },
//               //   headerStyle: pw.TextStyle(fontWeight: FontWeight.bold),
//               // ),
//             ];
//           },
//         ),
//       );

//       return pdf.save();

//       // ✅ Save to Downloads
//       //   final downloadsDir = Directory('/storage/emulated/0/Download');
//       //   if (!await downloadsDir.exists())
//       //     await downloadsDir.create(recursive: true);

//       //   final filePath =
//       //       '${downloadsDir.path}/update_after_post_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
//       //   final file = File(filePath);
//       //   await file.writeAsBytes(await pdf.save());

//       //   ScaffoldMessenger.of(context).showSnackBar(
//       //     SnackBar(content: Text('✅ PDF saved in Downloads: $filePath')),
//       //   );
//     } catch (e, st) {
//       debugPrint('PDF generation error: $e\n$st');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Error: $e')),
//       );
//       return Uint8List(2);
//     }
//   }
// }
