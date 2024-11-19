class EmployeeSelection {
  int? _id;
  String? _name;
  String? _position;
  String? _stakeholder;
  String? _signing;
  String? _nik;
  int? _status;
  int? isPresent;
  int? _representative_signer;

  // Getters
  int? get id => _id;
  String? get name => _name;
  String? get position => _position;
  String? get stakeholder => _stakeholder;
  String? get signing => _signing;
  int? get status => _status;
  String? get nik => _nik;
  int? get is_present => isPresent;
  int? get representative_signer => _representative_signer;

  // Setters
  set id(int? value) {
    _id = value;
  }

  set name(String? value) {
    _name = value;
  }

  set position(String? value) {
    _position = value;
  }

  set nik(String? val) {
    _nik = val;
  }

  set stakeholder(String? val) {
    _stakeholder = val;
  }

  set signing(String? val) {
    _signing = val;
  }

  set status(int? val) {
    _status = val;
  }

  set is_present(int? val) {
    isPresent = val;
  }

  set representative_signer(int? val) {
    _representative_signer = val;
  }

  EmployeeSelection({
    int? id,
    String? name,
    String? position,
    String? nik,
    String? stakeholder,
    String? signing,
    int? status,
    int? representative_signer,
    int? isPresent,
  }) {
    _id = id;
    _name = name;
    _position = position;
    _nik = nik;
    _stakeholder = stakeholder;
    _signing = signing;
    _status = status;
    _representative_signer = representative_signer;
    isPresent = isPresent;
  }
}
