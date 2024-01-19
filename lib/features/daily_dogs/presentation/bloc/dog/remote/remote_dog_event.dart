abstract class RemoteDogsEvent {
  const RemoteDogsEvent();
}

// only one event that is get dogs
class GetDogs extends RemoteDogsEvent {
  const GetDogs();
}
