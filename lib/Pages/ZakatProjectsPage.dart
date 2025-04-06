import 'package:flutter/material.dart';
import 'package:zakat_app/Components/my_Button.dart';

class ZakatProjectsPage extends StatefulWidget {
  const ZakatProjectsPage({super.key});

  @override
  State<ZakatProjectsPage> createState() => _ZakatProjectsPageState();
}

class _ZakatProjectsPageState extends State<ZakatProjectsPage> {
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
        centerTitle: true,
        title: const Text("Zakat Info"),
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}

class ZakatScreen extends StatelessWidget {
  const ZakatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: const Text('Zakat Maal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(3.0),
                        topRight: Radius.circular(3.0),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png', // Replace with your image URL
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Zakat Maal can change lives',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'By Al-fath Foundation',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                              const Spacer(),
                              Text(
                                '280 days left',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: 0.2,
                            minHeight: 6,
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Rp 240.300.550',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Raised of Rp 1.830.300.560',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          Row(
                            children: [
                              Text(
                                'September 12, 2022',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Community and Society',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          Text(
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 13,
                            ),
                            'Join us in providing hope and a brighter future for orphaned children in need. Your zakat can make a difference for these vulnerable children, ensuring they have access to basic necessities, education, and a loving home... Read More',
                          ),
                          const SizedBox(height: 16),
                          MyButton(label: "Contnue", onTap: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
