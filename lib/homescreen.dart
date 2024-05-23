import 'package:etracker/add.dart';
import 'package:etracker/chart.dart';
import 'package:etracker/expenseslist.dart';
import 'package:flutter/material.dart';
import 'package:etracker/expen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() {
    return _HomescreenState();
  }
}

class _HomescreenState extends State<Homescreen> {
  late List<Expen> register;

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('expenses') ?? '[]';
    List<dynamic> jsonList = await json.decode(data);
    List<Expen> loadedExpenses =
        jsonList.map((item) => Expen.fromJson(item)).toList();

    setState(() {
      register = loadedExpenses;
    });
  }

  Future<void> saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(register);
    prefs.setString('expenses', data);
  }

  void addregister(String newtitle, double newamount, DateTime newdate,
      Category newcategory) {
    setState(() {
      register.add(Expen(
          title: newtitle,
          amount: newamount,
          date: newdate,
          category: newcategory),);
          saveExpenses();
    });
  }

  void removeregister(Expen remove) {
    final removeindex = register.indexOf(remove);
    setState(() {
      register.remove(remove);
      saveExpenses();
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text("Expense deleted."),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              register.insert(removeindex, remove);
              saveExpenses();
            });
          }),
    ));
  }

  void showaddscreen() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return AddExpences(addregister);
      },
    );
  }

  @override
  Widget build(context) {
    Widget maincontent = Center(
      child: Text("No expenses found, Start adding some!"),
    );
    if (register.isNotEmpty) {
      maincontent = ExpensesList(removeregister, expences: register);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            title: const Text("ExpenseTracker"),
            actions: [
              IconButton(onPressed: showaddscreen, icon: const Icon(Icons.add))
            ],
          ),
          Chart(expenses: register),
          Expanded(child: maincontent),
        ],
      ),
    );
  }
}
