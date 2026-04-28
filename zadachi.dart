// 1. Кружка и Человек
class Mug {
  double amount;
  Mug(this.amount);
}

class Person {
  void drinkFrom(Mug mug, double amount) {
    mug.amount -= amount;
  }
}

// 2. Шкаф с системами хранения
class StorageSystem {
  final String name;
  final List<String> items = [];
  StorageSystem(this.name);
}

class Wardrobe {
  final List<StorageSystem> systems = [];

  void put(StorageSystem system, String item) {
    system.items.add(item);
  }

  String? take(StorageSystem system, String item) {
    return system.items.remove(item) ? item : null;
  }
}

// 3. Гриф и Блины
class Plate {
  final double weight;
  Plate(this.weight);
}

class Barbell {
  final double maxLoad;
  final List<Plate> left = [], right = [];
  double _currentLoad = 0;
  Barbell(this.maxLoad);

  bool add(Plate plate, {required bool toLeft}) {
    if (_currentLoad + plate.weight > maxLoad) return false;
    (toLeft ? left : right).add(plate);
    _currentLoad += plate.weight;
    return true;
  }
}

// 4. Конвертер валют
class CurrencyConverter {
  final Map<String, double> rates;
  CurrencyConverter(this.rates);

  double convert(double amount, String from, String to) {
    return amount * rates[from]! / rates[to]!;
  }
}

// 5. Гараж на дженериках
class Garage<T> {
  final List<T> _objects = [];
  void park(T obj) => _objects.add(obj);
  T? retrieve(T obj) => _objects.remove(obj) ? obj : null;
}

// 6. Класс с перегруженными арифметическими операциями
class Number {
  final double value;
  Number(this.value);

  Number operator +(Number d) => Number(value + d.value);
  Number operator -(Number d) => Number(value - d.value);
  Number operator *(Number d) => Number(value * d.value);
  Number operator /(Number d) => Number(value / d.value);

  @override
  String toString() => value.toString();
}

// 7. Автомобиль с состояниями
enum CarState { stop, drive, turn }

class Car {
  CarState state = CarState.stop;

  void drive() => state = CarState.drive;
  void stop() => state = CarState.stop;
  void turn() => state = CarState.turn;
}

// 8. Геометрические фигуры
abstract class Shape {
  double get area;
}

class Rectangle extends Shape {
  final double width, height;
  Rectangle(this.width, this.height);
  double get area => width * height;
}

class Triangle extends Shape {
  final double base, height;
  Triangle(this.base, this.height);
  double get area => 0.5 * base * height;
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
  double get area => 3.14 * radius * radius;
}

// 9. Класс для перевода систем счисления
class NumberConverter {
  String convert(String number, int fromBase, int toBase) {
    return int.parse(number, radix: fromBase).toRadixString(toBase);
  }
}

// 10. Класс со списком фигур, поиск максимальной площади
class ShapeCollection {
  final List<Shape> _shapes = [];

  void add(Shape f) => _shapes.add(f);
  Shape? maxAreaShape() {
    if (_shapes.isEmpty) return null;
    return _shapes.reduce((a, b) => a.area > b.area ? a : b);
  }
}

// 11. Стол и столовые приборы
abstract class Tableware {}

class Fork extends Tableware {}
class Spoon extends Tableware {}
class Knife extends Tableware {}

class Table {
  final List<Tableware> _items = [];

  void put(Tableware p) => _items.add(p);
  void remove(Tableware p) => _items.remove(p);
}

void main() {
  print('1');
  final k = Mug(0.5);
  Person().drinkFrom(k, 0.2);
  print('Осталось: ${k.amount}');

  print('2');
  final polka = StorageSystem('Верхняя полка');
  final shkaf = Wardrobe();
  shkaf.systems.add(polka);
  shkaf.put(polka, 'Свитер');
  print('Забрали: ${shkaf.take(polka, 'Свитер')}');

  print('3');
  final grif = Barbell(100);
  grif.add(Plate(20), toLeft: true);
  print('Слева блинов: ${grif.left.length}');

  print('4');
  final kv = CurrencyConverter({'USD': 90.0, 'EUR': 100.0});
  print('100 USD = ${kv.convert(100, 'USD', 'EUR')} EUR');

  print('5');
  final g = Garage<String>();
  g.park('Lada');
  print('Забрали: ${g.retrieve('Lada')}');

  print('6');
  print('10 + 5 = ${Number(10) + Number(5)}');

  print('7');
  final a = Car();
  a.drive();
  print('Состояние: ${a.state}');
  a.turn();
  print('Состояние: ${a.state}');

  print('8');
  print('Площадь: ${Rectangle(4, 5).area}');

  print('9');
  final perevod = NumberConverter();
  print('255 -> hex: ${perevod.convert('255', 10, 16)}');

  print('10');
  final kf = ShapeCollection();
  kf.add(Rectangle(2, 3));
  kf.add(Circle(5));
  print('Макс. площадь: ${kf.maxAreaShape()?.area}');

  print('11');
  final stol = Table();
  stol.put(Fork());
  stol.put(Spoon());
  print('Приборы на столе');
}