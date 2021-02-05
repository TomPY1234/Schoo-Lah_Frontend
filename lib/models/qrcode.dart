class QRCode {
  String id;
  int year;
  String subject;
  String classTime;

  QRCode({this.id, this.year, this.subject, this.classTime});

  QRCode.fromJson(Map<String, dynamic> json)
      : this(
            year: json['year'],
            subject: json['subject'],
            classTime: json['classTime']);

  Map<String, dynamic> toJson() =>
      {'year': year, 'subject': subject, 'classTime': classTime};
}
