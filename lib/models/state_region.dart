class StateRegionModel {

  String state;

  List<String> region;

  StateRegionModel({this.state, this.region});

  StateRegionModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    region = json['lgas'].cast<String>();
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['state'] = this.state;
    data['lgas'] = this.region;
    return data;
  }
}