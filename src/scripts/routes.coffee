.config ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "partials/map.html"
      controller: "MapController"
    .otherwise "/"
