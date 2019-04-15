class Order {
  String _studId;
  String _studName;
  String _productName;
  String _productPrice;
  String _productQuantity;

  Order(this._studId, this._studName, this._productName, this._productPrice, this._productQuantity);

  Order.map(dynamic obj) {
    this._studId = obj['studId'];
    this._studName = obj['studName'];
    this._productName = obj['name'];
    this._productPrice = obj['price'];
    this._productQuantity = obj['quantity'];
  }

  String get studId => _studId;
  String get studName => _studName;
  String get productName => _productName;
  String get productPrice => _productPrice;
  String get productQuantity => _productQuantity;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['studId'] = _studId;
    map['studName'] = _studName;
    map['name'] = _productName;
    map['price'] = _productPrice;
    map['quantity'] = _productQuantity;

    return map;
  }

  Order.fromMap(Map<String, dynamic> map) {
    this._studId = map['studId'];
    this._studName = map['studName'];
    this._productName = map['name'];
    this._productPrice = map['price'];
    this._productQuantity = map['quantity'];
  }
}
