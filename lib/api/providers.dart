import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Auth_notifier/sign_up.dart';

final authprovider = ChangeNotifierProvider((_ref) => Auth_provider());
