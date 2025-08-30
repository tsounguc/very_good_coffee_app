import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  const Coffee({
    required this.imageUrl,
  });

  /// Represents an empty [Coffe] instance.
  ///
  /// Used for default values or initializing empty states.
  const Coffee.empty()
    : this(
        imageUrl: '',
      );

  final String imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}
