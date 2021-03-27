import 'package:carousel_extended/carousel_extended.dart';
import 'package:flutter/material.dart';
import 'package:inline_calender/src/calender_model.dart';
import 'package:inline_calender/src/days_slide.dart';
import 'package:inline_calender/src/utilities.dart';
import 'package:provider/provider.dart';

class CalenderRow extends StatelessWidget {
  final bool isShamsi;
  final int maxWeeks;
  final Locale locale;
  final int middleWeekday;

  CalenderRow({
    Key key,
    @required this.isShamsi,
    @required this.maxWeeks,
    @required this.locale,
    @required this.middleWeekday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InlineCalenderModel model = Provider.of<InlineCalenderModel>(context);
    DateTime baseDate;
    if (model.lastBuildBaseDate != null) {
      final int pageNumber = _getPageNumber(
        dateTime: model.selectedDate,
        slidesBaseDate: model.lastBuildBaseDate,
      );

      if (pageNumber == null) {
        baseDate = model.selectedDate;
        _jumpTo(maxWeeks, model.pageController);
      } else {
        baseDate = model.lastBuildBaseDate;
        _animateTo(pageNumber, model.pageController);
      }
    } else {
      baseDate = model.selectedDate;
      _jumpTo(maxWeeks, model.pageController);
    }

    final baseDateUtc =
        DateTime.utc(baseDate.year, baseDate.month, baseDate.day);
    final List<DaysSlide> slides = _buildDaysSlides(
      locale: locale,
      midWeekday: middleWeekday,
      model: model,
      baseDate: baseDateUtc,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.width / 7,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white,
        child: Carousel(
          pageController: model.pageController,
          showIndicator: false,
          autoplay: false,
          images: slides,
        ),
      ),
    );
  }

  List<DaysSlide> _buildDaysSlides({
    @required int midWeekday,
    @required InlineCalenderModel model,
    @required Locale locale,
    @required DateTime baseDate,
  }) {
    List<DaysSlide> slides = [];
    final DateTime middleDate = safeAdd(
      baseDate,
      Duration(days: midWeekday - baseDate.weekday),
    );

    final DateTime firstSlideMiddleDate =
        safeSubtract(middleDate, Duration(days: (7 * maxWeeks)));

    for (int i = 0; i < maxWeeks * 2; i++) {
      slides.add(
        DaysSlide(
          pageNumber: i,
          middleDate: safeAdd(firstSlideMiddleDate, Duration(days: (i * 7))),
          isShamsi: isShamsi,
          locale: locale,
          model: model,
        ),
      );
    }

    model.lastBuildBaseDate = baseDate;
    return slides;
  }

  int _getPageNumber({
    @required DateTime dateTime,
    @required DateTime slidesBaseDate,
  }) {
    final DateTime utcDateTime =
        DateTime.utc(dateTime.year, dateTime.month, dateTime.day);
    final int totalPages = maxWeeks * 2;
    final DateTime date = removeTimeFrom(utcDateTime);
    final DateTime middleDate = safeAdd(
      slidesBaseDate,
      Duration(days: middleWeekday - slidesBaseDate.weekday),
    );

    final DateTime firstDateOfMiddleWeek =
        safeSubtract(middleDate, Duration(days: 3));
    final DateTime firstDateOfMiddleWeekWithoutTime = DateTime.utc(
        firstDateOfMiddleWeek.year,
        firstDateOfMiddleWeek.month,
        firstDateOfMiddleWeek.day);

    final int pageNumber =
        (utcDateTime.difference(firstDateOfMiddleWeekWithoutTime).inDays / 7).floor() +
            maxWeeks;

    return (pageNumber < 0 || pageNumber > totalPages - 1) ? null : pageNumber;
  }

  _jumpTo(int page, PageController pageController) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => pageController.jumpToPage(page),
    );
  }

  _animateTo(int page, PageController pageController) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => pageController.animateToPage(
        page,
        curve: Curves.ease,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
