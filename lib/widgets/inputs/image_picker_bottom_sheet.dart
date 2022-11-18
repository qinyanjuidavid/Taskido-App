import "package:flutter/material.dart";

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    // Camera
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
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
                    // Gallery
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
