.config ($routeProvider) ->
  $routeProvider
    .when "/map",
      templateUrl: "partials/map.html"
      controller: "MapController"
    .when "/table/:id",
      templateUrl: "partials/table.html"
      controller: "TableController"
    .otherwise "/map"
