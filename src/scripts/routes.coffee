.config ($routeProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "map.html"
      controller: "MapController"
    .when "/teaser/:url",
      templateUrl: "teaser.html"
      controller: "TeaserController"
    .when "/resultater/landet/:party",
      templateUrl: "party.html"
      controller: "PartyController"
    .when "/resultater/:path/:id?",
      templateUrl: "table.html"
      controller: "TableController"
    .when "/resultater/:path/:id/:party",
      templateUrl: "party.html"
      controller: "PartyController"
    .otherwise "/"
