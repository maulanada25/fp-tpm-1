import 'view_agent_details.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'model_agents.dart' as a;
import 'model_weapons.dart' as w;

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // SizedBox(height: 30,),
          _buildListAgentBody(),
          // SizedBox(height: 30,),
          _buildListWeaponBody()
        ],
      );
  }

  Widget _buildErrorSection(){
    return Container(
      child: Text("Ada Error nih"),
    );
  }

  Widget _buildLoadingSection(){
    return CircularProgressIndicator();
  }

  Widget _buildListAgentBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadAgents(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){//snapshot digunakan untuk mengecek data apakah ada atau tidak
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            a.Agents agents = a.Agents.fromJson(snapshot.data);
            return _buildSuccesAgentSection(context, agents);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildSuccesAgentSection(BuildContext context, a.Agents data){
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount : data.data!.length,
          itemBuilder: (BuildContext context, int index){
            return _buildAgentItem(context, data.data![index]);
          }
      ),
    );
  }

  Widget _buildAgentItem(BuildContext context, a.Data data){
    if(data.isPlayableCharacter == true){
      return InkWell(
          onTap: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => DetailPage(uuid: data.uuid, name: data.displayName.toString(), background: data.background.toString()))
            );
          },
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 120,
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(data.displayIconSmall!),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(data.displayName!),
          ],
        ),
      ),
      );
    }else{
      return Container();
    }
  }
  
  Widget _buildListWeaponBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadWeapons(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){//snapshot digunakan untuk mengecek data apakah ada atau tidak
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            w.Weapons weapons = w.Weapons.fromJson(snapshot.data);
            return _buildSuccesWeaponSection(context, weapons);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildSuccesWeaponSection(BuildContext context, w.Weapons data){
    return Container(
      height: MediaQuery.of(context).size.height-326,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height-326,
          child: GridView.builder(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0,
              childAspectRatio: 2,
            ),
            itemCount: data.data!.length,
            itemBuilder: (BuildContext context, int index){
              return _buildWeaponItem(context, data.data![index]);
            }
          ),
        ),
      ),
    );
  }

  Widget _buildWeaponItem(BuildContext context, w.Data data){
    return Container(
    // margin: EdgeInsets.symmetric(horizontal: 5),
    height: 10,
    width: 10,
    child: Column(
      children: [
        Container(
          // width: 300,
          // height: 120,
          child: Image.network(data.displayIcon!, width: 300, height: 69),
        ),
        Text(data.displayName!),
      ],
    ),
      );
  }

}