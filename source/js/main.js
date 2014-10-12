'use strict';

(function() {
  angular.module('iapShame', [])
  .run(function($rootScope) {
    $rootScope.search = {
      term: ''
    }
  })
  .controller("SearchController", function($scope) {
    $scope.search = {
      term: ''
    };

    $scope.searching = function() {
      $scope.$root.search = $scope.search
    }

    $scope.hideWhenSearching = function(game_name) {
      var term = $scope.$root.search.term;
      if($scope.$root.search.term == '') return false
      var expression = new RegExp($scope.$root.search.term, "i");

      if(game_name.match(expression)) {
        return false
      } else {
        return true
      }
    }
  })
})();

