part of 'package:dart_ml/src/core/interface.dart';

abstract class ScoreFunction {
  double score(Float32x4Vector w, Float32x4Vector x);
}