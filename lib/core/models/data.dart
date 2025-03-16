class DataModel {
/*
{
  "Qty": 1,
  "Lot ID": 900064418,
  "Size": "2.00-2.99",
  "Carat": 2.01,
  "Lab": "GIA",
  "Shape": "BR",
  "Color": "F",
  "Clarity": "SI1",
  "Cut": "EX",
  "Polish": "EX",
  "Symmetry": "EX",
  "Fluorescence": "MED",
  "Discount": -51,
  "Per Carat Rate": 6027,
  "Final Amount": 12114.27,
  "Key To Symbol": "Crystal, Twinning Wisp, Feather, Needle, Indented Natural",
  "Lab Comment": "Additional twinning wisps, pinpoints and surface graining are not shown."
} 
*/

  int? qty;
  int? lotID;
  String? size;
  double? carat;
  String? lab;
  String? shape;
  String? color;
  String? clarity;
  String? cut;
  String? polish;
  String? symmetry;
  String? fluorescence;
  int? discount;
  int? perCaratRate;
  double? finalAmount;
  String? keyToSymbol;
  String? labComment;

  DataModel({
    this.qty,
    this.lotID,
    this.size,
    this.carat,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
    this.cut,
    this.polish,
    this.symmetry,
    this.fluorescence,
    this.discount,
    this.perCaratRate,
    this.finalAmount,
    this.keyToSymbol,
    this.labComment,
  });
  DataModel.fromJson(Map<String, dynamic> json) {
    qty = json['Qty']?.toInt();
    lotID = json['Lot ID']?.toInt();
    size = json['Size']?.toString();
    carat = json['Carat']?.toDouble();
    lab = json['Lab']?.toString();
    shape = json['Shape']?.toString();
    color = json['Color']?.toString();
    clarity = json['Clarity']?.toString();
    cut = json['Cut']?.toString();
    polish = json['Polish']?.toString();
    symmetry = json['Symmetry']?.toString();
    fluorescence = json['Fluorescence']?.toString();
    discount = json['Discount']?.toInt();
    perCaratRate = json['Per Carat Rate']?.toInt();
    finalAmount = json['Final Amount']?.toDouble();
    keyToSymbol = json['Key To Symbol']?.toString();
    labComment = json['Lab Comment']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Qty'] = qty;
    data['Lot ID'] = lotID;
    data['Size'] = size;
    data['Carat'] = carat;
    data['Lab'] = lab;
    data['Shape'] = shape;
    data['Color'] = color;
    data['Clarity'] = clarity;
    data['Cut'] = cut;
    data['Polish'] = polish;
    data['Symmetry'] = symmetry;
    data['Fluorescence'] = fluorescence;
    data['Discount'] = discount;
    data['Per Carat Rate'] = perCaratRate;
    data['Final Amount'] = finalAmount;
    data['Key To Symbol'] = keyToSymbol;
    data['Lab Comment'] = labComment;
    return data;
  }
}
