import '../entities/metadata.dart';

abstract class StreamRepository {
  Future<Metadata> fetchMetadata(String url);
}
