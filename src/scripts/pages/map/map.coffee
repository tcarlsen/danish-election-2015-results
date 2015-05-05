.controller "MapController", ($scope, $http) ->
  $scope.tab = "2011"
  $scope.json = $scope.json or {}

  $http.get "#{apiIp}/map"
    .success (data) ->
      $scope.json.map = data
    .error (data, status, headers, config) ->
      return
