import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tranquility/core/logic/helper_methods.dart';

import 'app_Image.dart';
import 'app_text.dart';

class AppAddImage extends StatefulWidget {
  const AppAddImage({super.key, this.image, required this.onChange});
  final String? image;
  final ValueChanged<String> onChange;
  @override
  State<AppAddImage> createState() => _AppAddImageState();
}

class _AppAddImageState extends State<AppAddImage> {
  String imagePath = "";

  @override
  void initState() {
    imagePath = widget.image ?? "";
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
    if (photo != null) {
      if (!mounted) return;
      Navigator.pop(context!);
      imagePath = photo.path;
      setState(() {} );
      widget.onChange(imagePath);
    }
  }

  Future<void> pickFromGallery() async {
    final picker = ImagePicker();
    final status = await Permission.photos.request();

    if (!status.isGranted) {
      openAppSettings();
      return;
    }

    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      if (!mounted) return;
      Navigator.pop(context!);
      imagePath = photo.path;
      setState(() {} );
      widget.onChange(imagePath);
    }
  }

  void showPickerSheet() {
    showModalBottomSheet<void>(
      context: context!,
      builder: (_) => _PickerSheet(onCameraTap: pickFromCamera, onGalleryTap: pickFromGallery),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CirclePicker(
      imagePath: imagePath,
      onPickTap: showPickerSheet,
      onDeleteTap: () => setState(() => imagePath = ""),
    );
  }
}

class _PickerSheet extends StatelessWidget {
  const _PickerSheet({required this.onCameraTap, required this.onGalleryTap});

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
          AppText("Pick Image From", style: theme.textTheme.titleMedium),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onCameraTap,
                child: const AppImage(image: "camera.svg"),
              ),
              InkWell(
                onTap: onGalleryTap,
                child: const AppImage(image: "gallary.svg"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CirclePicker extends StatelessWidget {
  const _CirclePicker({required this.imagePath, required this.onPickTap, required this.onDeleteTap});

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
                  child: AppImage(image: imagePath, height: 200, width: 200, fit: BoxFit.cover),
                ),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: imagePath.isEmpty ? null : onDeleteTap,
              child: CircleAvatar(
                backgroundColor: imagePath.isNotEmpty ?color.errorContainer:theme.primaryColor,
                radius: 30,
                child: AppImage(
                  image: imagePath.isEmpty ? "add.svg" : "delete_chat.svg",
                  width: 30,
                  svgColorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
