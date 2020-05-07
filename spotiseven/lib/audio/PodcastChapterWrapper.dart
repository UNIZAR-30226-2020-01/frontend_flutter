
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';

class PodcastChapterWrapper extends Playlist{

  PodcastChapterWrapper(PodcastChapter pc){
    // Hacemos pasar nuestro <pc> por una playlist con una sola cancion.
    super.title = pc.podcast.title;
    UserDAO.getUserData().then((User user) => super.user = user.username);
    super.playlist = _convertToSongList(pc);
    super.num_songs = 1;
  }

  List<Song> _convertToSongList(PodcastChapter pc) {
    Song s = Song(
      title: pc.title,
      url: pc.url,
      // TODO: Cuadrar estos argumentos
      album: Album(
        artista: Artist(
          name: pc.podcast.canal.title
        ),
        photoUrl: pc.photoUrl,
        titulo: pc.podcast.title,
      ),
      favorite: false,
      // TODO: Integrar la URL del podcast episode aqui
      urlApi: pc.url,
      // TODO: Cuadrar estos argumentos
      lyrics: 'Un podcast no dispone de lyrics'
    );
    return [s];
  }
}