import 'package:social_media_app/core/core.dart';

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
