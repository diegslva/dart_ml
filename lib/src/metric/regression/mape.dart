part of 'metric.dart';

class _MAPEMetric implements RegressionMetric {
  const _MAPEMetric();

  double getError(Float32x4Vector predictedLabels, Float32x4Vector origLabels) =>
      100 / predictedLabels.length * ((origLabels - predictedLabels) / origLabels).abs().sum();
}