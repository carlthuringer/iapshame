'use strict';

(function() {
  angular.module('iapShame', [])
  .factory('search', ['$location', function($location) {
    return { term: $location.search().search } }
  ])
  .controller("SearchController", [
    '$scope', '$rootScope', '$location', '$window', 'search',
    function($scope, $rootScope, $location, $window, search) {
      $scope.search = search

      $scope.searching = function() {
        search = $scope.search
      }

      $scope.searchSubmit = function() {
        if($location.url().match(/all_games/)) return void 0;

        $window.location = "all_games.html#?search=" + search.term
      }
    }
  ])
  .controller("AllGamesController", ['$scope', 'search', function($scope, search) {
    $scope.search = search

    $scope.hideWhenSearching = function(game_name) {
      var expression
      if(search.term == '') return false;
      try {
        expression = new RegExp(search.term, "i");
      } catch(e) {
        return false;
      }


      if(game_name.match(expression)) {
        return false
      } else {
        return true
      }
    }
  }])
})();

