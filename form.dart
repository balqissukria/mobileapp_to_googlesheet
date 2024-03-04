class SuForm {
  String state;
  String outlet;
  String invoiceDate;
  String balanceStock;
  String qtyBs;
  String restockOptions;
  String qtyR;
  String remarks;

  SuForm(this.state, this.outlet, this.invoiceDate, this.balanceStock,
      this.qtyBs, this.restockOptions, this.qtyR, this.remarks);

  factory SuForm.fromJson(dynamic json) {
    return SuForm(
        "${json['state']}",
        "${json['outlet']}",
        "${json['invoiceDate']}",
        "${json['balanceStock']}",
        "${json['qtyBs']}",
        "${json['restock']}",
        "${json['qtyR']}",
        "${json['remarks']}");
  }

  // Method to make GET parameters.
  Map<String, dynamic> toJson() => {
        'state': state,
        'outlet': outlet,
        'invoiceDate': invoiceDate,
        'balanceStock': balanceStock,
        'qtyBs': qtyBs,
        'restockOption': restockOptions,
        'qtyR': qtyR,
        'remarks': remarks,
      };
}
