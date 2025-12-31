import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_Image.dart';
import 'app_text.dart';

class AppAddImage extends StatefulWidget {
  const AppAddImage({super.key, this.shapeIsCircle = true, this.imagePath});

  final bool shapeIsCircle;
  final String? imagePath;

  @override
  State<AppAddImage> createState() => _AppAddImageState();
}

class _AppAddImageState extends State<AppAddImage> {
  String imagePath = "";
  @override
  void initState() {
    imagePath=widget.imagePath??"";
    super.initState();
  }
  Future<void> pickFromCamera() async {
    final picker = ImagePicker();
    final status = await Permission.camera.request();

    if (!status.isGranted) {
      openAppSettings();
      return;
    }

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) setState(() => imagePath = photo.path);
  }

  Future<void> pickFromGallery() async {
    final picker = ImagePicker();
    final status = await Permission.photos.request();

    if (!status.isGranted) {
      openAppSettings();
      return;
    }

    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) setState(() => imagePath = photo.path);
  }

  void showPickerSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => _PickerSheet(
        onCameraTap: pickFromCamera,
        onGalleryTap: pickFromGallery,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.shapeIsCircle
        ? _CirclePicker(
      imagePath: imagePath,
      onPickTap: showPickerSheet,
      onDeleteTap: () => setState(() => imagePath = ""),
    )
        : _RectanglePicker(
      hasImage: imagePath.isNotEmpty,
      onTap: showPickerSheet,
      child: imagePath.isNotEmpty
          ? AppImage(image: imagePath, height: 100, fit: BoxFit.cover)
          : null,
    );
  }
}
class _PickerSheet extends StatelessWidget {
  const _PickerSheet({
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 220,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText("Pick Image From",
              style: theme.textTheme.titleMedium),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(onTap: onCameraTap, child: const AppImage(image: "camera.svg")),
              InkWell(onTap: onGalleryTap, child: const AppImage(image: "gallary.svg")),
            ],
          )
        ],
      ),
    );
  }
}
class _CirclePicker extends StatelessWidget {
  const _CirclePicker({
    required this.imagePath,
    required this.onPickTap,
    required this.onDeleteTap,
  });

  final String imagePath;
  final VoidCallback onPickTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPickTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          imagePath.isEmpty
              ? const AppImage(image: "pick_image.svg")
              : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: AppImage(
              image: imagePath,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: theme.primaryColor,
              child: AppImage(
                image: imagePath.isEmpty ? "add.svg" : "edit.svg",
              ),
            ),
          ),

          if (imagePath.isNotEmpty)
            Positioned(
              left: 4,
              top: 4,
              child: GestureDetector(
                onTap: onDeleteTap,
                child: CircleAvatar(
                  backgroundColor:
                  theme.primaryColor.withValues(alpha: 0.25),
                  child: const AppImage(image: "delete_chat.svg"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
class _RectanglePicker extends StatelessWidget {
  const _RectanglePicker({
    required this.hasImage,
    required this.onTap,
    this.child,
  });

  final bool hasImage;
  final VoidCallback onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText("الصورة الشخصية", style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: hasImage
              ? Stack(
            children: [
              child!,
              const Positioned(
                top: 10,
                left: 10,
                child: AppImage(image: "camera.svg", width: 24),
              ),
            ],
          )
              : Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  AppImage(image: "camera.svg"),
                  SizedBox(height: 10),
                  AppText("الملفات المسموح بيها : JPEG , PNG"),
                  AppText("الحد الاقصي : 5MB"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
