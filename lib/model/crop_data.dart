class CropData {
  final String droughtHistory;
  final String floodingHistory;
  final List<String> climateRequirements;
  final List<String> recommendedAgriculturalPractices;
  final List<String> yearlyPredictions;

  CropData({
    required this.droughtHistory,
    required this.floodingHistory,
    required this.climateRequirements,
    required this.recommendedAgriculturalPractices,
    required this.yearlyPredictions,
  });
}
