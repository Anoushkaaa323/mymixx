import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:external_app_launcher/external_app_launcher.dart';

void main() => runApp(mymixx());

class mymixx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: set_time());
  }
}

class set_time extends StatefulWidget {
  const set_time({super.key});

  @override
  State<set_time> createState() => _State();
}

class _State extends State<set_time> {
  @override
  TextEditingController _controller = TextEditingController();
  int time = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      child: Image.asset('images/logo.png'),
                    ),
                    Flexible(
                        child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'How long are you listening for?',
                          textStyle: const TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          speed: const Duration(milliseconds: 75),
                        ),
                      ],
                      isRepeatingAnimation: false,
                    )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white), // Text color
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'in minutes',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    // Faded hint text color
                  ),
                  cursorColor: Colors.white,
                ),
                SizedBox(height: 50),
                Center(
                  child: TextButton(
                    onPressed: () {
                      int number = int.tryParse(_controller.text) ?? 0;
                      setState(() {
                        time = number;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => set_mood(time: time),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'next',
                          style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                )
              ])),
    );
  }
}

class set_mood extends StatefulWidget {
  final int time;

  set_mood({required this.time});

  @override
  State<set_mood> createState() => _set_moodState();
}

class _set_moodState extends State<set_mood> {
  Color button1_colour = Colors.grey.shade900;
  Color button2_colour = Colors.grey.shade900;
  Color button3_colour = Colors.grey.shade900;
  Color button4_colour = Colors.grey.shade900;

  String mood = 'shower';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 60.0,
                  child: Image.asset('images/logo.png'),
                ),
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'What\'re you up to?',
                        textStyle: const TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        speed: const Duration(milliseconds: 75),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      // Background color of the container
                      border: Border.all(
                        color: button1_colour, // Border color
                        width: 2.0, // Border width
                      ),
                      // Optional: Add rounded corners
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            mood = 'shower';
                            button1_colour = Colors.white;
                            button2_colour = Colors.grey.shade900;
                            button3_colour = Colors.grey.shade900;
                            button4_colour = Colors.grey.shade900;
                          });
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Colors.grey.shade900,
                        ),
                        child: Image.asset('images/shower.png')),
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      // Background color of the container
                      border: Border.all(
                        color: button2_colour, // Border color
                        width: 2.0, // Border width
                      ),
                      // Optional: Add rounded corners
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            mood = 'workout';
                            button1_colour = Colors.grey.shade900;
                            button2_colour = Colors.white;
                            button3_colour = Colors.grey.shade900;
                            button4_colour = Colors.grey.shade900;
                          });
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Colors.grey.shade900,
                        ),
                        child: Image.asset('images/dumbell.png')),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      // Background color of the container
                      border: Border.all(
                        color: button3_colour, // Border color
                        width: 2.0, // Border width
                      ),
                      // Optional: Add rounded corners
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            mood = 'study';
                            button1_colour = Colors.grey.shade900;
                            button2_colour = Colors.grey.shade900;
                            button3_colour = Colors.white;
                            button4_colour = Colors.grey.shade900;
                          });
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Colors.grey.shade900,
                        ),
                        child: Image.asset('images/study.png')),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      // Background color of the container
                      border: Border.all(
                        color: button4_colour, // Border color
                        width: 2.0, // Border width
                      ),
                      // Optional: Add rounded corners
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            mood = 'sleep';
                            button1_colour = Colors.grey.shade900;
                            button2_colour = Colors.grey.shade900;
                            button3_colour = Colors.grey.shade900;
                            button4_colour = Colors.white;
                          });
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Colors.grey.shade900,
                        ),
                        child: Image.asset('images/sleep.png')),
                  ),
                ),
              ],
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => set_time(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'back',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            set_vibe(time: widget.time, mood: mood),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'next',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class set_vibe extends StatefulWidget {
  final int time;
  final String mood;
  const set_vibe({required this.time, required this.mood});

  @override
  State<set_vibe> createState() => _set_vibeState();
}

class _set_vibeState extends State<set_vibe> {
  @override
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  String song_name = '';
  String artist_name = '';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      child: Image.asset('images/logo.png'),
                    ),
                    Flexible(
                        child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Choose a song to set the vibe.',
                          textStyle: const TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          speed: const Duration(milliseconds: 75),
                        ),
                      ],
                      isRepeatingAnimation: false,
                    )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _controller1,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white), // Text color
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'song name',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    // Faded hint text color
                  ),
                  cursorColor: Colors.white,
                ),
                SizedBox(height: 50),
                TextField(
                  controller: _controller2,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white), // Text color
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'artist name',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    // Faded hint text color
                  ),
                  cursorColor: Colors.white,
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => set_mood(time: widget.time),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            'back',
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String ans1 = _controller1.text;
                        String ans2 = _controller2.text;
                        setState(() {
                          song_name = ans1;
                          artist_name = ans2;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Generate(
                                  time: widget.time,
                                  mood: widget.mood,
                                  songName: song_name,
                                  artistName: artist_name),
                            ),
                          );
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            'next',
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
    );
  }
}


class Generate extends StatefulWidget {
  final int time;
  final String mood;
  final String songName;
  final String artistName;

  Generate({
    required this.time,
    required this.mood,
    required this.songName,
    required this.artistName,
    Key? key,
  }) : super(key: key);

  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = initialize();
  }

  Future<void> initialize() async {
    String accessToken = await tryToConnect();
    if (accessToken.isNotEmpty) {
      _getPlaylist(_createQuery(), accessToken);
    } else {
      print("Failed to get access token");
    }
  }

  String _createQuery() {
    String query =
        'Give me a list of songs to create a playlist for me to ${widget.mood} to. The total duration of the playlist should be  roughly ${widget.time} minutes. The playlist should include and be similar to  ${widget.songName} by ${widget.artistName} and in the same genre. The playlist should have songs by many different artists. Respond only in text in this format "<Song name> - <Artist name>"';

    return query;
  }

  Future<String> getSpotifyTrackUri(
      String trackName, String artistName, String accessToken) async {
    final String baseUrl = 'https://api.spotify.com/v1/search';
    final String query = '$trackName artist:$artistName';
    final String url =
        '$baseUrl?q=${Uri.encodeComponent(query)}&type=track&limit=1';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['tracks']['items'].isNotEmpty) {
          return data['tracks']['items'][0]['uri'];
        }
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching track URI: $e');
    }

    return ""; // Return an empty string if URI retrieval fails
  }

  Future<String> tryToConnect() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      String accessToken = await SpotifySdk.getAccessToken(
        clientId: "a1816ae2a9f849bf85f5c56cf9070065",
        redirectUrl: "mymixx://callback",
        scope:
        "app-remote-control,user-modify-playback-state,playlist-read-private",
      );

      bool result = await SpotifySdk.connectToSpotifyRemote(
        clientId: "a1816ae2a9f849bf85f5c56cf9070065",
        redirectUrl: "mymixx://callback",
        accessToken: accessToken,
      );

      print("CONNECTED: $accessToken");
      return accessToken;
    } on PlatformException catch (e) {
      print("ERROR: ${e.message}");
      return "";
    } on MissingPluginException {
      print("PLUGIN PROBLEM");
      return "";
    }
  }

  void _getPlaylist(String query, String accessToken) async {
    final model  = await GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyC58EnyjQTW8-3U3bWIc1YV4Hh75UmHR3E',
    );
    final prompt = query;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    var responseText = await response.text;
    if (responseText != null) {
      List<String> lines = responseText.split('\n');
      RegExp regExp =
      RegExp(r'["“”]([^"“”]+)["“”]\s*-\s*([^"\n]+)'); // Updated regex
      for (String line in lines) {
        Match? match = regExp.firstMatch(line);
        if (match != null) {
          String songName = match.group(1)!.trim();
          String artistName = match.group(2)!.trim();
          var trackUri =
          await getSpotifyTrackUri(songName, artistName, accessToken);
          if (trackUri.isNotEmpty) {
            await addToQueue(trackUri);
            print("Added track: $songName - $artistName");
          } else {
            print("Failed to get URI for: $songName - $artistName");
          }
        }
      }
    }
    else{
      print("NO RESPONSE");
    }
    SpotifySdk.resume();
    SpotifySdk.disconnect();
    print("DISCONNECTED FROM SPOTIFY");
    await LaunchApp.openApp(
      androidPackageName: 'com.spotify.music'
    );
  }


  Future<void> addToQueue(String trackUri) async {
    try {
      await SpotifySdk.queue(spotifyUri: trackUri);
    } catch (e) {
      print("Error adding track to queue: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 60.0,
                  child: Image.asset('images/logo.png'),
                ),
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'We\'re generating a mix perfect for you... ',
                        textStyle: const TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 75),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}