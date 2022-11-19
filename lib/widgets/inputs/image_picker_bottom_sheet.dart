import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskido/services/profile_service.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _imagePicker = ImagePicker();
    Widget _makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    return _makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.1,
        maxChildSize: 0.2,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final _pickedImageFile =
                                await _imagePicker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 100,
                            );

                            if (_pickedImageFile != null) {
                              File _imageFile = File(_pickedImageFile.path);
                              _uploadFnc(_pickedImageFile.path, _imageFile);
                              Navigator.of(context).pop();
                              await Future.delayed(
                                const Duration(seconds: 8),
                              );
                              profileService.getProfile();
                            }
                          },
                          icon: const Icon(
                            Icons.photo,
                            size: 40,
                          ),
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final _capturedImage = await _imagePicker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 100,
                            );
                            if (_capturedImage != null) {
                              File _cameraFile = File(_capturedImage.path);
                              _uploadFnc(_capturedImage.path, _cameraFile);

                              Navigator.of(context).pop();
                              await Future.delayed(
                                const Duration(seconds: 8),
                              );
                              profileService.getProfile();
                            }
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 40,
                          ),
                        ),
                        const Text(
                          "Camera",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _uploadFnc(String? imagePath, File? profileImage) async {
    await profileService
        .profilePictureUpload(
      imagePath,
      profileImage,
      profileService.profileDetails.id,
    )
        .then((value) {
      print(value);
    });
  }
}
