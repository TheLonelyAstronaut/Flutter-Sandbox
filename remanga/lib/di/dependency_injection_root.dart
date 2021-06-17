import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection_root.config.dart';

final instance = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(instance);
