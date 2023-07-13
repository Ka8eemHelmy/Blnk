class BlnkForm {
  String? firstName;
  String? lastName;
  String? address;
  String? area;
  String? landLine;
  String? mobile;
  String? frontID;
  String? backID;

  BlnkForm({
    this.firstName = '',
    this.lastName = '',
    this.address = '',
    this.area = '',
    this.landLine = '',
    this.mobile = '',
    this.frontID = '',
    this.backID = '',
  });

  factory BlnkForm.fromJson(Map<String, dynamic> json) {
    return BlnkForm(
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      area: json['area'],
      landLine: json['landLine'],
      mobile: json['mobile'],
      frontID: json['frontID'],
      backID: json['backID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'area': area,
        'landLine': landLine,
        'mobile': mobile,
        'frontID': frontID,
        'backID': backID,
      };
}
