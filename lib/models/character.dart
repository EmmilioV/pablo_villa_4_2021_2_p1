import 'psi_powers.dart';

class Characters {
  String gender = '';
  String img = '';
  String sId = '';
  String name = '';
  List<PsiPowers> psiPowers = [];
  int iV = 0;

  Characters(
      {required this.gender, required this.img, required this.sId, required this.name, required this.psiPowers, required this.iV});

  Characters.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    img = json['img'];
    sId = json['_id'];
    name = json['name'];
    json['psiPowers'].forEach((v) {
      psiPowers.add(new PsiPowers.fromJson(v));
    });
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['img'] = this.img;
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.psiPowers != null) {
      data['psiPowers'] = this.psiPowers.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}