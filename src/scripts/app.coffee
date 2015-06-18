apiIp = "//fv15api.bemit.dk"

if window.location.hash.indexOf("teaser") is -1
  socket = io "http://hosting-docker-fv15-ws-1802147016.eu-west-1.elb.amazonaws.com"

angular.module "ng-app", [
  "ngTouch"
  "ngRoute"
  "templates"
]
