import 'package:firebase_database/firebase_database.dart';
import 'news.dart';

class NewsDao {
  final DatabaseReference _newsRef =
      FirebaseDatabase.instance.reference().child('news');

  void saveNews(News news) {
    _newsRef.push().set(news.toJson());
  }

  Query getNewsQuery(String id) {
    if (id.isNotEmpty) {
      return _newsRef.orderByChild("category").equalTo(id);
    }else{
      return _newsRef;
    }
  }
}
