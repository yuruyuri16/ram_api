import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

/// The status of the character.
enum CharacterStatus {
  /// Alive status.
  @JsonValue('Alive')
  alive,

  /// Dead status.
  @JsonValue('Dead')
  dead,

  /// Unknown status.
  @JsonValue('unknown')
  unknown;
}

///
@JsonSerializable(createToJson: false)
final class Character {
  ////
  const Character({
    required this.id,
    required this.name,
    required this.status,
  });

  ///
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// The id of the character.
  final int id;

  /// The name of the character.
  final String name;

  ///
  final CharacterStatus status;
}
