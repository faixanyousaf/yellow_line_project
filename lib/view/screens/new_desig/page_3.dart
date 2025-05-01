import 'package:flutter/material.dart';


class Page_3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Drivers'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DriverCard(
                    vehicle: "SUV - Maruti Suzuki, Wagon-R",
                    name: "Kane Adams",
                    rating: 3.5,
                    reviews: 40,
                    time: "18 mins",
                    distance: "3.6 km",
                    fare: 3.50,
                  ),
                  SizedBox(height: 16),
                  DriverCard(
                    vehicle: "Sedan - Volkswagen, Vento",
                    name: "Deborah G. Frost",
                    rating: 1.5,
                    reviews: 10,
                    time: "32 mins",
                    distance: "5.6 km",
                    fare: 12.50,
                  ),
                ],
              ),
            ),
            OfferFareWidget(),
          ],
        ),
      ),
    );
  }
}

class DriverCard extends StatelessWidget {
  final String vehicle;
  final String name;
  final double rating;
  final int reviews;
  final String time;
  final String distance;
  final double fare;

  const DriverCard({
    required this.vehicle,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.time,
    required this.distance,
    required this.fare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vehicle, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 18, color: Colors.black),
                    ),
                    SizedBox(width: 8),
                    Text('$name'),
                  ],
                ),
                SizedBox(height: 8),
                Text('$time, $distance'),
              ],
            ),
            Column(
              children: [
                Text('\$${fare.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Text('$rating ($reviews)', style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Accept'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Decline'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OfferFareWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Offer Your Fare', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                ),
                Text('\$3.50', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
