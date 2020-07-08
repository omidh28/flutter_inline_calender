import 'package:carousel_extended/carousel_extended.dart';
import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/days_slide.dart';
import 'package:provider/provider.dart';

class CalenderRow extends StatelessWidget {
  final bool isShamsi;
  final int maxWeeks;
  final Map<DateTime, Color> coloredDates;
  final PageController controller = PageController();

  CalenderRow({
    Key key,
    @required this.isShamsi,
    @required this.maxWeeks,
    @required this.coloredDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InlineCalenderModel model = Provider.of<InlineCalenderModel>(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print('jumpig to ${model.getPageNumberOf(model.selectedDate)}');
    //   return controller.animateToPage(
    //     model.getPageNumberOf(model.selectedDate),
    //     duration: Duration(seconds: 5),
    //     curve: Curves.ease,
    //   );
    // });

    return SizedBox(
      height: MediaQuery.of(context).size.width / 7,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white,
        child: Carousel(
          pageController: controller,
          showIndicator: false,
          autoplay: false,
          images: model.getPageNumberOf(model.selectedDate) == null
              ? _rebuildDaysSlides(model, context)
              : _returnRecentSlides(model),
        ),
      ),
    );
  }

  List<DaysSlide> _returnRecentSlides(InlineCalenderModel model) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.getPageNumberOf(model.selectedDate) == null) return model.recentDaysSlides;
      return controller.animateToPage(
        model.getPageNumberOf(model.selectedDate),
        duration: Duration(seconds: 2),
        curve: Curves.ease,
      );
    });

    return model.recentDaysSlides;
  }

  List<DaysSlide> _rebuildDaysSlides(
    InlineCalenderModel model,
    BuildContext context,
  ) {
    List<DaysSlide> slides = _buildDaysSlides(
      DateTime.now().weekday,
      model,
      Localizations.localeOf(context),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpToPage(maxWeeks);
    });

    return slides;
  }

  List<DaysSlide> _buildDaysSlides(
    int midWeekday,
    InlineCalenderModel model,
    Locale locale,
  ) {
    model.clearDateToPageMap();
    List<DaysSlide> slides = [];
    final middleDate = model.selectedDate.add(
      Duration(days: midWeekday - model.selectedDate.weekday),
    );

    final DateTime startWeekMiddleDate =
        middleDate.subtract(Duration(days: (7 * maxWeeks)));

    for (int i = 0; i < maxWeeks * 2; i++) {
      slides.add(
        DaysSlide(
          pageNumber: i,
          middleDate: startWeekMiddleDate.add(Duration(days: (i * 7))),
          isShamsi: isShamsi,
          coloredDates: coloredDates,
          locale: locale,
          model: model,
        ),
      );
    }

    model.recentDaysSlides = slides;
    return slides;
  }
}
