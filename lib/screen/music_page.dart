import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp3_app/bloc/music_bloc.dart';
import 'package:mp3_app/bloc/music_event.dart';
import 'package:mp3_app/screen/into_music_page.dart';
import 'package:mp3_app/util/my_utils.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => MusicBloc(),
      child: Scaffold(
        backgroundColor: const Color(0XFF091227),
        appBar: AppBar(
          toolbarHeight: 10,
          elevation: 0,
          backgroundColor: const Color(0XFF091227),
          ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width(context)*0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height(context)*0.01,bottom: height(context)*0.02),
                child: const Text('Music Categories',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: width(context)*0.07,
                    mainAxisExtent: height(context)*0.26,
                    mainAxisSpacing: height(context)*0.01
                  ), 
                  cacheExtent: 40,
                itemBuilder:(context, index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<MusicBloc>(context).add(FetchMusic(musicPath: myMusic[index]));
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>  IntoMusicPage(id: index)));
                    },
                    child: category(context,index)
                  );
                  
                },),
              )
              
            ],
          ),
        ),
      ),
    );
  }

 Widget category(context,index) {
  return Container(
    decoration: BoxDecoration(
      // color: Colors.white,
    color: const Color(0XFF091227),
      borderRadius: BorderRadius.circular(width(context)*0.02)
    ),
    child: Column(children: [
      Container(
        height: height(context)*0.186,
        decoration:  BoxDecoration(
         boxShadow: [
          BoxShadow(
            color: myMusicColor[index],
            offset: const Offset(0,14),
            spreadRadius: -20,
            blurRadius: 20
          )
          ],
         borderRadius: BorderRadius.circular(width(context)*0.02),
          image: DecorationImage(
            image: AssetImage(myMusicImage[index]))
        ),
      ),
      SizedBox(height: height(context)*0.009,),
      Text(myMusicName[index],style: const TextStyle(fontSize: 16,color: Colors.white),),
      SizedBox(height: height(context)*0.005,),
      const Text('IMAGINE DRAGON',style: TextStyle(fontSize: 12,color: Color(0xFF404f73)),),

    ]),
  );
 }
}

