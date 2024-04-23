import 'package:flutter/material.dart';

class Plant {
  final String imageURL;
  final String category;
  final String plantName;
  final double price;
  bool isFavorated;

  Plant({
    required this.imageURL,
    required this.category,
    required this.plantName,
    required this.price,
    this.isFavorated = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Plant> _plantList = [
    Plant(
      imageURL: 'assets/images/homepage.jpg',
      category: 'Indoor',
      plantName: 'Plant 1',
      price: 20.0,
    ),
    Plant(
      imageURL: 'assets/images/homepage.jpg',
      category: 'Outdoor',
      plantName: 'Plant 2',
      price: 25.0,
    ),
    Plant(
      imageURL: 'assets/images/homepage.jpg',
      category: 'Garden',
      plantName: 'Plant 3',
      price: 30.0,
    ),
    Plant(
      imageURL: 'assets/images/homepage.jpg',
      category: 'Indoor',
      plantName: 'Plant 4',
      price: 22.0,
    ),
  ];

  List<String> _plantTypes = [
    'Recommended',
    'Indoor',
    'Outdoor',
    'Garden',
    'Supplement',
  ];

  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    width: size.width * .9,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black54.withOpacity(.6),
                        ),
                        const Expanded(
                          child: TextField(
                            showCursor: false,
                            decoration: InputDecoration(
                              hintText: 'Search Plant',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.mic,
                          color: Colors.black54.withOpacity(.6),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50.0,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _plantTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Text(
                        _plantTypes[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.w300,
                          color: selectedIndex == index
                              ? Colors.green // Adjust color as needed
                              : Colors.black, // Adjust color as needed
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * .3,
              child: ListView.builder(
                itemCount: _plantList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to detail page
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          Image.asset(
                            _plantList[index].imageURL,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 10,
                            right: 20,
                            child: Container(
                              height: 50,
                              width: 50,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    bool isFavorited = toggleIsFavorated(
                                      _plantList[index].isFavorated,
                                    );
                                    _plantList[index].isFavorated = isFavorited;
                                  });
                                },
                                icon: Icon(
                                  _plantList[index].isFavorated
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red, // Adjust color as needed
                                ),
                                iconSize: 30,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _plantList[index].category,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  _plantList[index].plantName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '\$${_plantList[index].price.toString()}',
                                style: TextStyle(
                                  color: Colors.green, // Adjust color as needed
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green
                            .withOpacity(.8), // Adjust color as needed
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: const Text(
                'New Plants',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * .5,
              child: ListView.builder(
                itemCount: _plantList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to detail page
                    },
                    child: PlantWidget(
                      index: index,
                      plantList: _plantList,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green, // Adjust color as needed
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

class PlantWidget extends StatelessWidget {
  final int index;
  final List<Plant> plantList;

  const PlantWidget({
    Key? key,
    required this.index,
    required this.plantList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(
          plantList[index].imageURL,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
        title: Text(plantList[index].plantName),
        subtitle: Text('\$${plantList[index].price}'),
        trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {
            // Toggle favorite status
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
