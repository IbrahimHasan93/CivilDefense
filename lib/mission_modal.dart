class MissionModal {
  final int? id;
  final String name;
  final int age;
  final String pandemicName;
  final String missionTime;
  final String driverName;
  final String? additionalInfo;

  MissionModal(
      {required this.id,
      required this.name,
      required this.age,
      required this.pandemicName,
      required this.driverName,
      required this.missionTime,
      this.additionalInfo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'pandemicName': pandemicName,
      'missionTime': missionTime,
      'driverName': driverName,
      'additionalInfo': additionalInfo
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Mission {id: $id, name: $name, age: $age, pandemicName:$pandemicName , missionTime:$missionTime, driverName:$driverName, additionalInfo:$additionalInfo }';
  }
}
