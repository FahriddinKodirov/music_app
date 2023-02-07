abstract class MusicState {}

class InitalMusicState extends MusicState {}

class MusicDateState extends MusicState {
  final String musicPath;

  MusicDateState({required this.musicPath});
}
