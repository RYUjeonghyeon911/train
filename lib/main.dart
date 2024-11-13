import 'package:flutter/material.dart';

void main() => runApp(TrainApp());

class TrainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Booking App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('출발역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          )),
                      GestureDetector(
                        onTap: () async {
                          String? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationListPage(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              departureStation = result;
                            });
                          }
                        },
                        child: Text(
                          departureStation ?? '선택',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('도착역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          )),
                      GestureDetector(
                        onTap: () async {
                          String? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationListPage(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              arrivalStation = result;
                            });
                          }
                        },
                        child: Text(
                          arrivalStation ?? '선택',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: departureStation != null && arrivalStation != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatPage(
                            departureStation: departureStation ?? '',
                            arrivalStation: arrivalStation ?? '',
                          ),
                        ),
                      );
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  '좌석 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

class StationListPage extends StatelessWidget {
  final List<String> stations = [
    "수서",
    "동탄",
    "평택지제",
    "천안아산",
    "오송",
    "대전",
    "김천구미",
    "동대구",
    "경주",
    "울산",
    "부산"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('출발역'),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              stations[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context, stations[index]);
            },
          );
        },
      ),
    );
  }
}

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  SeatPage({required this.departureStation, required this.arrivalStation});

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<bool>> seats = List.generate(10, (index) => List.generate(4, (index) => false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.departureStation,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, size: 30, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    widget.arrivalStation,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 4),
                  Text('선택됨'),
                  SizedBox(width: 20),
                  Container(
                    width: 24,
                    height: 24,
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 4),
                  Text('선택 안됨'),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: List.generate(10, (rowIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(2, (colIndex) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              seats[rowIndex][colIndex] = !seats[rowIndex][colIndex];
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            decoration: BoxDecoration(
                              color: seats[rowIndex][colIndex] ? Colors.purple : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }),
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '${rowIndex + 1}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ...List.generate(2, (colIndex) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              seats[rowIndex][colIndex + 2] = !seats[rowIndex][colIndex + 2];
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            decoration: BoxDecoration(
                              color: seats[rowIndex][colIndex + 2] ? Colors.purple : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: seats.any((row) => row.contains(true))
                    ? () {
                        String selectedSeat = '';
                        for (int i = 0; i < seats.length; i++) {
                          for (int j = 0; j < seats[i].length; j++) {
                            if (seats[i][j]) {
                              selectedSeat = '${i + 1}-${String.fromCharCode(65 + j)}';
                              break;
                            }
                          }
                          if (selectedSeat.isNotEmpty) break;
                        }
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('예매 확인'),
                            content: Text('예매 하시겠습니까?\n좌석: $selectedSeat'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                },
                                child: Text('확인'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    '예매 하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
