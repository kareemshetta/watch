import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String title;

  const Genre({required this.id, required this.title});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title];
}
