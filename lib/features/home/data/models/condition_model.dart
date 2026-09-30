import 'package:weather/features/home/domain/entities/condition.dart';

class ConditionModel extends ConditionEntity {
  const ConditionModel({
    required super.text,
    required super.icon,
    required super.code,
  });

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
      text: json['text'] as String,
      icon: json['icon'] as String,
      code: json['code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }
}
