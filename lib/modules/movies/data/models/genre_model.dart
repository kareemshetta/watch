import 'package:watch/modules/movies/domain/entities/geners.dart';

class GenreModel extends Genre {
  const GenreModel({required super.id, required super.title});

  factory GenreModel.fromJson(dynamic json) {
    print(json);
    final id = json['id'];
    final title = json['name'];
    return GenreModel(title: title, id: id);
  }
}
