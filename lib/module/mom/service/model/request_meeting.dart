class MeetingRequest {
  final String author;
  final String date;
  final String time;
  final String place;
  final String agenda;
  final List<MeetingNote> notes;
  final List<Attendee> attendees;
  final List<MaterialDiscuss> materials;
  MeetingRequest({
    required this.author,
    required this.date,
    required this.time,
    required this.place,
    required this.agenda,
    required this.notes,
    required this.attendees,
    required this.materials,
  });

  Map<String, dynamic> toJson() {
    return {
      "author": author,
      "date": date,
      "time": time,
      "place": place,
      "agenda": agenda,
      "notes": notes.map((note) => note.toJson()).toList(),
      "attendees": attendees.map((attendee) => attendee.toJson()).toList(),
      "materials": materials.map((material) => material.toJson()).toList(),
    };
  }
}

class MaterialDiscuss {
  final String material;

  MaterialDiscuss({
    required this.material,
  });

  Map<String, dynamic> toJson() {
    return {
      "material": material,
    };
  }
}

class MeetingNote {
  final String note;
  final String pic;
  final String dueDate;

  MeetingNote({
    required this.note,
    required this.pic,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "note": note,
      "pic": pic,
      "due_date": dueDate,
    };
  }
}

class Attendee {
  final String nik;
  final String signing;
  final int status;
  final int isPresent;
  final int representativeSigner;
  Attendee({
    required this.nik,
    this.signing = "",
    required this.status,
    required this.isPresent,
    required this.representativeSigner,
  });

  Map<String, dynamic> toJson() {
    return {
      "nik": nik,
      "signing": signing,
      "status": status,
      "is_present": isPresent,
      "representative_signer": representativeSigner,
    };
  }
}
