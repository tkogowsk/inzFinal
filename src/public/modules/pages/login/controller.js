angular.module('Security', []);

angular.module('Security').controller('LoginController', ['$rootScope', '$scope', '$log', '$state', 'Authentication',
    function ($rootScope, $scope, $log, $state, Authentication) {

        $scope.userName = "";
        $scope.password = "";
        $scope.logIn = function () {
            Authentication.logIn({
                name: $scope.userName,
                password: $scope.password
            }, function (response) {
                if (response.data) {
                    $rootScope.userName = $scope.userName;
                    $scope.$emit(loggedInEvent + 'Emit');
                    $state.go('transcript-list');
                }
            }, function (error) {
                $scope.message = error.data
            });
        }

        $scope.register = function () {
            Authentication.register({
                name: $scope.userName,
                password: $scope.password
            }, function (response) {
                if (response.data) {
                    $scope.message = response.msg
                }
            }, function (error) {
                $scope.message = error.data
            });
        }

    }]);