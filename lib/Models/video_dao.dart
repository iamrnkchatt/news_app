import 'package:firebase_database/firebase_database.dart';
import 'video_model.dart';

class VideoDao {
  final DatabaseReference _videoRef =
      FirebaseDatabase.instance.reference().child('video');

  void savevideo(Videomodel videomodel) {
    _videoRef.push().set(videomodel.toJson());
  }

  Query getvideoQuery() {
    return _videoRef;
  }
}
