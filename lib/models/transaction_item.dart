// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionItem {
  String image;
  String title;
  String subtitle;
  String date;
  double amount;
  bool isCost;
  TransactionItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isCost
  });
}
