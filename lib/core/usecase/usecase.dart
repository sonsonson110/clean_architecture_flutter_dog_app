// each usecase have its return type and its input
abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}
