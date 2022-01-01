import 'package:firebase_database/firebase_database.dart';
import 'livenews.dart';

class LivenewsDao {
  final DatabaseReference _livenewsRef =
      FirebaseDatabase.instance.reference().child('live_news');

  void saveLiveNews(Livenews livenews) {
    _livenewsRef.push().set(livenews.toJson());
  }

  Query getLiveNewsQuery() {
    return _livenewsRef;
  }
}
