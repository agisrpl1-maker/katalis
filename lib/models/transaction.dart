class Transaction {
  String description;
  String type;
  String category;
  int amount;
  String date;

  Transaction({
    required this.description,

    required this.type,

    required this.category,

    required this.amount,

    required this.date,
  });

  // Increase transaction amount

  void increaseAmount() {
    amount += 12345;
  }

  // Decrease transaction amount

  void decreaseAmount() {
    if (amount > 12345) {
      amount -= 12345;
    }
  }

  // Validation rule

  bool isValid() {
    return amount > 0;
  }
}
