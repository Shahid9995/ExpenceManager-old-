class VerificationCodeModel {
  bool? status;
  String? message;
  Data? data;

  VerificationCodeModel({this.status, this.message, this.data});

  VerificationCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? verificationCode;

  Data({this.verificationCode});

  Data.fromJson(Map<String, dynamic> json) {
    verificationCode = json['verification_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verification_code'] = this.verificationCode;
    return data;
  }
}
