import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

typedef ImageContent = Function(String, String);

class ImageModal {
  final BuildContext context;
  final ImageContent onImageSelected;

  ImageModal({required this.context, required this.onImageSelected}) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (_) => ImageForm(
        onImageSelected: onImageSelected,
      ),
    );
  }
}

class ImageForm extends StatelessWidget {
  ImageForm({super.key, required this.onImageSelected});

  final ImageContent onImageSelected;

  final ValueNotifier<String> categoryNotifier = ValueNotifier('');
  final ValueNotifier<bool> errorNotifier = ValueNotifier(false);

  Future<String?> pickImage() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final imagePath = '${appDocumentsDir.path}/${photo.name}';
      await photo.saveTo(imagePath);
      return imagePath;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    categoryNotifier.addListener(
      () {
        if (categoryNotifier.value.isNotEmpty && errorNotifier.value) {
          errorNotifier.value = false;
        }
      },
    );

    return CupertinoAlertDialog(
      title: Column(
        children: [
          Text(
            'Nueva imagen',
            style: theme.textTheme.titleMedium,
          ),
          const Text('Agregar categoría'),
        ],
      ),
      content: Column(
        children: [
          CupertinoTextField(
            onChanged: (value) {
              categoryNotifier.value = value;
            },
            placeholder: 'Nombre de la categoría',
          ),
          ValueListenableBuilder(
            valueListenable: errorNotifier,
            builder: (BuildContext context, bool showError, Widget? child) {
              if (showError) {
                return Text(
                  'Debe ingresar una categoría!',
                  style: TextStyle(color: theme.colorScheme.error),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        ValueListenableBuilder(
            valueListenable: categoryNotifier,
            builder: (BuildContext context, String category, Widget? child) {
              return CupertinoDialogAction(
                onPressed: () async {
                  if (category.isEmpty) {
                    errorNotifier.value = true;
                    return;
                  }
                  errorNotifier.value = false;
                  final path = await pickImage();
                  if (path?.isEmpty ?? true) {
                    return;
                  }
                  onImageSelected.call(path!, categoryNotifier.value);
                },
                isDefaultAction: true,
                child: const Text('Tomar foto'),
              );
            }),
      ],
    );
  }
}
