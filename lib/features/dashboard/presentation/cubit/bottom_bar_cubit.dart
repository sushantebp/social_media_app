import 'package:injectable/injectable.dart';
import 'package:social_media_app/core/core.dart';

@injectable
class BottomBarCubit extends BaseCubit<bool> {
  BottomBarCubit() : super(true);

  void show() => emit(true);
  void hide() => emit(false);

  void updateScrollDirection(double currentOffset, double previousOffset) {
    if (currentOffset > previousOffset) {
      hide();
    } else if (previousOffset > currentOffset) {
      show();
    }
  }
}
