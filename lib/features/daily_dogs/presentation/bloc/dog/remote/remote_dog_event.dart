abstract class RemoteDogsEvent {
  const RemoteDogsEvent();
}

// only get dogs
class GetDogs extends RemoteDogsEvent {
  const GetDogs();
}

// get extra dogs
class GetMoreDogs extends RemoteDogsEvent {
  int index;
  GetMoreDogs({required this.index});
}
