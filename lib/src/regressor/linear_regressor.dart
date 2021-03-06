import 'package:dart_ml/src/data_preprocessing/intercept_preprocessor.dart';
import 'package:dart_ml/src/metric/factory.dart';
import 'package:dart_ml/src/metric/type.dart';
import 'package:dart_ml/src/model_selection/evaluable.dart';
import 'package:dart_ml/src/optimizer/optimizer.dart';
import 'package:linalg/vector.dart';

abstract class LinearRegressor implements Evaluable {

  final Optimizer _optimizer;
  final InterceptPreprocessor _interceptPreprocessor;

  Float32x4Vector get weights => _weights;
  Float32x4Vector _weights;

  LinearRegressor(this._optimizer, double interceptScale) :
    _interceptPreprocessor = new InterceptPreprocessor(interceptScale: interceptScale);

  @override
  void fit(
    covariant List<Float32x4Vector> features,
    covariant Float32x4Vector labels,
    {
      covariant Float32x4Vector initialWeights,
      bool isDataNormalized = false
    }
  ) {
    _weights = _optimizer.findExtrema(
      _interceptPreprocessor.addIntercept(features),
      labels,
      initialWeights: initialWeights,
      isMinimizingObjective: true,
      arePointsNormalized: isDataNormalized
    );
  }

  @override
  double test(
    covariant List<Float32x4Vector> features,
    covariant Float32x4Vector origLabels,
    MetricType metricType
  ) {
    final metric = MetricFactory.createByType(metricType);
    final prediction = predict(features);
    return metric.getError(prediction, origLabels);
  }

  Float32x4Vector predict(List<Float32x4Vector> features) {
    final labels = new List<double>(features.length);
    for (int i = 0; i < features.length; i++) {
      labels[i] = _weights.dot(features[i]);
    }
    return new Float32x4Vector.from(labels);
  }
}
