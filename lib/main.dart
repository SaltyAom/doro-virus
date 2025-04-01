// Make sure to add following packages to pubspec.yaml:
// * media_kit
// * media_kit_video
// * media_kit_libs_video
import 'dart:async';
import 'dart:io';

import 'package:window_manager/window_manager.dart';

import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart'; // Provides [VideoController] & [Video] etc.
import 'package:media_kit_video/media_kit_video_controls/media_kit_video_controls.dart'
    show NoVideoControls;

import 'package:niku/namespace.dart' as n;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  WindowManager.instance
    ..ensureInitialized()
    ..setAsFrameless()
    ..maximize()
    ..center()
    ..setAlwaysOnTop(true)
    ..setSkipTaskbar(true)
    ..setResizable(false)
    ..setPreventClose(true)
    ..setVisibleOnAllWorkspaces(true)
    ..setMovable(false);

  runApp(
    const MaterialApp(home: MyScreen(), debugShowCheckedModeBanner: false),
  );
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  late final GlobalKey<VideoState> key = GlobalKey<VideoState>();
  late final player = Player();
  late final controller = VideoController(player);

  bool hasStartPlaying = false;

  @override
  void initState() {
    super.initState();

    player.open(Media('asset:///assets/doro.mp4'));

    Timer(Duration(seconds: 140), () {
      exit(0);
    });

    // player.stream.playing.listen((isPlaying) {
    //   if (isPlaying) {
    //     key.currentState?.enterFullscreen();

    //     hasStartPlaying = true;
    //   }
    // });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  build(context) {
    return Video(
        key: key,
        controller: controller,
        controls: NoVideoControls,
      ).niku
      ..fullSize;
  }
}
