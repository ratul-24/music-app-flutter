import 'package:flutter/material.dart';
import 'package:music/settings_page.dart';
import 'package:music/song_page.dart';
import 'package:music/utils/playlist_provider.dart';
import 'package:music/utils/song.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;
  @override
  void initState(){
    super.initState();
    playlistProvider=Provider.of<PlaylistProvider>(context,listen: false);
  }
  void goToSong(int index){
    playlistProvider.currentSong=index;
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=> const SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('M U S I C'),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 50,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              ),
            
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25),
              child: ListTile(
                title: const Text("H O M E"),
                leading: const Icon(Icons.home),
                onTap: () => Navigator.pop(context),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25),
              child: ListTile(
                title: const Text("S E T T I N G S"),
                leading: const Icon(Icons.settings),
                onTap: (){
                  Navigator.pop(context);

                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> const SettingsPage(),
                    ),
                  );
                },
              ),
            )
          ],

        ),
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context,value,child){
          final List<Song> playlist=value.playlist;

          return ListView.builder(
            itemCount: playlist.length,
          itemBuilder: (context, index){
            final Song s=playlist[index];
            return ListTile(
              title: Text(s.songName),
              subtitle: Text(s.artist),
              leading: Image.asset(s.imagePath),
              onTap: () => goToSong(index),


            );
          },
          );
        }
        ),
      );
  }
}