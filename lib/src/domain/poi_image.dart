import 'package:objectbox/objectbox.dart';

@Entity()
class PoiImage {
  @Id()
  int id = 0;
  String? thumbnail;
  String? imageUrl;

  PoiImage({this.thumbnail, this.imageUrl});
}
