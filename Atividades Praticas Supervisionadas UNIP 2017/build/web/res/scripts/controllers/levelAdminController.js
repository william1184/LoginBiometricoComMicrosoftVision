var angular = angular.module("angular",[]);


angular.controller('levelOneController', function($scope,$http, $window, $timeout){
    
 
  var CTX = $window.ctx;
  $scope.acc = "";
  $scope.pass = "";
  $scope.arrayItems = [{"prop":"São José","qtd":"112","pol":"Acaricidas"},{"prop":"Marcos França","qtd":"121","pol":"Algicidas"}, {"prop":"Atibaia","qtd":"120","pol":"Bactericidas"},{"prop":"Hernandes","qtd":"50","pol":"Fungicidas"},{"prop":"Alto da Serra","qtd":"105","pol":"Herbicidas"},{"prop":"Pereira","qtd":"55","pol":"Inseticidas"},{"prop":"Pedreira","qtd":"51","pol":"Piscicidas"},{"prop":"São João","qtd":"50","pol":"Acaricidas"},{"prop":"Operario","qtd":"140","pol":"Acaricidas"},{"prop":"José Couto","qtd":"250","pol":"Nematicidas"},{"prop":"Nine Finger","qtd":"220","pol":"Inseticidas"},{"prop":"Cosmopolitan","qtd":"150","pol":"Fungicidas"}];
  $scope.arrayTipoPropriedade = [ "quinta", "sítio", "chácara", "roça", "estância", "herdade", "granja", "fazenda", "engenho","fazenda","sítio","chácara"];
 
    
    
});