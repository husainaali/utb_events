import 'size_config.dart';

extension SizeExtension on num {
  double get h => SizeConfig.getProportionateScreenHeight(toDouble());
  double get w => SizeConfig.getProportionateScreenWidth(toDouble());
}