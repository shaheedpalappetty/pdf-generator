import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;

Future<void> saveAndLaunchPrescriptionPDF() async {
  // Load Logo Image
  // final logoData = await rootBundle.load('assets/images/Logo.svg');
  // final logo = pdf.MemoryImage(logoData.buffer.asUint8List());

  // Create PDF document
  const String fileName = "Prescription.pdf";
  final document = pdf.Document();
  List<Map<String, String>> firstColumn = [
    {'label': 'PID:', 'value': 'John Doe'},
    {'label': 'Name:', 'value': '30'},
    {'label': 'Address:', 'value': '123 Main St'},
  ];
  List<Map<String, String>> secondColumn = [
    {'label': 'Consultation ID:', 'value': 'John Doe'},
    {'label': 'Age / Sex:', 'value': '30 / M'},
  ];
  List<Map<String, String>> thirdColumn = [
    {'label': 'EC-ID:', 'value': '565656'},
    {'label': 'Mob:', 'value': '9656400064'},
  ];
  final patientColumn1 = _buildPatientColumn(firstColumn);
  final patientColumn2 = _buildPatientColumn(secondColumn);
  final patientColumn3 = _buildPatientColumn(thirdColumn);
  // Build the content
  document.addPage(
    pdf.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pdf.EdgeInsets.all(32),
      build: (context) => pdf.Column(
        crossAxisAlignment: pdf.CrossAxisAlignment.start,
        children: [
          // Header
          pdf.Container(
            padding:
                const pdf.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: PdfColors.deepPurple,
            child: pdf.Row(
              mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
              children: [
                // pdf.Image(logo, height: 40),
                pdf.Text("PRESCRIPTION",
                    style: pdf.TextStyle(
                      fontSize: 18,
                      color: PdfColors.white,
                      fontWeight: pdf.FontWeight.bold,
                    )),
              ],
            ),
          ),

          pdf.SizedBox(height: 10),

          // Patient Details

          pdf.Container(
              child: pdf.Row(
                  mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pdf.CrossAxisAlignment.start,
                  children: [patientColumn1, patientColumn2, patientColumn3])),

          pdf.SizedBox(height: 15),

          // Observations Section
          pdf.Text("Observations:",
              style: pdf.TextStyle(
                fontSize: 14,
                fontWeight: pdf.FontWeight.bold,
              )),
          pdf.SizedBox(height: 5),
          pdf.Container(
            padding: const pdf.EdgeInsets.all(5),
            decoration: pdf.BoxDecoration(
              border: pdf.Border.all(color: PdfColors.grey),
            ),
            child: pdf.Text(
              "Lorem ipsum dolor sit amet, consectetur adipisicing elit. "
              "Odio eaque magnam porro reiciendis ullam quis in eum tempore ut nobis.",
            ),
          ),

          pdf.SizedBox(height: 10),

          // Advised Investigations
          pdf.Row(
            children: [
              pdf.Text("Advised Investigations:",
                  style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold)),
              pdf.SizedBox(width: 5),
              pdf.Text("1.CBC  2.ESR  3.KFT  4.CBC  5.ESR  6.KFT"),
            ],
          ),

          pdf.SizedBox(height: 15),

          // Medicines Table
          pdf.Text("Medicines:",
              style: pdf.TextStyle(
                fontSize: 14,
                fontWeight: pdf.FontWeight.bold,
              )),
          pdf.SizedBox(height: 10),
          pdf.TableHelper.fromTextArray(
            headers: ["Rx", "Name", "Frequency", "Duration", "Notes"],
            data: [
              ["1", "Paracetamol", "Twice a day", "5 days", "After food"],
              ["2", "Amoxicillin", "Once a day", "7 days", "Before food"],
            ],
            cellStyle: const pdf.TextStyle(fontSize: 12),
            headerStyle:
                pdf.TextStyle(fontSize: 14, fontWeight: pdf.FontWeight.bold),
            headerDecoration: const pdf.BoxDecoration(color: PdfColors.grey300),
            border: pdf.TableBorder.all(color: PdfColors.grey),
          ),

          pdf.Spacer(),

          // Footer
          pdf.Container(
              child: pdf.Row(
                  crossAxisAlignment: pdf.CrossAxisAlignment.start,
                  children: [
                pdf.Column(
                  crossAxisAlignment: pdf.CrossAxisAlignment.start,
                  children: [
                    pdf.Text("Signature: __________________________"),
                    pdf.Text("Consultant Name: Dr. John Doe"),
                    pdf.Text("Details: Additional instructions here."),
                  ],
                ),
                pdf.Spacer(),
                pdf.Text("Follow Up Date: 02/11/24",
                    style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold)),
              ])),
        ],
      ),
    ),
  );

  // Save the PDF file
  final directory = await getExternalStorageDirectory();
  final path = directory?.path ?? "";
  final file = File("$path/$fileName");

  await file.writeAsBytes(await document.save());

  // Open the PDF file
  OpenFile.open(file.path);
}

// Helper method to create patient detail Column
pdf.Widget _buildPatientColumn(List<Map<String, String>> labelValuePairs) {
  return pdf.Column(
    crossAxisAlignment: pdf.CrossAxisAlignment.start,
    children: labelValuePairs.map((pair) {
      String label = pair['label'] ?? '';
      String value = pair['value'] ?? '';
      return pdf.Text("$label $value",
          style: const pdf.TextStyle(fontSize: 12));
    }).toList(),
  );
}
