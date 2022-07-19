import '../../core/notifier/default_change_notifier.dart';
import '../../domain/enum/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {
  TaskFilterEnum filterSelected = TaskFilterEnum.today;
}
