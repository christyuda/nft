import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/mom/provider/manager/list_meeting_detail_provider.dart';
import 'package:webordernft/module/mom/provider/manager/list_meetings_provider.dart';

class SingingOnlinePage extends StatefulWidget {
  final int meetingId;

  SingingOnlinePage({required this.meetingId});

  @override
  _SingingOnlinePageState createState() => _SingingOnlinePageState();
}

class _SingingOnlinePageState extends State<SingingOnlinePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch meeting details on page load
      final detailProvider =
          Provider.of<MeetingListDetailProvider>(context, listen: false);
      final tokenProvider =
          Provider.of<ListMeetingsProvider>(context, listen: false);

      final token = tokenProvider.validationToken; // Get token from provider
      if (token != null) {
        detailProvider.fetchMeetingById(context, widget.meetingId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Token not available')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<MeetingListDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Meeting Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: detailProvider.meetingData != null
                ? () {
                    print("Opening PDF for meetingId: ${widget.meetingId}");
                    // Add logic to open PDF
                  }
                : null,
            tooltip: 'Lihat PDF',
          ),
        ],
      ),
      body: detailProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : detailProvider.errorMessage != null
              ? Center(child: Text(detailProvider.errorMessage!))
              : detailProvider.meetingData != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Author: ${detailProvider.meetingData!.author}",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Date: ${detailProvider.meetingData!.date}",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Time: ${detailProvider.meetingData!.time}",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Place: ${detailProvider.meetingData!.place}",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Agenda: ${detailProvider.meetingData!.agenda}",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Audiences:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  detailProvider.meetingData!.audiences.length,
                              itemBuilder: (context, index) {
                                final audience = detailProvider
                                    .meetingData!.audiences[index];
                                return ListTile(
                                  title: Text(audience.name),
                                  subtitle: Text("NIK: ${audience}"),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(child: Text("No meeting data available.")),
    );
  }
}
