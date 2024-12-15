import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stream_controller.dart';
import '../widgets/stream_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  final StreamController controller = Get.put(StreamController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live Streams',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search and Add Button Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Search Bar
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for Videos",
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),

                // Add Button
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/addStream');
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE13A3E), Color(0xFFB3222B)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stream List
          Expanded(
            child: Obx(() {
              if (controller.streams.isEmpty) {
                return const Center(
                  child: Text(
                    'No live streams available.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.streams.length,
                itemBuilder: (context, index) {
                  final stream = controller.streams[index];
                  return StreamCard(
                    thumbnailUrl: stream.thumbnail,
                    platformIconAsset: _getPlatformIconPath(stream.platform),
                    title: stream.title,

                    // Delete Functionality
                    onDelete: () {
                      controller.deleteStream(index);
                      Get.snackbar(
                        'Deleted',
                        'Stream "${stream.title}" was deleted successfully.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    },

                    // Edit Functionality
                    onEdit: () {
                      Get.toNamed('/editStream', arguments: stream);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  // Helper to get platform icon URL
  String _getPlatformIconPath(String platform) {
    switch (platform.toLowerCase()) {
      case 'youtube':
        return 'assets/icons/youtube.svg';
      case 'twitch':
        return 'assets/icons/twitch.svg';
      case 'facebook':
        return 'assets/icons/facebook.svg';
      default:
        return 'assets/icons/placeholder.svg';
    }
  }
}
