class Tag{
  String? name;
  String? color;

  Tag({this.name, this.color});

  Tag.clone(Tag t){
    name = t.name;
    color = t.color;
  }

  Tag.fromMap(Map map){
    if(map['name'] is String){
      name = map['name'];
    }
    if(map['color'] is String){
      color = map['color'];
    }
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is Tag && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Tag{name: $name, color: $color}';
  }

  Map toMap() {
    return {
      'name':name,
      'color':color
    };
  }
}