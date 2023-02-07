abstract class MusicEvent {}

class FetchMusic extends MusicEvent {
  final String musicPath;

  FetchMusic({required this.musicPath});
}

