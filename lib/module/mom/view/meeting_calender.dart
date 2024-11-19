import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarCard extends StatefulWidget {
  final List<DateTime> meetingDates;
  final Map<DateTime, List<String>> meetingDetails;

  CalendarCard({required this.meetingDates, required this.meetingDetails});

  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final daysOfWeek =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Expanded(
      child: Container(
        height: 100.0,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  selectedDate = selectedDate.subtract(Duration(days: 7));
                });
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: daysOfWeek.map((date) {
                  // Check if the date has any meetings
                  final hasMeeting = widget.meetingDetails
                      .containsKey(DateTime(date.year, date.month, date.day));

                  // Format the tooltip message for multiple meetings
                  final tooltipMessage = hasMeeting
                      ? widget.meetingDetails[
                                  DateTime(date.year, date.month, date.day)]
                              ?.asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key + 1;
                            String details = entry
                                .value; // Assume each item is formatted like "Place, Time, Agenda"
                            return "Meeting $index:\n$details";
                          }).join('\n\n') ??
                          "No meetings"
                      : "No meetings";

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Tooltip(
                      message: tooltipMessage,
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[700]?.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.3),
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('E').format(date),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: date == selectedDate
                                  ? Colors.deepPurple[400]
                                  : Colors.blueGrey[600],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: date == selectedDate
                                  ? Colors.deepPurple[400]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              DateFormat('d').format(date),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: date == selectedDate
                                    ? Colors.white
                                    : Colors.blueGrey[800],
                                fontWeight: date == selectedDate
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          if (hasMeeting)
                            Icon(
                              Icons.circle,
                              size: 5.0,
                              color: Colors.orangeAccent,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  selectedDate = selectedDate.add(Duration(days: 7));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
