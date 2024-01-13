// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:apay/classes/datepicker/scroll_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DateScrollView extends StatelessWidget {
  const DateScrollView({
    super.key,
    required this.onChanged,
    required this.dates,
    required this.controller,
    required this.options,
    required this.scrollViewOptions,
    required this.selectedIndex,
    required this.locale,
    this.isYearScrollView = false,
    this.isMonthScrollView = false,
  });

  /// A controller for scroll views whose items have the same size.
  final FixedExtentScrollController controller;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<int> onChanged;

  /// This is a list of dates.
  final List dates;

  /// A set that allows you to specify options related to ListWheelScrollView.
  final DatePickerOptions options;

  /// A set that allows you to specify options related to ScrollView.
  final ScrollViewDetailOptions scrollViewOptions;

  /// The currently selected date index.
  final int selectedIndex;

  /// Set calendar language
  final Locale locale;

  final bool isYearScrollView;

  final bool isMonthScrollView;

  double _getScrollViewWidth(BuildContext context) {
    String longestText = '';
    List _dates = isMonthScrollView ? locale.months : dates;
    for (var text in _dates) {
      if ('$text'.length > longestText.length) {
        longestText = '$text'.padLeft(2, '0');
      }
    }
    longestText += scrollViewOptions.label;
    final TextPainter _painter = TextPainter(
      text: TextSpan(
        style: scrollViewOptions.selectedTextStyle,
        text: longestText,
      ),
      textDirection: Directionality.of(context),
    );
    _painter.layout();
    return locale.languageCode == ar
        ? _painter.size.width + 40.0
        : _painter.size.width + 8.0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int _maximumCount = constraints.maxHeight ~/ options.itemExtent;
        return Container(
          margin: scrollViewOptions.margin,
          width: _getScrollViewWidth(context),
          child: ListWheelScrollView.useDelegate(
            itemExtent: options.itemExtent,
            diameterRatio: options.diameterRatio,
            controller: controller,
            physics: const FixedExtentScrollPhysics(),
            perspective: options.perspective,
            onSelectedItemChanged: onChanged,
            childDelegate: options.isLoop && dates.length > _maximumCount
                ? ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      dates.length,
                      (index) => _buildDateView(index: index),
                    ),
                  )
                : ListWheelChildListDelegate(
                    children: List<Widget>.generate(
                      dates.length,
                      (index) => _buildDateView(index: index),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildDateView({required int index}) {
    return Container(
      alignment: scrollViewOptions.alignment,
      child: Text(
        '${dates[index]}${scrollViewOptions.label}',
        style: selectedIndex == index
            ? scrollViewOptions.selectedTextStyle
            : scrollViewOptions.textStyle,
      ),
    );
  }
}
