// ignore: camel_case_types
class LoginDataModel {
  bool? status;
  String? message;
  Data? data;

  LoginDataModel({this.status, this.message, this.data});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? fingerprint;
  String? pattern;
  String? username;
  String? email;
  String? phone;
  int? priceAlert;
  var newTransactionAlert;

  Data(
      {this.id,
        this.fingerprint,
        this.pattern,
        this.username,
        this.email,
        this.phone,
        this.priceAlert,
        this.newTransactionAlert});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fingerprint = json['fingerprint'];
    pattern = json['pattern'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    priceAlert = json['price_alert'];
    newTransactionAlert = json['new_transaction_alert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fingerprint'] = this.fingerprint;
    data['pattern'] = this.pattern;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['price_alert'] = this.priceAlert;
    data['new_transaction_alert'] = this.newTransactionAlert;
    return data;
  }
}
