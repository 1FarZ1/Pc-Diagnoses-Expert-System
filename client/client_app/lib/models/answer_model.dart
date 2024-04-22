// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class AnswerModel {
  final String symptom;
  AnswerModel({
    required this.symptom,
  });

  AnswerModel copyWith({
    String? symptom,
  }) {
    return AnswerModel(
      symptom: symptom ?? this.symptom,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symptom': symptom,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      symptom: map['symptom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnswerModel(symptom: $symptom)';

  @override
  bool operator ==(covariant AnswerModel other) {
    if (identical(this, other)) return true;

    return other.symptom == symptom;
  }

  @override
  int get hashCode => symptom.hashCode;
}
