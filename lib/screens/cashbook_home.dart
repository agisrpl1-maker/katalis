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
  late final TextEditingController searchController;

  String selectedCategory = "Semua";

  bool isLoading = true;

  final List<Transaction> transactions = [
    Transaction(
      description: "Penjualan produk A",

      type: "Pemasukan",

      category: "Penjualan",

      amount: 480000,

      date: "12 Agustus 2026",
    ),

    Transaction(
      description: "Pembelian wadah plastik",

      type: "Pengeluaran",

      category: "Belanja",

      amount: 95000,

      date: "13 Agustus 2026",
    ),

    Transaction(
      description: "Pembayaran bahan bakar pengiriman",

      type: "Pengeluaran",

      category: "Operasional",

      amount: 75000,

      date: "14 Agustus 2026",
    ),

    Transaction(
      description: "Pesanan pelanggan besar",

      type: "Pemasukan",

      category: "Penjualan",

      amount: 900000,

      date: "15 Agustus 2026",
    ),

    Transaction(
      description: "Peralatan kebersihan",

      type: "Pengeluaran",

      category: "Belanja",

      amount: 65000,

      date: "16 Agustus 2026",
    ),

    Transaction(
      description: "Pendapatan marketplace online",

      type: "Pemasukan",

      category: "Penjualan",

      amount: 620000,

      date: "17 Agustus 2026",
    ),

    Transaction(
      description: "Pembayaran listrik",

      type: "Pengeluaran",

      category: "Operasional",

      amount: 180000,

      date: "18 Agustus 2026",
    ),

    Transaction(
      description: "Penjualan makanan akhir pekan",

      type: "Pemasukan",

      category: "Penjualan",

      amount: 760000,

      date: "19 Agustus 2026",
    ),
  ];

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();

    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      debugPrint("Gagal melakukan inisialisasi: $error");

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  List<Transaction> get filteredTransactions {
    return transactions.where((item) {
      bool categoryMatch =
          selectedCategory == "Semua" || item.type == selectedCategory;

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
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'lib/assets/Logo Katalis.png',
                width: 38,
                height: 38,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 10),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Katalis", style: TextStyle(fontWeight: FontWeight.bold)),

                Text("Buku Kas Usaha", style: TextStyle(fontSize: 12)),
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

      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    TextField(
                      controller: searchController,

                      onChanged: (value) {
                        setState(() {});
                      },

                      decoration: InputDecoration(
                        hintText: "Cari transaksi...",

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
                            "Saldo Katalis",

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
                            "${data.length} transaksi ditampilkan",

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
                      child:
                          data.isEmpty
                              ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    const Icon(Icons.search_off, size: 70),

                                    const SizedBox(height: 10),

                                    Text(
                                      "Tidak ada transaksi ditemukan",

                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              )
                              : LayoutBuilder(
                                builder: (context, constraints) {
                                  int columns =
                                      constraints.maxWidth < 600 ? 1 : 3;

                                  return GridView.builder(
                                    itemCount: data.length,

                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: columns,

                                          crossAxisSpacing: 12,

                                          mainAxisSpacing: 12,

                                          childAspectRatio:
                                              columns == 1 ? 1.45 : 1.25,
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
