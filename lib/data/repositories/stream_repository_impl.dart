import '../../domain/entities/metadata.dart';
import '../../domain/repositories/stream_repository.dart';
import '../datasources/metadata_datasource.dart';
import '../models/metadata_model.dart';

class StreamRepositoryImpl implements StreamRepository {
  final MetadataDataSource dataSource;

  StreamRepositoryImpl(this.dataSource);

  @override
  Future<Metadata> fetchMetadata(String url) async {
    final MetadataModel metadataModel = await MetadataDataSource.fetchMetadata(url);
    return Metadata(
      platformName: metadataModel.platformName,
      title: metadataModel.title,
      thumbnailUrl: metadataModel.thumbnailUrl,
    );
  }
}
