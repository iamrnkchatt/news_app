import 'package:firebase_database/firebase_database.dart';
import 'source.dart';

class SourceDao {
  final DatabaseReference _sourceRef =
      FirebaseDatabase.instance.reference().child('source');

  void saveSource(Source source) {
    _sourceRef.push().set(source.toJson());
  }

  Query getSourceQuery() {
    return _sourceRef;
  }
}
