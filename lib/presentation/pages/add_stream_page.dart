import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stream_controller.dart';

class AddStreamPage extends StatelessWidget {
  final StreamController streamController = Get.find<StreamController>();

  final TextEditingController urlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final RxString selectedPlatform = 'YouTube'.obs;
  final RxString thumbnailUrl = ''.obs;

  AddStreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    urlController.addListener(() async {
      final url = urlController.text.trim();

      if (url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath == true) {
        try {
          final metadata = await streamController.fetchMetadata(url);
          thumbnailUrl.value = metadata.thumbnailUrl;

          titleController.text = metadata.title;
        } catch (e) {
          thumbnailUrl.value = '';
          titleController.clear();
        }
      } else {
        thumbnailUrl.value = '';
        titleController.clear();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Stream'),
        backgroundColor: Colors.black87,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.red),
          onPressed: () => Get.back(),
        ),
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
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[800]!),
                      image: DecorationImage(
                        image: NetworkImage(thumbnailUrl.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[850]),
                    child: const Text(
                      'Thumbnail preview will be fetched automatically',
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }
              }),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                      'Cancel', Colors.grey[700]!, () => Get.back()),
                  _buildActionButton('Publish', Colors.red,
                      () async => await _handlePublish()),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
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

  ElevatedButton _buildActionButton(
      String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(120, 45),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _handlePublish() async {
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
      final metadata = await streamController.fetchMetadata(url);

      streamController.addStream(
        platform: platform,
        title: title,
        url: url,
        thumbnail: metadata.thumbnailUrl,
      );

      Get.snackbar(
        'Success',
        'Stream added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await Future.delayed(const Duration(milliseconds: 1500));
      Navigator.of(Get.context!).pop();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add stream. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
