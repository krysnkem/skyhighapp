import 'package:flutter/services.dart';

Future<String> fixture(String name) => rootBundle.loadString('lib/core/$name');
