import 'package:dio/dio.dart';
import 'package:ram_api/ram_api.dart';

/// {@template ram_api_dio}
/// Rick and Morty API implementation using [Dio].
/// {@endtemplate}
class RamApiDio implements RamApi {
  /// {@macro ram_api_dio}
  RamApiDio({
    Dio? httpClient,
  }) : _httpClient = (httpClient ?? Dio())..options.baseUrl = _baseUrl;

  final Dio _httpClient;

  static const _baseUrl = 'https://rickandmortyapi.com';

  @override
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final charactersResponse = await _httpClient.get<Map<String, dynamic>>(
        '/character',
        queryParameters: {'page': page},
      );
      final responseJson = charactersResponse.data;
      if (responseJson == null) {
        throw const GetCharactersFailure('Empty body');
      }
      final charactersJson = responseJson['results'] as List<dynamic>;
      return charactersJson
          .map((json) => Character.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(GetCharactersFailure(error), stackTrace);
    }
  }

  @override
  Future<Character> getCharacter({required int id}) async {
    try {
      final characterResponse =
          await _httpClient.get<Map<String, dynamic>>('/character/$id');
      final characterJson = characterResponse.data;
      if (characterJson == null) throw const GetCharacterFailure('Empty body');
      return Character.fromJson(characterJson);
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(GetCharacterFailure(error), stackTrace);
    }
  }
}
