import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  const Coffee({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}
