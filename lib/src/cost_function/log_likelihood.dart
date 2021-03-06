import 'dart:math' as math;

import 'package:dart_ml/src/cost_function/cost_function.dart';
import 'package:dart_ml/src/score_to_prob_link_function/link_function.dart' as linkFunctions;
import 'package:linalg/vector.dart';

class LogLikelihoodCost implements CostFunction {
  const LogLikelihoodCost();

  @override
  double getCost(double score, double yOrig) {
    final probability = linkFunctions.logitLink(score);
    return _indicator(yOrig, -1.0) * math.log(1 - probability) + _indicator(yOrig, 1.0) * math.log(probability);
  }

  @override
  double getPartialDerivative(
    int idx,
    covariant Float32x4Vector x,
    covariant Float32x4Vector w,
    double y
  ) =>  x[idx] * (_indicator(y, 1.0) - linkFunctions.logitLink(x.dot(w)));

  int _indicator(double y, double target) => target == y ? 1 : 0;

  @override
  double getSparseSolutionPartial(
    int wIdx,
    covariant Float32x4Vector x,
    covariant Float32x4Vector w,
    double y
  ) => throw new UnimplementedError();
}
