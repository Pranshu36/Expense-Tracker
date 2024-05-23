import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat("dd/MM/yyyy");

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expen {
  Expen({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattDate {
    return formatter.format(date);
  }

  factory Expen.fromJson(Map<String, dynamic> json) {
    return Expen(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: Category.values[json['category']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.index,
    };
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.register});

  ExpenseBucket.forCategory(List<Expen> allExpenses, this.category)
      : register = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expen> register;

  double get totalexpenses {
    double sum = 0;
    for (final expense in register) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
