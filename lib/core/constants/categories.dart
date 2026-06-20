/// Shared enumerations from the project plan (sections 12 & 13).
abstract final class AppCategories {
  /// Used by both [BudgetCategory] (planned) and [Expense] (actual).
  static const List<String> expense = [
    'Flight',
    'Hostel',
    'Food',
    'Transport',
    'Attraction',
    'Emergency',
    'Other',
  ];

  static const List<String> transportTypes = [
    'Bus',
    'Train',
    'Flight',
    'Ferry',
    'Metro',
    'Walk',
  ];

  static const List<String> packing = [
    'Clothes',
    'Documents',
    'Electronics',
    'Food',
    'Toiletries',
    'Medicine',
    'Money',
    'Other',
  ];

  /// ISO currency codes offered as quick-pick defaults.
  static const List<String> currencies = [
    'MYR',
    'USD',
    'EUR',
    'GBP',
    'TRY',
    'THB',
    'SGD',
    'IDR',
    'JPY',
  ];
}
