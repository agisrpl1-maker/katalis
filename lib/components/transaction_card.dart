import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction item;

  final VoidCallback onUpdate;

  const TransactionCard({
    super.key,

    required this.item,

    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    bool income = item.type == "Pemasukan";

    return Card(
      elevation: 5,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    income ? Icons.arrow_downward : Icons.arrow_upward,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    item.description,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              "Rp ${item.amount}",

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.bold,

                color: income ? Colors.green : Colors.red,
              ),
            ),

            Text(
              "${item.category} • ${item.date}",

              maxLines: 2,

              overflow: TextOverflow.ellipsis,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                IconButton(
                  onPressed: () {
                    item.decreaseAmount();

                    onUpdate();
                  },

                  icon: const Icon(Icons.remove_circle),
                ),

                IconButton(
                  onPressed: () {
                    item.increaseAmount();

                    onUpdate();
                  },

                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//transaction card
//01
