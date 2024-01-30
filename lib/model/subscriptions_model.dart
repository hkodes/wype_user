class Subscriptions {
  List<AddServices>? addServices;
  List<AddServices>? removeService;
  List<AddServices>? packages;
  List<AddServices>? promoCodes;
  List<AddServices>? extraService;

  Subscriptions(
      {this.addServices, this.removeService, this.packages, this.promoCodes});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    if (json['add_services'] != null) {
      addServices = <AddServices>[];
      json['add_services'].forEach((v) {
        addServices!.add(AddServices.fromJson(v));
      });
    }
    if (json['extra_services'] != null) {
      extraService = <AddServices>[];
      json['extra_services'].forEach((v) {
        extraService!.add(AddServices.fromJson(v));
      });
    }
    if (json['promo_codes'] != null) {
      promoCodes = <AddServices>[];
      json['promo_codes'].forEach((v) {
        promoCodes!.add(AddServices.fromJson(v));
      });
    }
    if (json['remove_service'] != null) {
      removeService = <AddServices>[];
      json['remove_service'].forEach((v) {
        removeService!.add(AddServices.fromJson(v));
      });
    }
    if (json['packages'] != null) {
      packages = <AddServices>[];
      json['packages'].forEach((v) {
        packages!.add( AddServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (addServices != null) {
      data['add_services'] = addServices!.map((v) => v.toJson()).toList();
    }
       if (extraService != null) {
      data['extra_services'] = extraService!.map((v) => v.toJson()).toList();
    }
    if (removeService != null) {
      data['remove_service'] =
          removeService!.map((v) => v.toJson()).toList();
    }
    if (promoCodes != null) {
      data['promo_codes'] = promoCodes!.map((v) => v.toJson()).toList();
    }
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddServices {
  num? price;
  String? subtitle;
  String? name;

  AddServices({this.price, this.subtitle, this.name});

  AddServices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    subtitle = json['subtitle'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['subtitle'] = this.subtitle;
    data['name'] = this.name;
    return data;
  }
}
