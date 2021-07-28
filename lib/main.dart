import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class Item {
  final IconData icon;
  final String label;

  const Item(this.label, this.icon);
}

const items = [
  Item('闲鱼', Icons.home_rounded),
  Item('会玩', Icons.motion_photos_on_rounded),
  Item('消息', Icons.message_rounded),
  Item('我的', Icons.sentiment_satisfied_rounded),
];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Item active = items[0];

  @override
  Widget build(BuildContext context) {
    final children = items
        // ignore: unnecessary_cast
        .map((item) => NavItem(item, item == active, onChanged) as Widget)
        .toList();
    children.insert(2, const CentralNavItem());
    return Scaffold(
      body: Center(child: Icon(active.icon, size: 60)),
      bottomNavigationBar: BottomAppBar(
        shape: CustomNotchedShape(context),
        child: SizedBox(height: 58, child: Row(children: children)),
      ),
    );
  }

  void onChanged(Item item) {
    setState(() => active = item);
  }
}

class NavItem extends StatelessWidget {
  final Item item;
  final bool active;
  final void Function(Item) onPressed;

  const NavItem(this.item, this.active, this.onPressed);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.caption;
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onPressed(item),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(item.icon, color: active ? Color(0xfffed802) : style?.color),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: style?.copyWith(color: active ? Colors.black87 : null),
          ),
        ]),
      ),
    );
  }
}

class CentralNavItem extends StatelessWidget {
  const CentralNavItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Transform.scale(
        scale: 1.2,
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          backgroundColor: Color(0xffffe60f),
          elevation: 0,
          onPressed: () {},
          child: Icon(Icons.add_rounded, color: Colors.black87),
        ),
      ),
    );
  }
}

class CustomNotchedShape extends NotchedShape {
  final BuildContext context;
  const CustomNotchedShape(this.context);

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    const radius = 40.0;
    const lx = 20.0;
    const ly = 8;
    const bx = 10.0;
    const by = 20.0;
    var x = (MediaQuery.of(context).size.width - radius) / 2 - lx;
    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(x, host.top)
      // ..lineTo(x += lx, host.top - ly)
      ..quadraticBezierTo(x + bx, host.top, x += lx, host.top - ly)
      // ..lineTo(x += radius, host.top - ly)
      ..quadraticBezierTo(
          x + radius / 2, host.top - by, x += radius, host.top - ly)
      // ..lineTo(x += lx, host.top)
      ..quadraticBezierTo((x += lx) - bx, host.top, x, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom);
  }
}
