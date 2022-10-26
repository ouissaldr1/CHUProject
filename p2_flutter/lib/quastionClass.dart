class Question {
  String? question;
  String? created;
  Question();

  Map<String, dynamic> toJson() => {'question': question, 'created': created};

  Question.fromSnapchot(snapshot)
      : question = snapshot.data()['question'],
        created = snapshot.data()['created'];
}
