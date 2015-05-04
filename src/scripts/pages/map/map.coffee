.controller "MapController", ($scope, $http) ->
  $scope.tab = "2011"
  $scope.json = $scope.json or {}

  $http.get "http://10.86.233.44:8000/map"
    .success (data) ->
      $scope.json.map = data
    .error (data, status, headers, config) ->
      return
