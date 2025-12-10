// import 'package:baca_meter/core/data/database/database.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class ReadingItem extends StatelessWidget {
//   // final MeterReading reading;

//   const ReadingItem({super.key, required this.reading});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         title: Text(reading.customerName),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('ID: ${reading.customerId}'),
//             Text('Meter: ${reading.meterValue.toStringAsFixed(2)}'),
//             Text('Tanggal: ${reading.readingDate.toLocal().toString().split(' ')[0]}'),
//           ],
//         ),
//         trailing: reading.imageUrl != null
//             ? FutureBuilder<String>(
//                 future: _getImagePath(reading.imageUrl!),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Image.file(
//                       File(snapshot.data!),
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                       errorBuilder: (c, e, s) => const Icon(Icons.image, size: 50),
//                     );
//                   }
//                   return const Icon(Icons.image, size: 50);
//                 },
//               )
//             : const Icon(Icons.image_not_supported, size: 50),
//       ),
//     );
//   }

//   Future<String> _getImagePath(String filename) async {
//     final dir = await getApplicationDocumentsDirectory();
//     return '${dir.path}/images/$filename';
//   }
// }