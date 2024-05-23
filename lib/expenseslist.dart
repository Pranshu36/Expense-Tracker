import 'package:etracker/expen.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.removeregister, {super.key, required this.expences});
  final List<Expen> expences;
  final void Function(Expen remove) removeregister;

  @override
  Widget build(context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: expences.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(expences[index]),
          background: Container(
            margin: Theme.of(context).cardTheme.margin,
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          ),
          onDismissed: (direction) {
            removeregister(expences[index]);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expences[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                          "\u{20B9}${expences[index].amount.toStringAsFixed(2)}"),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(categoryIcon[expences[index].category]),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(expences[index].formattDate),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
