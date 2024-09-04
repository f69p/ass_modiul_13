import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  // Item quantities
  int pulloverQuantity = 1;
  int tShirtQuantity = 1;
  int sportDressQuantity = 1;

  // Item prices
  final double pulloverPrice = 51.0;
  final double tShirtPrice = 30.0;
  final double sportDressPrice = 43.0;

  double getTotalAmount() {
    return (pulloverQuantity * pulloverPrice) +
        (tShirtQuantity * tShirtPrice) +
        (sportDressQuantity * sportDressPrice);
  }

  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Congratulations! Your order has been placed.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            buildCartItem('Pullover', 'Black', 'L', pulloverQuantity, pulloverPrice, () {
              setState(() {
                if (pulloverQuantity > 1) pulloverQuantity--;
              });
            }, () {
              setState(() {
                pulloverQuantity++;
              });
            }),
            buildCartItem('T-Shirt', 'Gray', 'L', tShirtQuantity, tShirtPrice, () {
              setState(() {
                if (tShirtQuantity > 1) tShirtQuantity--;
              });
            }, () {
              setState(() {
                tShirtQuantity++;
              });
            }),
            buildCartItem('Sport Dress', 'Black', 'M', sportDressQuantity, sportDressPrice, () {
              setState(() {
                if (sportDressQuantity > 1) sportDressQuantity--;
              });
            }, () {
              setState(() {
                sportDressQuantity++;
              });
            }),
            Spacer(),
            Text(
              'Total amount: ${getTotalAmount().toStringAsFixed(2)}\$',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
           SizedBox(
             width: double.infinity,
             child:  ElevatedButton(
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.red,

               ),
               onPressed: () => showSnackbar(context),
               child: Text('CHECK OUT'),
             ),
           ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(String title, String color, String size, int quantity, double price, VoidCallback onDecrease, VoidCallback onIncrease) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
           Image.asset("asset/images/tshart.jpg",
             height: 100,
               width: 100,),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Color: $color  Size: $size'),

              ],
            ),
            Spacer(),
            IconButton(
              onPressed: onDecrease,
              icon: Icon(Icons.remove),
            ),
            Text(quantity.toString(), style: TextStyle(fontSize: 18)),
            IconButton(
              onPressed: onIncrease,
              icon: Icon(Icons.add),
            ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               Icon(Icons.more_vert),
                SizedBox(height: 46,),
               Text('${price.toStringAsFixed(2)}\$', style: TextStyle(fontSize: 18)),
             ],
           )
          ],
        ),
      ),
    );
  }
}

