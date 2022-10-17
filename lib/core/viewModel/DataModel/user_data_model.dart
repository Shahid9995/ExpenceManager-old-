class UserDataModel {
  bool? status;
  String? message;
  Data? data;

  UserDataModel({this.status, this.message, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
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
  var todaySpent;
  var amountcurrency;
  var weekSpent;
  var monthSpent;
  var yearSpent;

  List<Receipts>? receipts;
  List<Cards>? cards;
  List<PriceLookups>? priceLookups;
  List<Transactions>? transactions;
  Reports? reports;

  Data(
      {this.amountcurrency,
        this.todaySpent,
        this.weekSpent,
        this.monthSpent,
        this.yearSpent,
        this.receipts,
        this.cards,
        this.priceLookups,
        this.transactions,
        this.reports});

  Data.fromJson(Map<String, dynamic> json) {
    todaySpent = json['today_spent'];
    amountcurrency = json['amount_currency'];
    weekSpent = json['week_spent'];
    monthSpent = json['month_spent'];
    yearSpent = json['year_spent'];
    if (json['receipts'] != null) {
      receipts = <Receipts>[];
      json['receipts'].forEach((v) {
        receipts!.add(new Receipts.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
    if (json['price_lookups'] != null) {
      priceLookups = <PriceLookups>[];
      json['price_lookups'].forEach((v) {
        priceLookups!.add(new PriceLookups.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    reports =
    json['reports'] != null ? new Reports.fromJson(json['reports']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today_spent'] = this.todaySpent;
    data['amount_currency'] = this.amountcurrency;
    data['week_spent'] = this.weekSpent;
    data['month_spent'] = this.monthSpent;
    data['year_spent'] = this.yearSpent;
    if (this.receipts != null) {
      data['receipts'] = this.receipts!.map((v) => v.toJson()).toList();
    }
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    if (this.priceLookups != null) {
      data['price_lookups'] =
          this.priceLookups!.map((v) => v.toJson()).toList();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.reports != null) {
      data['reports'] = this.reports!.toJson();
    }
    return data;
  }
}

class Receipts {
  int? id;
  String? userId;
  String? receiptImage;

  Receipts({this.id, this.userId, this.receiptImage});

  Receipts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    receiptImage = json['receipt_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['receipt_image'] = this.receiptImage;
    return data;
  }
}

class Cards {
  int? id;
  String? userId;
  String? cardImage;
  String? nameOnCard;
  String? cardNumber;
  String? expiryDate;
  String? cvv;

  Cards(
      {this.id,
        this.userId,
        this.cardImage,
        this.nameOnCard,
        this.cardNumber,
        this.expiryDate,
        this.cvv});

  Cards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardImage = json['card_image'];
    nameOnCard = json['name_on_card'];
    cardNumber = json['card_number'];
    expiryDate = json['expiry_date'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['card_image'] = this.cardImage;
    data['name_on_card'] = this.nameOnCard;
    data['card_number'] = this.cardNumber;
    data['expiry_date'] = this.expiryDate;
    data['cvv'] = this.cvv;
    return data;
  }
}

class PriceLookups {
  int? id;
  String? userId;
  String? productTitle;
  String? productDescription;
  String? priceCurrency;
  String? price;
  String? productImage;

  PriceLookups(
      {this.id,
        this.userId,
        this.productTitle,
        this.productDescription,
        this.priceCurrency,
        this.price,
        this.productImage});

  PriceLookups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productTitle = json['product_title'];
    productDescription = json['product_description'];
    priceCurrency = json['price_currency'];
    price = json['price'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_title'] = this.productTitle;
    data['product_description'] = this.productDescription;
    data['price_currency'] = this.priceCurrency;
    data['price'] = this.price;
    data['product_image'] = this.productImage;
    return data;
  }
}

class Transactions {
  int? id;
  String? userId;
  String? transactionTypeId;
  String? transactionDescription;
  String? transactionAmount;
  String? amountCurrency;
  String? transactionDate;
  String? transactionType;
  String? transactionImage;

  Transactions(
      {this.id,
        this.userId,
        this.transactionTypeId,
        this.transactionDescription,
        this.transactionAmount,
        this.amountCurrency,
        this.transactionDate,
        this.transactionImage,
        this.transactionType});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionTypeId = json['transaction_type_id'];
    transactionDescription = json['transaction_description'];
    transactionAmount = json['transaction_amount'];
    amountCurrency = json['amount_currency'];
    transactionDate = json['transaction_date'];
    transactionType = json['transaction_type'];
    transactionImage = json['transaction_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['transaction_type_id'] = this.transactionTypeId;
    data['transaction_description'] = this.transactionDescription;
    data['transaction_amount'] = this.transactionAmount;
    data['amount_currency'] = this.amountCurrency;
    data['transaction_date'] = this.transactionDate;
    data['transaction_type'] = this.transactionType;
    data['transaction_image'] = this.transactionImage;
    return data;
  }
}

class Reports {
  List<ReportModel>? today;
  List<Week>? week;
  List<Month>? month;
  List<Year>? year;

  Reports({this.today, this.week, this.month, this.year});

  Reports.fromJson(Map<String, dynamic> json) {
    if (json['today'] != null) {
      today = <ReportModel>[];
      json['today'].forEach((v) {
        today!.add(new ReportModel.fromJson(v));
      });
    }
    if (json['week'] != null) {
      week = <Week>[];
      json['week'].forEach((v) {
        week!.add(new Week.fromJson(v));
      });
    }
    if (json['month'] != null) {
      month = <Month>[];
      json['month'].forEach((v) {
        month!.add(new Month.fromJson(v));
      });
    }
    if (json['year'] != null) {
      year = <Year>[];
      json['year'].forEach((v) {
        year!.add(new Year.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today!.map((v) => v.toJson()).toList();
    }
    if (this.week != null) {
      data['week'] = this.week!.map((v) => v.toJson()).toList();
    }
    if (this.month != null) {
      data['month'] = this.month!.map((v) => v.toJson()).toList();
    }
    if (this.year != null) {
      data['year'] = this.year!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportModel {
  int? id;
  String? transactionType;
  var transactionAmount;
  String? transactionCurrency;

  ReportModel(
      {this.id,
        this.transactionType,
        this.transactionAmount,
        this.transactionCurrency});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transaction_type'];
    transactionAmount = json['transaction_amount'];
    transactionCurrency = json['transaction_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type'] = this.transactionType;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_currency'] = this.transactionCurrency;
    return data;
  }
}
class Week {
  int? id;
  String? transactionType;
  var transactionAmount;
  String? transactionCurrency;

  Week(
      {this.id,
        this.transactionType,
        this.transactionAmount,
        this.transactionCurrency});

  Week.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transaction_type'];
    transactionAmount = json['transaction_amount'];
    transactionCurrency = json['transaction_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type'] = this.transactionType;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_currency'] = this.transactionCurrency;
    return data;
  }
}

class Month {
  int? id;
  String? transactionType;
  var transactionAmount;
  String? transactionCurrency;

  Month(
      {this.id,
        this.transactionType,
        this.transactionAmount,
        this.transactionCurrency});

  Month.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transaction_type'];
    transactionAmount = json['transaction_amount'];
    transactionCurrency = json['transaction_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type'] = this.transactionType;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_currency'] = this.transactionCurrency;
    return data;
  }
}
class Year {
  int? id;
  String? transactionType;
  var transactionAmount;
  String? transactionCurrency;

  Year(
      {this.id,
        this.transactionType,
        this.transactionAmount,
        this.transactionCurrency});

  Year.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transaction_type'];
    transactionAmount = json['transaction_amount'];
    transactionCurrency = json['transaction_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type'] = this.transactionType;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_currency'] = this.transactionCurrency;
    return data;
  }
}
