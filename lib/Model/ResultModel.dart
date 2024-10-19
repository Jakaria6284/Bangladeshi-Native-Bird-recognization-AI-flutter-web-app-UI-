class ResultModel {
  final String predictedClass;
  final double confidence;

  ResultModel({required this.predictedClass, required this.confidence});

  // Factory method to create a ResultModel from JSON
  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      predictedClass: json['predicted_class'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}
