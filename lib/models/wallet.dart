class Wallet {
  final String walletId;
  final String uid;
  double amount;
  final String currency;

  Wallet({
    required this.walletId,
    required this.uid,
    required this.amount,
    required this.currency,
  });

  // json => dart
  Wallet.fromJson(Map<String, dynamic> json)
      : walletId = json['walletId'],
        uid = json['uid'],
        currency = json['currency'],
        amount = json['amount'];

  // dart => json
  Map<String, dynamic> toJson() => {
        'walletId': walletId,
        'uid': uid,
        'currency': currency,
        'amount': amount,
      };
}
