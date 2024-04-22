import 'dart:convert';

class QuestionModel {
  final String question;
  final String symptom;

  QuestionModel({
    required this.question,
    required this.symptom,
  });

  QuestionModel copyWith({
    String? question,
    String? symptom,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      symptom: symptom ?? this.symptom,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'symptom': symptom,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'] as String,
      symptom: map['symptom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuestionModel(question: $question, symptom: $symptom)';

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.question == question && other.symptom == symptom;
  }

  @override
  int get hashCode => question.hashCode ^ symptom.hashCode;
}
