import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class CustomMultiImagePicker extends StatefulWidget {
  const CustomMultiImagePicker({
    super.key,
    required this.onImagesPicked,
    this.height,
    this.label,
    this.maxImages,
    this.initialImages,
  });

  final ValueChanged<List<File>> onImagesPicked;
  final double? height;
  final String? label;
  final int? maxImages;
  final List<File>? initialImages;

  @override
  State<CustomMultiImagePicker> createState() =>
      _CustomMultiImagePickerState();
}

class _CustomMultiImagePickerState extends State<CustomMultiImagePicker> {
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    if (widget.initialImages != null) {
      _selectedImages.addAll(widget.initialImages!);
    }
    super.initState();
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 80,
    );

    if (pickedFiles.isNotEmpty) {
      setState(() {
        final newImages = pickedFiles.map((e) => File(e.path)).toList();
        _selectedImages.addAll(newImages);

        if (widget.maxImages != null &&
            _selectedImages.length > widget.maxImages!) {
          _selectedImages.removeRange(
            widget.maxImages!,
            _selectedImages.length,
          );
        }
      });
      widget.onImagesPicked(_selectedImages);
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesPicked(_selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: widget.height ?? 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ..._selectedImages.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final image = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image,
                            height: widget.height ?? 100,
                            width: widget.height ?? 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                CupertinoIcons.xmark,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (widget.maxImages == null ||
                  _selectedImages.length < widget.maxImages!)
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: widget.height ?? 100,
                    width: widget.height ?? 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.grayColor),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.photo_on_rectangle,
                          size: 26,
                          color: AppColors.grayColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}