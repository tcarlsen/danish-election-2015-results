.controller "MapController", ($scope, $http) ->
  $scope.tab = "2011"
  $scope.json = $scope.json or {}

  $http.get "#{apiIp}/map"
    .success (data) ->
      $scope.json.map = data
    .error (data, status, headers, config) ->
      return

  socket.on "votes_counted_pct", (message) ->
    $scope.$apply ->
      $scope.json.map.votes_counted_pct = message.result

  socket.on "block", (message) ->
    $scope.$apply ->
      $scope.json.map.blue_block = message.result.blue_block
      $scope.json.map.red_block = message.result.red_block

  socket.on "parties", (message) ->
    $scope.$apply ->
      $scope.json.map.parties = message.result

  socket.on "latest_votes_counted_complete", (message) ->
    $scope.$apply ->
      $scope.json.map.latest_votes_counted_complete.push(message.result)
