import 'package:firebase_database/firebase_database.dart';
import 'shortvideo.dart';

class ShortvideoDao {
  final DatabaseReference _shortvideoRef =
      FirebaseDatabase.instance.reference().child('short-video');

  /*void saveShortvideo(Shortvideo shortvideo) {
    _shortvideoRef.push().set(shortvideo.toJson());
  }*/

  Query getShortvideoQuery() {
    return _shortvideoRef;
  }
}
