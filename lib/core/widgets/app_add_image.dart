import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'app_Image.dart';
import 'app_text.dart';

class AppAddImage extends StatefulWidget {
  const AppAddImage({super.key, this.shapeIsCircle});
  final bool? shapeIsCircle;
  @override
  State<AppAddImage> createState() => _AppAddImageState();
}

class _AppAddImageState extends State<AppAddImage> {
  bool hadSelectImage = false;

  @override
  Widget build(BuildContext context) {
    return widget.shapeIsCircle == false
        ? const ClipRRect(

    ) :Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          "الصورة الشخصية",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 10),
        //todo handle on top action
        InkWell(
          onTap: () {
            setState(() {
              hadSelectImage = !hadSelectImage;
            });
          },
          child: hadSelectImage
              ? const Stack(
                  children: [
                    AppImage(image: "image1.jpg",height: 100,fit: BoxFit.cover,),
                    Positioned(
                        top: 10,
                        left: 10,
                        child: AppImage(image: "camera.svg",width: 24,)),
                  ],
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: const Radius.circular(8),
                      dashPattern: [10, 10],
                      color: Theme.of(context).colorScheme.secondary,
                      strokeWidth: 1,
                      borderPadding: const EdgeInsets.all(1),
                      strokeCap: StrokeCap.square,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.symmetric(vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppImage(image: "camera.svg"),
                          const SizedBox(height: 10),
                          AppText(
                            "الملفات المسموح بيها :  JPEG , PNG",
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                          AppText(
                            "الحد الاقصي : 5MB",
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
