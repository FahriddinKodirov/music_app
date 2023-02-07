import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp3_app/bloc/music_event.dart';
import 'package:mp3_app/bloc/music_state.dart';

class MusicBloc extends Bloc<MusicEvent,MusicState> {
   MusicBloc():super(InitalMusicState()){
    on<FetchMusic>(_fetchMusic);
   }
  

 _fetchMusic(FetchMusic event, Emitter<MusicState> emit) {
  emit(MusicDateState(musicPath: event.musicPath));

 }
   
}