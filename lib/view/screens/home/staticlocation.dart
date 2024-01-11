import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;

  const LocationListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 160, 3, 32),// Red background color
        child: Icon(iconData, color: Colors.white), // White icon color
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}

class StaticLocation extends StatelessWidget {
  final List<Map<String, dynamic>> locations = [
    {
      'title': 'Home',
      'subtitle': '7th cross, BTM Layout',
      'icon': Icons.home,
    },
    {
      'title': 'Work',
      'subtitle': 'Banshankri, Bangalore, Karnataka',
      'icon': Icons.work,
    },
    {
      'title': 'House',
      'subtitle': 'Gubbala, Subramanyapura, Bengaluru, Karnataka',
      'icon': Icons.favorite,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemCount: locations.length,
      padding:const EdgeInsets.symmetric(vertical: 5),
      
      itemBuilder: (context, index) {
        return LocationListTile(
          title: locations[index]['title']!,
          subtitle: locations[index]['subtitle']!,
          iconData: locations[index]['icon'],
        );
      },
    );
  }
}
