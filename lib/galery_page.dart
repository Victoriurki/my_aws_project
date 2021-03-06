import 'package:flutter/material.dart';

// 1
class GalleryPage extends StatelessWidget {
  // 2
  final VoidCallback shouldLogOut;
  // 3
  final VoidCallback shouldShowCamera;

  const GalleryPage(
      {Key? key, required this.shouldLogOut, required this.shouldShowCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          // 4
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: shouldLogOut,
              child: const Icon(
                Icons.logout,
              ),
            ),
          )
        ],
      ),
      // 5
      floatingActionButton: FloatingActionButton(
        onPressed: shouldShowCamera,
        child: const Icon(
          Icons.camera_alt,
        ),
      ),
      body: Container(child: _galleryGrid()),
    );
  }

  Widget _galleryGrid() {
    // 6
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 3,
      itemBuilder: (context, index) {
        // 7
        return const Placeholder();
      },
    );
  }
}
