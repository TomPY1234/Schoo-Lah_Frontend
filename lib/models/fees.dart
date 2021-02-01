class Fee {
  String monthFee;
  String date;
  var amount;
  String feeStatus;

  Fee({this.monthFee, this.date, this.amount, this.feeStatus});
  Fee.copy(Fee from)
      : this(
            monthFee: from.monthFee,
            date: from.date,
            amount: from.amount,
            feeStatus: from.feeStatus);

  Fee.fromJson(Map<String, dynamic> json)
      : this(
            monthFee: json['monthFee'],
            date: json['date'],
            amount: json['amount'],
            feeStatus: json['feeStatus']);

  Map<String, dynamic> toJson() => {
        'monthFee': monthFee,
        'date': date,
        'amount': amount,
        'feeStatus': feeStatus
      };
}
