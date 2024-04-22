import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api.dart';
import 'models/answer_model.dart';
import 'models/question_model.dart';

final expertSystemControllerProvider =
    StateNotifierProvider<ExpertSystemController, ExpertSystemState>((ref) {
  return ExpertSystemController(ref.watch(apiProvider));
});

class ExpertSystemController extends StateNotifier<ExpertSystemState> {
  ExpertSystemController(this.api) : super(ExpertSystemState.initial()) {
    fetchQuestions();
  }

  final TestingApi api;

  void fetchQuestions() async {
    try {
      final response = await api.fetch();
      final data = response.data as List<dynamic>;
      final List<QuestionModel> questions =
          data.map((e) => QuestionModel.fromMap(e)).toList();
      inspect(questions);

      state = state.copyWith(questions: AsyncValue.data(questions));
    } catch (e, st) {
      print(st);
      state = state.copyWith(questions: AsyncValue.error(e, st));
    }
  }

  void nextQuestion() {
    final questionIndex = state.questionIndex + 1;
    state = state.copyWith(questionIndex: questionIndex);
  }

  void addAnswer(AnswerModel answer) {
    final answers = [...state.answers, answer];
    state = state.copyWith(answers: answers);
  }

  void reset() {
    state = ExpertSystemState.initial();

    fetchQuestions();
  }

  void submitAnswers() async {
    final response = await api.getResults(state.answers);

    final data = response.data as List<dynamic>;

    final List<DiagnosesModel> symptoms = data.map((e) => DiagnosesModel.fromMap(e)).toList();

    state = state.copyWith(symptoms: symptoms);
  }
}

class DiagnosesModel {
  final String diagnosisName;
  final String solutions;

  DiagnosesModel({
    required this.diagnosisName,
    required this.solutions,
  });

  DiagnosesModel copyWith({
    String? diagnosisName,
    String? solutions,
  }) {
    return DiagnosesModel(
      diagnosisName: diagnosisName ?? this.diagnosisName,
      solutions: solutions ?? this.solutions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'diagnosis': diagnosisName,
      'solutions': solutions,
    };
  }

  factory DiagnosesModel.fromMap(Map<String, dynamic> map) {
    return DiagnosesModel(
      diagnosisName: map['diagnosis'] as String,
      solutions: map['Solution'] as String,
    );
  }

}



class ExpertSystemState {
  final AsyncValue<List<QuestionModel>> questions;
  final int questionIndex;
  final List<AnswerModel> answers;
  final List<DiagnosesModel> symptoms;
  final bool isLoading;

  ExpertSystemState({
    required this.questions,
    required this.questionIndex,
    required this.answers,
    this.symptoms = const [],
    this.isLoading = false,
  });

  factory ExpertSystemState.initial() {
    return ExpertSystemState(
        questions: const AsyncValue.loading(),
        questionIndex: 0,
        answers: [],
        symptoms: [],
        isLoading: false);
  }

  ExpertSystemState copyWith({
    AsyncValue<List<QuestionModel>>? questions,
    int? questionIndex,
    List<AnswerModel>? answers,
    List<DiagnosesModel>? symptoms,
    bool? isLoading,
  }) {
    return ExpertSystemState(
      questions: questions ?? this.questions,
      questionIndex: questionIndex ?? this.questionIndex,
      answers: answers ?? this.answers,
      symptoms: symptoms ?? this.symptoms,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() =>
      'ExpertSystemState(questions: $questions, questionIndex: $questionIndex, answers: $answers)';
}
