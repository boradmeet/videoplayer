import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/screens/audio_player.dart';
import 'package:videoplayer/screens/carousel_slider_page.dart';
import 'package:videoplayer/screens/video_player_page.dart';
import 'global.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: buildMaterialColor( Colors.red),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const HomePage(),
        "audio_player_page": (context) => const AudioPage(),
        "video_player_page": (context) => const VideoPlayerPage(),
        "carousel_slider": (context) => const CarouselSliderPage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    for (var e in Global.videoPath) {
      Global.controller.add(VideoPlayerController.asset(e["path"])
        ..initialize().then(
          (_) {
            Global.chewieController.add(ChewieController(
              videoPlayerController:
                  Global.controller[Global.videoPath.indexOf(e)],
              autoPlay: false,
              looping: false,
            ));
          },
        ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio -- Video -- Carousel Slider"),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(

          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 168,
                child: Image.network("https://t3.ftcdn.net/jpg/00/85/61/98/360_F_85619893_qcV9Vr8GQGGToKKozmKZlon9M1rNwWNd.jpg"),
              ),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  child: const Text("Audio Player"),
                  onPressed: () {
                    Navigator.of(context).pushNamed("audio_player_page");
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 168,
                child: Image.network("https://www.softwaretestinghelp.com/wp-content/qa/uploads/2020/12/Top-Video-Player.png"),
              ),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("video_player_page");
                  },
                  child: const Text("Video Player"),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 300,
                child: Image.network("https://www.drupal.org/files/project-images/Multi-Slider---Non-Platform-Specific%20%281%29.png"),
              ),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("carousel_slider");
                  },
                  child: const Text("Carousel Slider"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
