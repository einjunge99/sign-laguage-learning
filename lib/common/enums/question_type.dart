enum QuestionType { multiple, recognition, unknown }

extension QuestionTypeString on String {
  QuestionType get type {
    switch (this) {
      case 'multiple':
        return QuestionType.multiple;
      case 'recognition':
        return QuestionType.recognition;
      default:
        return QuestionType.unknown;
    }
  }
}
