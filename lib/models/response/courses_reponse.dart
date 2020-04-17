
class CoursesResponse {

  int id;
  String name;
  String code;
  String description;
  int duration;

	CoursesResponse.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		code = map["code"],
		description = map["description"],
		duration = map["duration"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['code'] = code;
		data['description'] = description;
		data['duration'] = duration;
		return data;
	}
}