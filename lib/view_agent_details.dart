import 'package:flutter/material.dart';

import 'api.dart';
import 'model_agentdet.dart';

class DetailPage extends StatefulWidget {
  final uuid;
  final String name;
  final String background;
  const DetailPage({ Key? key, required this.uuid, required this.name, required this.background}) : super(key: key);
  
  @override
  State<DetailPage> createState() => _UserDetailState();
}

class _UserDetailState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: NetworkImage(widget.background), fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.name.toString() + " Details"),
        ),body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildDetailedUsersBody(widget.uuid),
          ],
        ),
      ),
    ));
  }
}

Widget _buildDetailedUsersBody(String uuid){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadDetailAgent(uuid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingSection();
        }
        if (snapshot.hasData && snapshot.data != null) {
          AgentDetails detailAgent = AgentDetails.fromJson(snapshot.data);
          return _buildSuccessSection(detailAgent);
        }
        return _buildErrorSection(); // Handle the case when data is null
      },
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Error"),
  );
}

Widget _buildSuccessSection(AgentDetails data){
  return Center(
    child: Column(
      children: [
        Container(
          width: 600,
          child: Image.network(data.data!.fullPortraitV2!),
        ),
        Container(
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Text("\n" + data.data!.displayName!),
              Text(data.data!.role!.displayName!),
              Text(data.data!.description! + "\n", textAlign: TextAlign.justify,),
            ],
          )
        ),
      ],
    ),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}