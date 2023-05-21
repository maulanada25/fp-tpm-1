import 'package:flutter/material.dart';
// import 'package:projecttpm/assets';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            child: Image.asset('images/3x4red.jpg', width: 360, height: 270,),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text("Maulana Daffa Ardiansyah\n123200130 - H", textAlign: TextAlign.center,),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            child: Text("Saran saya untuk mata kuliah ini yaitu untuk deadline tugas berupa koding untuk disesuaikan dengan jadwal kuliah, dan untuk memberi sedikit referensi pembelajaran.", textAlign: TextAlign.justify,)
          ),
          Container(
            width: 400,
            child: Text("Kesan yg saya dapat dari mata kuliah ini adalah bahwa saya merasa cukup bodoh karena tidak dapat menyelesaikan projek ini dengan maksimal.", textAlign: TextAlign.justify,)
          )
        ],
      ),
    );
  }
}