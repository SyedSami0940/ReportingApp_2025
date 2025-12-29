import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateReportPdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            /// COMPANY NAME
            pw.Center(
              child: pw.Text(
                "Marvel Agro Commodities",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 5),

            /// REPORT TITLE BAR
            pw.Container(
              color: PdfColors.grey300,
              padding: const pw.EdgeInsets.all(6),
              child: pw.Center(
                child: pw.Text(
                  "Product Sales Report",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),

            pw.SizedBox(height: 6),

            /// LOCATION & DATE
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Location : --All--"),
                pw.Text("FROM : 01-Aug-2025 TO : 30-Jun-2026"),
              ],
            ),

            pw.SizedBox(height: 10),

            /// TABLE
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: const pw.FixedColumnWidth(30),
                1: const pw.FixedColumnWidth(180),
                2: const pw.FixedColumnWidth(80),
                3: const pw.FixedColumnWidth(120),
                4: const pw.FixedColumnWidth(90),
              },
              children: [
                /// HEADER
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pdfCell("S.No", bold: true),
                    pdfCell("Product Name", bold: true),
                    pdfCell("Quality", bold: true),
                    pdfCell("Type", bold: true),
                    pdfCell("Amount", bold: true),
                  ],
                ),

                /// ROW 1
                pw.TableRow(
                  children: [
                    pdfCell("1"),
                    pdfCell("IRRI-6 25% - RIZ MARACANA PINK"),
                    pdfCell("WHITE-FG"),
                    pdfCell("FINISHED RICE"),
                    pdfCell("9,229,910"),
                  ],
                ),

                /// ROW 2
                pw.TableRow(
                  children: [
                    pdfCell("2"),
                    pdfCell("IRRI-6 25% - RIZ MARACANA RED"),
                    pdfCell("WHITE-FG"),
                    pdfCell("FINISHED RICE"),
                    pdfCell("14,123,664"),
                  ],
                ),

                /// TOTAL ROW
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pdfCell(""),
                    pdfCell("Total :", bold: true),
                    pdfCell(""),
                    pdfCell(""),
                    pdfCell("245,691,014", bold: true),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            /// SUMMARY BOX
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Container(
                width: 320,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Column(
                  children: [
                    pw.Container(
                      width: double.infinity,
                      color: PdfColors.grey300,
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Center(
                        child: pw.Text(
                          "Summary",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ),
                    summaryRow("No. Of Bags", "205,126"),
                    summaryRow("Weight KGs", "7,973,105"),
                    summaryRow("MTons", "7,973.105"),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
  );

  /// SHARE / DOWNLOAD / PRINT
  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: "Product_Sales_Report.pdf",
  );
}

/// PDF CELL
pw.Widget pdfCell(String text, {bool bold = false}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 9,
        fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    ),
  );
}

/// SUMMARY ROW
pw.Widget summaryRow(String title, String value) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(6),
    decoration: const pw.BoxDecoration(border: pw.Border(top: pw.BorderSide())),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title),
        pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ),
  );
}
