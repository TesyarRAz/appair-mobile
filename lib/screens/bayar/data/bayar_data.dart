import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class BayarData {
  XFile? imagePicker;
  PlatformFile? filePicker;

  BayarData({this.imagePicker, this.filePicker});

  Future<Uint8List?> get fileBytes async {
    if (imagePicker != null) {
      return await imagePicker!.readAsBytes();
    } else if (filePicker != null) {
      return filePicker!.bytes;
    } else {
      return null;
    }
  }

  String? get fileName {
    if (imagePicker != null) {
      return imagePicker!.name;
    } else if (filePicker != null) {
      return filePicker!.name;
    } else {
      return null;
    }
  }
}
