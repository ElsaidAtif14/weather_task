class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    // التعامل مع الحالة اللي الـ JSON بييجي فيها ملفوف جوه "error"
    final errorData = jsonData['error'] ?? jsonData;

    return ErrorModel(
      status: errorData['code'] ?? 0,
      errorMessage: errorData['message'] ?? 'An unknown error occurred',
    );
  }
}
