import 'package:gamerstag_stream_app/data/datasources/metadata_datasource.dart';
import 'package:gamerstag_stream_app/data/models/metadata_model.dart';
import 'package:gamerstag_stream_app/data/models/stream_model.dart';
import 'package:get/get.dart';
import '../../domain/entities/metadata.dart';

class StreamController extends GetxController {
  final RxList<StreamModel> streams = <StreamModel>[].obs;

  // Fetch metadata from the URL
  Future<MetadataModel> fetchMetadata(String url) async {
    return await MetadataDataSource.fetchMetadata(url);
  }

  // Add a new stream to the list
  void addStream({
    required String platform,
    required String title,
    required String url,
    required String thumbnail,
  }) {
    streams.add(StreamModel(
      platform: platform,
      title: title,
      url: url,
      thumbnail: thumbnail,
    ));
  }


  void updateStream({required StreamModel oldStream, required StreamModel updatedStream}) {
  final index = streams.indexWhere((s) => s == oldStream);
  if (index != -1) {
    streams[index] = updatedStream;
  }
}

  void deleteStream(int index) {
    streams.removeAt(index);
  }
}
