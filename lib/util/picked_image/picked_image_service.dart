import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickedImageService extends ChangeNotifier {
  //Variável usada para pegar a imagem da galeria ou da câmera
  File? pickImage; 
  //Variável usada para capturar a imagem na web(via arquivo)
  Uint8List? webImage;

  PickedImageService({
    this.pickImage, 
    this.webImage
  });

  Future<void> pickImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    XFile? image;
    if (!kIsWeb) {
      image = await picker.pickImage(
        source: ImageSource.camera, 
        imageQuality: 100,
        maxWidth: 520,
        maxHeight: 520,
      );
      if (image != null) {
        webImage = Uint8List(8);
        pickImage  = File(image.path);
        notifyListeners();
      }
    } else if (kIsWeb) {
      image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 520,
        maxHeight: 520,
      );
      if (image != null) {
        webImage  = await image.readAsBytes();
        pickImage = File('a');
        notifyListeners();
      }
    }
  }
}
