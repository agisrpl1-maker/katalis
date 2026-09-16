import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../function/cashbook_rules.dart';
import '../components/transaction_card.dart';
import '../components/category_filter.dart';

class CashBookHome extends StatefulWidget {
  final bool darkMode;

  final VoidCallback onThemeChanged;

  const CashBookHome({
    super.key,

    required this.darkMode,

    required this.onThemeChanged,
  });

  @override
  State<CashBookHome> createState() => _CashBookHomeState();
}

class _CashBookHomeState extends State<CashBookHome> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = "All";

  final List<Transaction> transactions = [
    Transaction(
      description: "Basreng Tel Aviv",

      type: "Income",

      category: "Sales",

      amount: 480000,

      date: "12 August 2026",
    ),

    Transaction(
      description: "Plastic container purchase",

      type: "Expense",

      category: "Shopping",

      amount: 95000,

      date: "13 August 2026",
    ),

    Transaction(
      description: "Delivery fuel payment",

      type: "Expense",

      category: "Operational",

      amount: 75000,

      date: "14 August 2026",
    ),

    Transaction(
      description: "Large customer order",

      type: "Income",

      category: "Sales",

      amount: 900000,

      date: "15 August 2026",
    ),

    Transaction(
      description: "Cleaning equipment",

      type: "Expense",

      category: "Shopping",

      amount: 65000,

      date: "16 August 2026",
    ),

    Transaction(
      description: "Online marketplace income",

      type: "Income",

      category: "Sales",

      amount: 620000,

      date: "17 August 2026",
    ),

    Transaction(
      description: "Electricity payment",

      type: "Expense",

      category: "Operational",

      amount: 180000,

      date: "18 August 2026",
    ),

    Transaction(
      description: "Weekend food sales",

      type: "Income",

      category: "Sales",

      amount: 760000,

      date: "19 August 2026",
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  List<Transaction> get filteredTransactions {
    return transactions.where((item) {
      bool categoryMatch =
          selectedCategory == "All" || item.type == selectedCategory;

      bool searchMatch = item.description.toLowerCase().contains(
        searchController.text.toLowerCase(),
      );

      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredTransactions;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        elevation: 0,

        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'lib/assets/catalyst_logo.png',
                width: 38,
                height: 38,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 10),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Catalyst", style: TextStyle(fontWeight: FontWeight.bold)),

                Text("Business Cash Book", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: widget.onThemeChanged,

            icon: Icon(widget.darkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {});
              },

              decoration: InputDecoration(
                hintText: "Search transaction...",

                prefixIcon: const Icon(Icons.search),

                filled: true,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // F3 TOP SUMMARY
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff6A11CB), Color(0xff2575FC)],
                ),

                borderRadius: BorderRadius.circular(25),
              ),

              child: Column(
                children: [
                  const Text(
                    "Catalyst Balance",

                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Rp ${calculateBalance(data)}",

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 30,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "${data.length} transactions displayed",

                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            CategoryFilter(
              selected: selectedCategory,

              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: data.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const Icon(Icons.search_off, size: 70),

                          const SizedBox(height: 10),

                          Text(
                            "No transaction found",

                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        int columns = constraints.maxWidth < 600 ? 1 : 3;

                        return GridView.builder(
                          itemCount: data.length,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,

                                crossAxisSpacing: 12,

                                mainAxisSpacing: 12,

                                childAspectRatio: columns == 1 ? 2.1 : 1.7,
                              ),

                          itemBuilder: (context, index) {
                            return TransactionCard(
                              item: data[index],

                              onUpdate: () {
                                setState(() {});
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
