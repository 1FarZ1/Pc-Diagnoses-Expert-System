import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/answer_model.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final apiProvider =
    Provider<TestingApi>((ref) => TestingApi(ref.watch(dioProvider)));

class TestingApi {
  TestingApi(this.client);

  final Dio client;
  Future<Response> fetch() async {
    try {
      final response = await client
          .get('https://grizzly-trusty-purely.ngrok-free.app/questions/');
      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Response> getResults(List<AnswerModel> answers) async {
    try {
      final response = await client.post(
          'https://grizzly-trusty-purely.ngrok-free.app/diagnose_issue',
          data: {'symptoms': answers.map((e) => e.toMap()).toList()});
      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
