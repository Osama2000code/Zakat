import 'package:flutter/material.dart';
import 'package:zakat_app/Components/Widget/my_ZkataIconButton.dart';
import 'package:zakat_app/Components/my_zakatInfo.dart';

class ZakatPage extends StatefulWidget {
  const ZakatPage({super.key});

  @override
  State<ZakatPage> createState() => _ZakatPageState();
}

class _ZakatPageState extends State<ZakatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              size: 25,
              Icons.heart_broken_sharp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              size: 25,
              Icons.wallet,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Zakat",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            height: 100,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const MyzakatInfo(info: "2025", title: "Time"),
                VerticalDivider(
                  color: Theme.of(context).colorScheme.primary,
                  indent: 5,
                  endIndent: 5,
                  width: 2.0,
                  thickness: 2.0,
                ),
                const MyzakatInfo(info: "5360.00", title: "Gold Time"),
                VerticalDivider(
                  color: Theme.of(context).colorScheme.primary,
                  indent: 5,
                  endIndent: 5,
                  width: 2.0,
                  thickness: 2.0,
                ),
                const MyzakatInfo(info: "1250.00", title: "Finshed"),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MyZkataIconButton(
                  onprees:(){},
                  icon: Icon(
                    Icons.add,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: "Zakat",
                ),
                MyZkataIconButton(
                  onprees:(){},

                  icon: Icon(
                    Icons.add,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: "Zakat",
                ),
                MyZkataIconButton(
                  onprees:(){},
                  icon: Icon(
                    Icons.add,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: "Zakat",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
