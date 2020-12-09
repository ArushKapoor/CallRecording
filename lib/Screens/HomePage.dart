import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterSoundPlayer _myPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited;
  bool _mRecorderIsInited;

  @override
  void initState() {
    super.initState();
    _myPlayer.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
    _myRecorder.openAudioSession().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
  }

  @override
  void dispose() {
    _myPlayer.closeAudioSession();
    _myPlayer = null;
    _myRecorder.closeAudioSession();
    _myRecorder = null;
    super.dispose();
  }

  void play() async {
    await _myPlayer.startPlayer(
        // fromURI: _exampleAudioFilePathMP3,
        codec: Codec.mp3,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
  }

  Future<void> stopPlayer() async {
    if (_myPlayer != null) {
      await _myPlayer.stopPlayer();
    }
  }

  Future<void> record() async {
    await _myRecorder.startRecorder(
      // toFile: _mPath,
      codec: Codec.aacADTS,
    );
  }

  Future<void> stopRecorder() async {
    await _myRecorder.stopRecorder();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Recorder'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              play();
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text('Play Sound'),
            ),
          ),
          GestureDetector(
            onTap: () {
              stopPlayer();
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text('Stop Sound'),
            ),
          ),
          GestureDetector(
            onTap: () {
              record();
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text('Record Audio'),
            ),
          ),
          GestureDetector(
            onTap: () {
              stopRecorder();
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text('Stop Recording Audio'),
            ),
          ),
        ],
      ),
    );
  }
}
