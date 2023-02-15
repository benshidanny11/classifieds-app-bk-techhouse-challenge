
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtil {
  static Future<PermissionStatus> parmissionHandler() async {
    return await Permission.storage.request();
  }

  static Future<XFile?> picImage() async {
    final permission = await parmissionHandler();
    if (permission.isGranted) {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    }
  }
}
