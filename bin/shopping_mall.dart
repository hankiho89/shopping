import 'dart:io';

class Product {
  final String name;
  final int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  final List<Product> products;
  final Map<String, int> cart = {};
  int total = 0;

  ShoppingMall(this.products);

  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  void addToCart() {
    stdout.write('상품 이름을 입력하세요: ');
    final name = stdin.readLineSync();

    stdout.write('상품 개수를 입력하세요: ');
    final countStr = stdin.readLineSync();

    if (name == null || countStr == null || name.isEmpty) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    final product = products.firstWhere(
      (p) => p.name == name,
      orElse: () => Product('', 0),
    );

    if (product.name == '') {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    int count;
    try {
      count = int.parse(countStr);
    } catch (_) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    if (count <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      return;
    }

    cart[name] = (cart[name] ?? 0) + count;
    total += product.price * count;
    print('장바구니에 상품이 담겼어요 !');
  }

  void showCartDetails() {
    if (cart.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      final names = cart.keys.join(', ');
      print('장바구니에 $names 이(가) 담겨있네요. 총 $total원 입니다!');
    }
  }

  void showTotal() {
    print('장바구니에 $total원 어치를 담으셨네요 !');
  }

  void clearCart() {
    if (cart.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
    } else {
      cart.clear();
      total = 0;
      print('장바구니를 초기화합니다.');
    }
  }
}

void main() {
  final mall = ShoppingMall([
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ]);

  bool running = true;

  while (running) {
    print('\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 목록 및 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화');
    stdout.write('원하는 기능의 번호를 입력하세요: ');
    final input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showCartDetails();
        break;
      case '4':
        stdout.write('정말 종료하시겠습니까? (종료하려면 5 입력): ');
        final confirm = stdin.readLineSync();
        if (confirm == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
          running = false;
        } else {
          print('종료하지 않습니다.');
        }
        break;
      case '6':
        mall.clearCart();
        break;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
