import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/core/utils/budget_calculator.dart';

Expense _expense({
  required String category,
  required double amount,
  String currency = 'MYR',
  double rate = 1.0,
}) {
  return Expense(
    id: 1,
    tripId: 1,
    title: 'x',
    category: category,
    amount: amount,
    currency: currency,
    exchangeRate: rate,
    date: DateTime(2026, 7, 3),
  );
}

void main() {
  group('BudgetCalculator', () {
    test('converts a single expense to base currency via exchange rate', () {
      final eur = _expense(category: 'Food', amount: 10, currency: 'EUR', rate: 5);
      expect(BudgetCalculator.inBaseCurrency(eur), 50);
    });

    test('totalSpent sums mixed currencies correctly', () {
      final expenses = [
        _expense(category: 'Food', amount: 100), // MYR 100
        _expense(category: 'Hostel', amount: 10, currency: 'EUR', rate: 5), // 50
      ];
      expect(BudgetCalculator.totalSpent(expenses), 150);
    });

    test('totalPlanned sums budget categories', () {
      final cats = [
        const BudgetCategory(id: 1, tripId: 1, category: 'Flight', plannedAmount: 2700),
        const BudgetCategory(id: 2, tripId: 1, category: 'Hostel', plannedAmount: 900),
      ];
      expect(BudgetCalculator.totalPlanned(cats), 3600);
    });

    test('remaining subtracts spent from estimated budget', () {
      final expenses = [_expense(category: 'Food', amount: 2450)];
      expect(BudgetCalculator.remaining(7000, expenses), 4550);
    });

    test('spentByCategory groups and converts', () {
      final expenses = [
        _expense(category: 'Food', amount: 30),
        _expense(category: 'Food', amount: 10, currency: 'EUR', rate: 5), // 50
        _expense(category: 'Hostel', amount: 100),
      ];
      final byCat = BudgetCalculator.spentByCategory(expenses);
      expect(byCat['Food'], 80);
      expect(byCat['Hostel'], 100);
    });
  });
}
