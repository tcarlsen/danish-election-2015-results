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

  socket.removeAllListeners()

  socket.on "location", (message) ->
    thisIdent = $routeParams.id
    thisIdent = "L1" if $routeParams.path is "landet"

    if message.result.ident is thisIdent
      console.log message.result
      $scope.$apply ->
        $scope.json.table = message.result
