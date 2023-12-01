Map<String,dynamic> convertMapBoolsToInt(Map<String,dynamic> map){
  Map<String,dynamic> newMap = {...map};
  for(String key in map.keys){
    if(map[key] == true || map[key] == false){
      newMap[key] = boolToInt(map[key]);
    }
  }
  return newMap;
}


bool intToBool(int a){
  return a == 1 ? true : false;
}

int boolToInt(bool a){
  return a ? 1 : 0;
}