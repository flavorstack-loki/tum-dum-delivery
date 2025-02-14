import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumdum_delivery_app/util/color_util.dart';

class DateTimeUtil {
  static final now = DateTime.now();
  static final time = TimeOfDay(hour: now.hour, minute: now.minute);
  static final textStyle = GoogleFonts.plusJakartaSans(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
  static Future<DateTime?> selectDate(BuildContext context,
          {DateTime? initialDate}) async =>
      await showDatePicker(
          context: context,
          initialDate: initialDate,
          selectableDayPredicate: (day) => true,
          firstDate: DateTime(1950),
          lastDate: now,
          switchToInputEntryModeIcon: const Icon(FontAwesomeIcons.penToSquare),
          switchToCalendarEntryModeIcon:
              const Icon(FontAwesomeIcons.calendarDay),
          builder: (BuildContext context, Widget? child) => Theme(
              data: ThemeData.dark(useMaterial3: false)
                  .copyWith(
                    textTheme: TextTheme(
                      titleSmall: textStyle,
                    ),
                    colorScheme: const ColorScheme.dark(
                        //         primary: ColorUtil.goldHighlight,
                        secondary: Colors.white),
                  )
                  .copyWith(
                    timePickerTheme: const TimePickerThemeData(),
                    datePickerTheme: DatePickerThemeData(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        headerBackgroundColor: Colors.white,
                        headerHelpStyle: textStyle,
                        weekdayStyle: textStyle,
                        dayStyle: textStyle,
                        yearStyle: textStyle,
                        yearForegroundColor:
                            WidgetStateProperty.all(Colors.white),
                        todayForegroundColor:
                            WidgetStateProperty.all(Colors.white),
                        todayBorder: BorderSide.none,
                        dayForegroundColor:
                            WidgetStateProperty.all(Colors.white),
                        headerForegroundColor: Colors.black,
                        cancelButtonStyle: ButtonStyle(
                            textStyle: WidgetStatePropertyAll(textStyle
                                .copyWith(fontWeight: FontWeight.bold))),
                        confirmButtonStyle: ButtonStyle(
                            textStyle: WidgetStatePropertyAll(textStyle
                                .copyWith(fontWeight: FontWeight.bold))),
                        backgroundColor: ColorUtil.primaryColor),
                  ),
              child: child!));

  static Future selectTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context,
        initialTime: time,
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.dark(useMaterial3: false)
                  .copyWith(
                    //      textTheme: TextTheme(labelSmall: textStyle),
                    colorScheme: const ColorScheme.dark(
                        //       primary: ColorUtil.goldHighlight,
                        secondary: Colors.white),
                  )
                  .copyWith(
                    timePickerTheme: const TimePickerThemeData(
                        // cancelButtonStyle: ButtonStyle(
                        //     textStyle: WidgetStatePropertyAll(StyleUtil
                        //         .buttonTextStyle
                        //         .copyWith(fontWeight: FontWeight.bold))
                        //         ),
                        // confirmButtonStyle: ButtonStyle(
                        //     textStyle: WidgetStatePropertyAll(StyleUtil
                        //         .buttonTextStyle
                        //         .copyWith(fontWeight: FontWeight.bold))),
                        //   backgroundColor: ColorUtil.buttonBgColor
                        ),
                  ),
              child: child!);
        });
    if (picked != null) {
      return DateTime(2024, 1, 1, picked.hour, picked.minute);
    }
  }

  static bool isSameDayMonthYear(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
