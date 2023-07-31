import 'package:ram_api/ram_api.dart';

/// {@template ram_api_exception}
/// Exceptions from the Rick and Morty API client.
/// {@endtemplate}
abstract interface class RamApiException implements Exception {
  /// {@macro ram_api_exception}
  const RamApiException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template get_characters_failure}
/// Thrown during
/// {@endtemplate}
final class GetCharactersFailure extends RamApiException {
  ///
  const GetCharactersFailure(super.error);
}

///
final class GetCharacterFailure extends RamApiException {
  ///
  const GetCharacterFailure(super.error);
}

/// {@template ram_api}
/// Rick and Morty API Interface.
/// {@endtemplate}
abstract interface class RamApi {
  /// {@macro ram_api}
  const RamApi();

  /// Fetch all characters
  Future<List<Character>> getCharacters({int page});

  ///
  Future<Character> getCharacter({required int id});
}
