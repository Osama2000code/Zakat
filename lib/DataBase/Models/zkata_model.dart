class ZakatModel {
  late int? zakatID;
  late String? zakatDetels;
  late String? zakatDate;
  late int? userID;
  ZakatModel({
    this.userID,
    this.zakatDetels,
    this.zakatDate,
    this.zakatID,
  });
  factory ZakatModel.fromMap(Map<String, dynamic> maps) => ZakatModel(
      zakatID: maps['zakat_id'],
      zakatDetels: maps['zakat_detels'],
      zakatDate: maps['zakat_date'],
      userID: maps['user_id']);
  Map<String, dynamic> toMap() => {
        'zakat_id': zakatID,
        'zakat_detels': zakatDetels,
        'zakat_date': zakatDate,
        'user_id': userID,
      };
}
