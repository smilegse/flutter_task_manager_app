class VillaModel {
  int? statusCode;
  bool? isSuccess;
  String? errorMessages;
  List<Result>? result;

  VillaModel(
      {this.statusCode, this.isSuccess, this.errorMessages, this.result});

  VillaModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    errorMessages = json['errorMessages'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['isSuccess'] = isSuccess;
    data['errorMessages'] = errorMessages;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? details;
  int? occupancy;
  int? sqft;
  double? rate;
  String? imageUrl;
  String? amenity;
  String? createdDate;
  String? updatedDate;

  Result(
      {this.id,
        this.name,
        this.details,
        this.occupancy,
        this.sqft,
        this.rate,
        this.imageUrl,
        this.amenity,
        this.createdDate,
        this.updatedDate});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    occupancy = json['occupancy'];
    sqft = json['sqft'];
    rate = json['rate'];
    imageUrl = json['imageUrl'];
    amenity = json['amenity'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['details'] = details;
    data['occupancy'] = occupancy;
    data['sqft'] = sqft;
    data['rate'] = rate;
    data['imageUrl'] = imageUrl;
    data['amenity'] = amenity;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
