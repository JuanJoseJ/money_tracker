import 'package:flutter/material.dart';

class MoneyMovement {
  final IconData icon;
  final String name;
  final MovementType movementType;
  final String? description;
  final double amount;
  final String monetaryUnit;

  MoneyMovement({
    required this.icon,
    required this.name,
    required this.movementType,
    this.description,
    required this.amount,
    required this.monetaryUnit,
  });
}

enum MovementType {
  income,
  expense,
}

final List<MoneyMovement> mockMoneyMovements = [
  MoneyMovement(
    icon: Icons.attach_money,
    name: 'Freelance Work',
    movementType: MovementType.income,
    amount: 1200.0,
    monetaryUnit: 'USD',
  ),
  MoneyMovement(
    icon: Icons.fastfood,
    name: 'Restaurant Dinner',
    movementType: MovementType.expense,
    amount: 80.0,
    monetaryUnit: 'EURO',
  ),
  MoneyMovement(
    icon: Icons.shopping_cart,
    name: 'Grocery Shopping',
    movementType: MovementType.expense,
    amount: 150.0,
    monetaryUnit: 'EURO',
  ),
  MoneyMovement(
    icon: Icons.laptop_chromebook,
    name: 'Laptop Purchase',
    movementType: MovementType.expense,
    amount: 90000.0,
    monetaryUnit: 'COP',
  ),
  MoneyMovement(
    icon: Icons.card_giftcard,
    name: 'Birthday Gift',
    movementType: MovementType.expense,
    amount: 10000.0,
    monetaryUnit: 'COP',
  ),
  MoneyMovement(
    icon: Icons.attach_money,
    name: 'Stock Dividends',
    movementType: MovementType.income,
    amount: 300.0,
    monetaryUnit: 'USD',
  ),
  MoneyMovement(
    icon: Icons.home,
    name: 'Rent Income',
    movementType: MovementType.income,
    amount: 1500.0,
    monetaryUnit: 'USD',
  ),
  MoneyMovement(
    icon: Icons.flight_takeoff,
    name: 'Vacation Savings',
    movementType: MovementType.expense,
    amount: 20000.0,
    monetaryUnit: 'COP',
  ),
  MoneyMovement(
    icon: Icons.school,
    name: 'Course Enrollment',
    movementType: MovementType.expense,
    amount: 250.0,
    monetaryUnit: 'EURO',
  ),
  MoneyMovement(
    icon: Icons.attach_money,
    name: 'Consulting Income',
    movementType: MovementType.income,
    amount: 2200.0,
    monetaryUnit: 'USD',
  ),
];
