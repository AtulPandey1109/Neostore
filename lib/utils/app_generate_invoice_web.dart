import 'dart:html' as html;
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

Future<void> _generatePdfWeb(Document pdf) async{
  final bytes = await pdf.save();

  // Create a Blob from the PDF content
  final blob = html.Blob([bytes], 'application/pdf');

  // Create an anchor element and simulate a download
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'invoice_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf')
    ..click();
  html.Url.revokeObjectUrl(url);
}