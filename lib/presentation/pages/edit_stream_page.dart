import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/stream_model.dart';
import '../controllers/stream_controller.dart';

class EditStreamPage extends StatelessWidget {
  final StreamController streamController = Get.find<StreamController>();
  final StreamModel stream = Get.arguments;

  final TextEditingController urlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final RxString selectedPlatform = ''.obs;
  final RxString thumbnailUrl = ''.obs;

  EditStreamPage({super.key}) {
    urlController.text = stream.url;
    titleController.text = stream.title;
    selectedPlatform.value = stream.platform;
    thumbnailUrl.value = stream.thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    urlController.addListener(() async {
      final url = urlController.text.trim();

      if (url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath == true) {
        try {
          final metadata = await streamController.fetchMetadata(url);
          thumbnailUrl.value = metadata.thumbnailUrl; 
        } catch (e) {
          thumbnailUrl.value = '';
        }
      } else {
        thumbnailUrl.value = ''; 
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Stream'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.red,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            onPressed: () => _showDeleteConfirmationDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionLabel('Streaming / Video Link'),
              TextField(
                controller: urlController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Paste your streaming link'),
              ),
              const SizedBox(height: 16),

              _buildSectionLabel('Select your Streaming Platform'),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: selectedPlatform.value,
                  decoration: _inputDecoration(null),
                  dropdownColor: Colors.grey[900],
                  style: const TextStyle(color: Colors.white),
                  items: ['YouTube', 'Twitch', 'Facebook']
                      .map(
                        (platform) => DropdownMenuItem(
                          value: platform,
                          child: Text(platform,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) selectedPlatform.value = value;
                  },
                ),
              ),
              const SizedBox(height: 16),

              _buildSectionLabel('Video / Stream Title'),
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Enter your Stream Title'),
              ),
              const SizedBox(height: 16),

              Obx(() {
                if (thumbnailUrl.value.isNotEmpty) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                        image: NetworkImage(thumbnailUrl.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    color: Colors.grey[800],
                    child: const Text(
                      'Thumbnail preview will be fetched automatically',
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }
              }),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _handleSave();
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration _inputDecoration(String? hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _handleSave() async {
    final url = urlController.text.trim();
    final title = titleController.text.trim();
    final platform = selectedPlatform.value;

    if (url.isEmpty || title.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      String finalThumbnail = thumbnailUrl.value;
      if (url != stream.url) {
        final metadata = await streamController.fetchMetadata(url);
        finalThumbnail = metadata.thumbnailUrl;
      }

      streamController.updateStream(
        oldStream: stream,
        updatedStream: StreamModel(
          platform: platform,
          title: title,
          url: url,
          thumbnail: finalThumbnail,
        ),
      );

      Get.snackbar(
        'Success',
        'Stream updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await Future.delayed(const Duration(milliseconds: 1500));

      Navigator.of(Get.context!).pop();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update stream. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Get.back(), 
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Delete Stream',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Are you sure you want to delete the stream?',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final int index =
                          streamController.streams.indexOf(stream);
                      streamController.deleteStream(index);
                      Get.snackbar(
                        'Deleted',
                        'Stream "${stream.title}" was deleted successfully.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                      Navigator.of(Get.context!).pop();
                      Navigator.of(Get.context!)
                          .pop();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
