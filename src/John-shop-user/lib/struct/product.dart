class Product {
  String _productName;
  String _productPrice;
  String _productPicture;

  Product(this._productName, this._productPrice, this._productPicture);

  Product.map(dynamic obj) {
    this._productName = obj['name'];
    this._productPrice = obj['price'];
    this._productPicture = obj['picture'];
  }

  String get productName => _productName;
  String get productPrice => _productPrice;
  String get productPicture => _productPicture;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _productName;
    map['price'] = _productPrice;
    map['picture'] = _productPicture;

    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    this._productName = map['name'];
    this._productPrice = map['price'];
    this._productPicture = map['picture'];
  }
}
