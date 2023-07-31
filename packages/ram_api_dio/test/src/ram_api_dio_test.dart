// ignore_for_file: prefer_const_constructors
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ram_api/ram_api.dart';
import 'package:ram_api_dio/ram_api_dio.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class MockRamApiDio extends Mock implements RamApiDio {}

void main() {
  group('RamApiDio', () {
    late Dio httpClient;
    late RamApiDio ramApi;

    setUp(() {
      httpClient = MockDio();
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        ramApi = RamApiDio();
        expect(ramApi, isNotNull);
      });

      test('can receive an httpClient', () {
        when(() => httpClient.options).thenReturn(BaseOptions());
        ramApi = RamApiDio(httpClient: httpClient);
        expect(ramApi, isNotNull);
      });
    });

    group('getCharacters', () {
      setUp(() {
        when(() => httpClient.options).thenReturn(BaseOptions());
        ramApi = RamApiDio(httpClient: httpClient);
      });
      test('makes correct http request (no query params).', () async {
        when(
          () => httpClient.get<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'info': <String, String>{}, 'results': <dynamic>[]},
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        );

        await ramApi.getCharacters();

        verify(
          () => httpClient.get<Map<String, dynamic>>(
            any(),
            queryParameters: {'page': 1},
          ),
        ).called(1);
      });
    });
  });
}
