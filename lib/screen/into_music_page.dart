import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mp3_app/bloc/music_bloc.dart';
import 'package:mp3_app/bloc/music_event.dart';
import 'package:mp3_app/bloc/music_state.dart';
import 'package:mp3_app/util/my_utils.dart';

class IntoMusicPage extends StatefulWidget {
  final int id;

  const IntoMusicPage({super.key, required this.id});

  @override
  State<IntoMusicPage> createState() => _IntoMusicPageState();
}

class _IntoMusicPageState extends State<IntoMusicPage> {
  final AudioPlayer player = AudioPlayer();

  int timeToSeek = 10;
  bool isPlaying = false;
  bool repeat = false;

  Duration currentDuration = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    pullPush();
    complate();
    time();
    super.initState();
  }

  
  pullPush() {
    return player.onPositionChanged.listen((Duration d) {
      setState(() {
        currentDuration = d;
      });
    });
  }

  time() {
    return player.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
  }

  complate() {
    return player.onPlayerComplete.listen((event) {
      isPlaying = false;
       duration = Duration.zero;
       currentDuration = Duration.zero;
      setState(() {});
    });
  }

  
    var sonOne = 0;
  


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MusicBloc()..add(FetchMusic(musicPath: myMusic[widget.id])),
      child: Scaffold(
        backgroundColor: const Color(0xFF091227),
        appBar: AppBar(
          leading: IconButton(onPressed: () async {
             await player.stop();
             // ignore: use_build_context_synchronously
             Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text('Player Now'),
          backgroundColor: const Color(0xFF091227),
        ),
        body: BlocBuilder<MusicBloc, MusicState>(
          builder: (context, state) {
            if (state is InitalMusicState) {
              return const SizedBox(
                child: Text('malumot yoq'),
              );
            } else if (state is MusicDateState) {
              return Column(
                children: [
                  SizedBox(
                    height: height(context) * 0.06,
                  ),
                  Image.asset(myMusicImage[widget.id]),
                  SizedBox(
                    height: height(context) * 0.03,
                  ),
                  Text(
                    myMusicName[widget.id],
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: height(context) * 0.04,
                  ),
                  leftRight(),
                  SizedBox(
                    height: height(context) * 0.06,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width(context) * 0.067),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${currentDuration.inSeconds}",
                            style: const TextStyle(color: Colors.white38)),
                        Text(
                          "${duration.inSeconds}",
                          style: const TextStyle(color: Colors.white38),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: currentDuration.inSeconds / 1,
                    max: duration.inSeconds / 1,
                    divisions: 100,
                    onChanged: (value) async {
                      player.seek(Duration(
                          seconds: currentDuration.inMinutes + (value ~/ 1)));
                      setState(() {
                        currentDuration = value as Duration;
                      });
                    },
                  ),
                  SizedBox(height: height(context)*0.01,),
                  start(state,widget.id),
                ],
              );
            }
            return Container(
              color: Colors.amber,
            );
          },
        ),
      ),
    );
  }

  start(state,id) {
    return Padding(
      padding: EdgeInsets.only(left: width(context) * 0.23),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: width(context) * 0.06),
            child: IconButton(
                onPressed: () async {},
                icon: SvgPicture.asset(
                  'assets/icons/right.svg',
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height(context) * 0.01),
            child: IconButton(
              splashRadius: 0.01,
              onPressed: () async {
                if (isPlaying) {
                  player.pause();
                } else {
                  await player.play(AssetSource(myMusic[id]));
                }
                isPlaying = !isPlaying;
                setState(() {});
              },
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width(context) * 0.06),
            child: IconButton(
                onPressed: () async {
                  setState(() {
                  });
                },
                icon: SvgPicture.asset(
                  'assets/icons/left.svg',
                )),
          ),
        ],
      ),
    );
  }


  leftRight() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width(context)*0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              if (currentDuration.inSeconds > 10) {
                await player
                    .seek(Duration(seconds: currentDuration.inSeconds - 10));
              }
              setState(() {});
            },
            icon: const Icon(
              Icons.keyboard_double_arrow_left_rounded,
              color: Colors.white38,
              size: 30,
            ),
          ),
          IconButton(
              onPressed: () async {
                await player
                    .seek(Duration(seconds: currentDuration.inSeconds + 10));
                setState(() {});
              },
              icon: const Icon(
                Icons.keyboard_double_arrow_right_sharp,
                color: Colors.white38,
                size: 30,
              )),
        ],
      ),
    );
  }
}
