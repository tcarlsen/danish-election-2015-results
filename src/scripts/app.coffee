apiIp = "//fv15api.bemit.dk"
socket = io "http://hosting-docker-fv15-ws-1802147016.eu-west-1.elb.amazonaws.com"

angular.module "ng-app", [
  "ngTouch"
  "ngRoute"
  "templates"
]
