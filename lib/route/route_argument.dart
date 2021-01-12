class RouteArgument {
  String id;
  String heroTag;
  dynamic param;
  bool fromStart;

  RouteArgument({this.id, this.heroTag, this.param,this.fromStart});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
