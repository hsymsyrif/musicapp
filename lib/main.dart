import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'music_player_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MusicPlayerModel(),
      child: MaterialApp(
        title: 'Music App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MusicAppHomePage(),
      ),
    );
  }
}

class MusicAppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var playerModel = Provider.of<MusicPlayerModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Music App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: playerModel.songs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: playerModel.songs[index].albumArtUrl,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    playerModel.songs[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(playerModel.songs[index].artist),
                  trailing: Icon(Icons.play_arrow, color: Colors.deepPurple),
                  onTap: () {
                    playerModel.playSong(index);
                  },
                );
              },
            ),
          ),
          if (playerModel.currentSong != null) PlayerControlPanel(),
        ],
      ),
    );
  }
}

class PlayerControlPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var playerModel = Provider.of<MusicPlayerModel>(context);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[700],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Now Playing: ${playerModel.currentSong!.title}',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            playerModel.currentSong!.artist,
            style: TextStyle(color: Colors.grey[300], fontSize: 14),
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: playerModel.currentSong!.albumArtUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: Colors.white),
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.backward, color: Colors.white),
                onPressed: playerModel.previous,
              ),
              IconButton(
                icon: FaIcon(
                  playerModel.isPlaying
                      ? FontAwesomeIcons.pause
                      : FontAwesomeIcons.play,
                  color: Colors.white,
                ),
                onPressed: playerModel.isPlaying
                    ? playerModel.pause
                    : playerModel.play,
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.stop, color: Colors.white),
                onPressed: playerModel.stop,
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.forward, color: Colors.white),
                onPressed: playerModel.next,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
