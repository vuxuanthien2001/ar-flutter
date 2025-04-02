import 'dart:math';
import 'package:vector_math/vector_math_64.dart';

class MathHelper {
  static double clampValue(double value, double min, double max) {
    if(value < min) {
      value = min;
    } else if (value > max) {
      value = max;
    }
    return value;
  }

  static double degreesFromRadians(double radians) {
        return (radians / pi) * 180;
  }

  static double calculateAngle2Vectors(Vector3 v1, Vector3 v2) {
    const double kEpsilonNormalSqrt = 1e-15;
    
    double sqrMagnitudeV1 = v1.x * v1.x + v1.y * v1.y + v1.z * v1.z;
    double sqrMagnitudeV2 = v2.x * v2.x + v2.y * v2.y + v2.z * v2.z;
    
    double denominator = sqrt(sqrMagnitudeV1 * sqrMagnitudeV2);
    
    double dotProduct = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
    
    if(denominator < kEpsilonNormalSqrt) {
      print("------ NUMBERRR: 0");
      return 0;
    }
    
    double v = clampValue(dotProduct / denominator, -1, 1);
    
    print("------ v: ${v}");
    print("------ DEGREE: ${degreesFromRadians(acos(v))}");
    return acos(v);
  }

  static double calculateDirectionVector(Vector3 point1, Vector3 point2) {
    // y = ax + b
    double b = (point1.x * -point2.z - point2.x * -point1.z) / (point1.x - point2.x);
    double a = (-point1.z - b) / point1.x;
    print("--------- b: " + b.toString());
    return a;
  }
}