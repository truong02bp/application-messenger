
class ApiException {
  int? code;
  String message;

  ApiException({this.code, required this.message});
}