import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Improv Singing Practice',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Improv Singing Practice'),
    );
  }
}

class Song {
  String title;
  String path;
  String progression;

  Song({this.title, this.path, this.progression});
}

final songs = [
  new Song(
      path: "alternative.mp3", title: "Alternative", progression: "F/C d a e"),
  new Song(path: "certain.mp3", title: "Certain", progression: "C G a F"),
  new Song(path: "chill.mp3", title: "Chill", progression: "F a Bb C"),
  new Song(path: "content.mp3", title: "Content", progression: "C e/C F/A G"),
  new Song(path: "dreamlike.mp3", title: "Dreamlike", progression: "C d a e/G"),
  new Song(path: "everyday.mp3", title: "Everyday", progression: "F a Bb C"),
  new Song(path: "evil.mp3", title: "Evil", progression: "b/F# e/G b* b"),
  new Song(path: "groovy.mp3", title: "Groovy", progression: "C C G G"),
  new Song(path: "happy.mp3", title: "Happy", progression: "C Bb F C"),
  new Song(path: "heavy.mp3", title: "Heavy", progression: "C E a E")
];

final words = [
  "birth",
  "rice",
  "development",
  "wave",
  "bit",
  "value",
  "hall",
  "ground",
  "level",
  "border",
  "book",
  "pancake",
  "cheese",
  "change",
  "ants",
  "meat",
  "train",
  "pets",
  "insurance",
  "minute",
  "crook",
  "plants",
  "respect",
  "nut",
  "market",
  "ocean",
  "cabbage",
  "bear",
  "sort",
  "ticket",
  "hate",
  "reward",
  "poison",
  "tramp",
  "advice",
  "middle",
  "mark",
  "chin",
  "basketball",
  "thumb",
  "room",
  "balance",
  "throat",
  "geese",
  "spring",
  "box",
  "structure",
  "point",
  "airplane",
  "ice",
  "cherries",
  "quill",
  "request",
  "yard",
  "yam",
  "wire",
  "woman",
  "force",
  "rose",
  "impulse",
  "dinner",
  "fold",
  "school",
  "grass",
  "flowers",
  "creator",
  "lock",
  "pigs",
  "dogs",
  "building",
  "aunt",
  "can",
  "letters",
  "fruit",
  "passenger",
  "shirt",
  "home",
  "discovery",
  "birds",
  "wing",
  "money",
  "oil",
  "knowledge",
  "songs",
  "yarn",
  "river",
  "angle",
  "pan",
  "secretary",
  "oranges",
  "girls",
  "detail",
  "truck",
  "drink",
  "voice",
  "sock",
  "dinosaurs",
  "grip",
  "cream",
  "notebook"
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  play(Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlayPage(
                song: song,
              )),
    );
  }

  playRandom() {
    var rng = Random();
    play(songs[rng.nextInt(songs.length)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shuffle),
          onPressed: () {
            playRandom();
          },
        ),
        body: ListView.separated(
          itemCount: songs.length,
          itemBuilder: (BuildContext context, int index) {
            Song song = songs[index];
            return GestureDetector(
                onTap: () {
                  play(song);
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                    height: 50,
                    // color: currentSong != null && currentSong.path == song.path
                    // ? Colors.black12
                    // : null,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                            "${songs[index].title}",
                            // style: TextStyle(color: currentSong != null && currentSong.path == song.path ? Colors.blue : Colors.black87)
                          )),
                          Text(" ${songs[index].progression}",
                              style: TextStyle(color: Colors.black26))
                        ]))));
          },
          separatorBuilder: (context, index) {
            return Divider(height: 1, thickness: 1);
          },
        ));
  }
}

class PlayPage extends StatefulWidget {
  final Song song;

  PlayPage({Key key, @required this.song}) : super(key: key);

  @override
  PlayPageState createState() => PlayPageState(song);
}

class PlayPageState extends State<PlayPage> {
  AudioPlayer advancedPlayer;
  Song song;
  String suggestion;

  PlayPageState(Song song) {
    this.song = song;
    this.suggestion = randomWord();
  }

  @override
  initState() {
    super.initState();
    play(song);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(song.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Stack(overflow: Overflow.visible, children: [
              Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(suggestion, style: TextStyle(fontSize: 48)),
                        Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child:
                              Text(song.title, style: TextStyle(fontSize: 24)),
                        ),
                        Text(song.progression,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54)),
                      ])),
              Positioned(
                  top: -10,
                  right: -10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: IconButton(
                      icon: Icon(Icons.shuffle),
                      color: Colors.white,
                      onPressed: () {
                        shuffle();
                      },
                    ),
                  )),
            ]),
          ),
        ));
  }

  setSong(Song song) {
    setState(() {
      this.song = song;
    });
  }

  setSuggestion(String suggestion) {
    setState(() {
      this.suggestion = suggestion;
    });
  }

  Future play(Song song) async {
    setSong(song);
    advancedPlayer = await AudioCache().loop("songs/" + song.path);
  }

  pause() {
    advancedPlayer.stop();
  }

  shuffle() {
    pause();
    var rng = Random();
    play(songs[rng.nextInt(songs.length)]);
    setSuggestion(words[rng.nextInt(words.length)]);
  }

  String randomWord() {
    var rng = Random();
    return words[rng.nextInt(words.length)];
  }

  @override
  void dispose() {
    advancedPlayer.stop();
    super.dispose();
  }
}
