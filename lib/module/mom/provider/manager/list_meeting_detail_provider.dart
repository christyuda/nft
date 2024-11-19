import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/module/mom/service/model/pin_detailistmeeting.dart';
import 'package:webordernft/module/mom/service/model/response_detaillistmeeting.dart';
import 'package:webordernft/module/mom/service/mom_service.dart';

class MeetingListDetailProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  MeetingData? _meetingData;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  MeetingData? get meetingData => _meetingData;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
   
    notifyListeners();
  }


  

  Future<void> fetchMeetingById(BuildContext context, int meetingId) async {
    setLoading(true);
    try {
      GetMeetingByIdRequest request =
          GetMeetingByIdRequest(meetingId: meetingId);
      GetMeetingByIdResponse response =
          await MomService.getMeetingById(context, request);

      if (response.status) {
        _meetingData = response.data;
        _errorMessage = null;
      } else {
        _meetingData = null;
        setErrorMessage(response.message);
      }
    } catch (error) {
      setErrorMessage("An error occurred: ${error.toString()}");
    } finally {
      setLoading(false);
    }
  }
}
