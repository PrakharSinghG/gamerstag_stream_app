import '../entities/metadata.dart';
import '../repositories/stream_repository.dart';

class FetchMetadata {
  final StreamRepository repository;

  FetchMetadata(this.repository);

  Future<Metadata> execute(String url) async {
    return await repository.fetchMetadata(url);
  }
}
