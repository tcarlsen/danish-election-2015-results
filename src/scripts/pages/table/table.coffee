.controller "TableController", ($scope, $http, $routeParams) ->
  apiUrl = $routeParams.path
  apiUrl+= "/#{$routeParams.id}" if $routeParams.id

  $scope.json = $scope.json or {}

  $scope.changeOrder = (order) ->
    if $scope.order is order
      $scope.reverse =! $scope.reverse
    else
      $scope.order = order
      $scope.reverse = false

  $http.get "#{apiIp}/#{apiUrl}"
    .success (data) ->
      $scope.json.table = data
    .error (data, status, headers, config) ->
      return

  socket.on "location", (message) ->
    if message.result.ident is $routeParams.id
      $scope.$apply ->
        $scope.json.table = message.result
