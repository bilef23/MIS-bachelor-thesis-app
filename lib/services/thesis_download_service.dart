import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ThesisDownloadService {
  static Future<void> downloadAndOpenPdf(String fileName) async {
    try {
      final ByteData data = await rootBundle.load('assets/pdfs/$fileName');

      final directory = await getApplicationDocumentsDirectory();
      final tempPath = '${directory.path}/$fileName';

      final file = File(tempPath);
      print(tempPath);

      await file.writeAsBytes(data.buffer.asUint8List());
      await OpenFile.open(tempPath);
    } catch (e) {
      print('Error opening PDF: $e');
      rethrow;
    }
  }
}
