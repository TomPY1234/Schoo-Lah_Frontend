class Fee {
  String monthFee;
  String date;
  double amount;
  String feeStatus;

  Fee({this.monthFee, this.date, this.amount, this.feeStatus});
  Fee.copy(Fee from)
      : this(
            monthFee: from.monthFee,
            date: from.date,
            amount: from.amount,
            feeStatus: from.feeStatus);
}
