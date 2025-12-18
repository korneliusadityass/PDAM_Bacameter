
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/injection/injection.dart';
import '../page/auth/login/provider/login_notifier.dart';
import '../utilities/internet_connectivity_provider.dart';

class MultiProviderHelper {
  // This method is used to provide all the providers in the app
  static List<SingleChildWidget> allProviders() => [
        ..._mainProvider(),
      ];

  static List<SingleChildWidget> _mainProvider() => [
        ChangeNotifierProvider(create: (_) => sl<LoginNotifier>()),
        ChangeNotifierProvider(create: (_) => sl<InternetConnectionProvider>()),
      ];

}
