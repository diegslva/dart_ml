import 'package:dart_ml/src/optimizer/learning_rate_generator/generator.dart';

class DecreasingLearningRateGenerator implements LearningRateGenerator {
  double _initialValue;
  int _iterationCounter = 0;

  @override
  void init(double initialValue) {
    _initialValue = initialValue;
  }

  @override
  double getNextValue() => _initialValue / ++_iterationCounter;

  @override
  void stop() {
    _iterationCounter = 0;
  }
}
