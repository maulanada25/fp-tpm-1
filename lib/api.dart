import 'base_net.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadAgents(){
    return BaseNetwork.get("agents");
  }

  Future<Map<String, dynamic>> loadDetailAgent(String uuid){
    String id = uuid;
    return BaseNetwork.get("agents/"+id);
  }

  Future<Map<String, dynamic>> loadWeapons(){
    return BaseNetwork.get("weapons");
  }
}