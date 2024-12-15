import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stream_controller.dart';
import '../widgets/stream_card.dart';

class HomePage extends StatelessWidget {
  final StreamController controller = Get.put(StreamController());
  final RxString searchQuery = ''.obs;

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      searchQuery.value = value; 
                    },
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

          Expanded(
            child: Obx(() {

              final filteredStreams = controller.streams.where((stream) {
                final query = searchQuery.value.toLowerCase();
                return stream.title.toLowerCase().contains(query) ||
                    stream.platform.toLowerCase().contains(query);
              }).toList();

              if (filteredStreams.isEmpty) {
                return const Center(
                  child: Text(
                    'No live streams available.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredStreams.length,
                itemBuilder: (context, index) {
                  final stream = filteredStreams[index];
                  return StreamCard(
                    thumbnailUrl: stream.thumbnail,
                    platformIconAsset: _getPlatformIconPath(stream.platform),
                    title: stream.title,

                    onDelete: () {
                      final originalIndex = controller.streams
                          .indexOf(stream);
                      controller.deleteStream(originalIndex);
                      Get.snackbar(
                        'Deleted',
                        'Stream "${stream.title}" was deleted successfully.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    },

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
