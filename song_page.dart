import 'package:flutter/material.dart';
import 'package:music/neubox.dart';
import 'package:music/utils/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String format(Duration duration) {
    String twoDigits = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String finalTime = "${duration.inMinutes}:$twoDigits";
    return finalTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final playlist = value.playlist;
        final currentSong = playlist[value.currentSong ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  // custom app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text("P L A Y L I S T"),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  // album cover
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentSong.imagePath),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentSong.songName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),),
                                  Text(currentSong.artist),
                                ],
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40,),

                  // progress bar
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // start time
                            Text(format(value.currentDuration)),

                            // shuffle icon
                            const Icon(Icons.shuffle),

                            // repeat
                            const Icon(Icons.repeat),

                            // end time
                            Text(format(value.totalDuration)),
                          ],
                        ),
                      ),
                      Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.blue,
                        onChanged: (double d) {
                          value.seek(Duration(seconds: d.toInt()));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),

                  // playback
                  Row(
                    children: [
                      // previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.prevSong,
                          child: const NeuBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      // play pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pOrR,
                          child: NeuBox(
                            child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      // next
                      Expanded(
                        child: GestureDetector(
                          onTap: value.nextSong,
                          child: const NeuBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ),
        );
      }
    );
  }
}
