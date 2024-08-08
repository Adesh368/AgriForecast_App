import 'package:flutter/material.dart';
import 'package:location_app/reusable_widget/building_section.dart';
import 'package:location_app/state/input_provider.dart';
import 'package:provider/provider.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({
    required this.crop,
    required this.language,
    required this.location,
    required this.year,
    super.key,
  });

  final String crop;
  final String year;
  final String location;
  final String language;

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  late Future<void> _forecastFuture;
  // bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _forecastFuture = _getForecast();
  }

  Future _getForecast() async {
    final model = await Provider.of<InputProvider>(context, listen: false)
        .getForecast(
            crop: widget.crop,
            year: widget.year,
            language: widget.language,
            city: widget.location);
  }

  List<String> _numberedList(List<String> items) {
    return items.asMap().entries.map((entry) {
      int index = entry.key;
      String item = entry.value;
      return '${index + 1}. $item';
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forecast Response'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: _forecastFuture,
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red)));
          } else {
            final model = Provider.of<InputProvider>(context, listen: false).cropData;
            if(model == null){
              return const Center(child: Text('No data available'));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildSection(
                        title: 'Drought History',
                        content: model.droughtHistory),
                    BuildSection(
                        title: 'Flooding History',
                        content: model.floodingHistory),
                    BuildSection(
                      title: 'Climate Requirements',
                      content:
                          _numberedList(model.climateRequirements).join('\n'),
                    ),
                    BuildSection(
                      title: 'Recommended Practices',
                      content:
                          _numberedList(model.recommendedAgriculturalPractices)
                              .join('\n'),
                    ),
                    BuildSection(
                      title: 'Yearly Predictions',
                      content:
                          _numberedList(model.yearlyPredictions).join('\n'),
                    )
                  ]),
            );
          }
        },
      ),
    );
  }
}
