
var bootstrapApp = angular.module( 'bootstrapApp' , [] )                       
             
             
             
              
bootstrapApp.controller('controladorCampo', ['$scope', '$http', function($scope, $http){
  //use $http.get() to get the list of students 
  $http.get('php/campo.php').then(function(response){
    //send back the student data to the list.html view
    $scope.campos = response.data



  });
}]);

bootstrapApp.controller('controladorMaquinista', ['$scope', '$http', function($scope, $http){
  //use $http.get() to get the list of students 
  $http.get('php/maquinista.php').then(function(response){
    //send back the student data to the list.html view
    $scope.maquinistas = response.data



  });
}]);

bootstrapApp.controller('controladorLote', ['$scope', '$http', function($scope, $http){
  //use $http.get() to get the list of students 
  $http.get('php/lote.php').then(function(response){
    //send back the student data to the list.html view
    $scope.lotes = response.data



  });
}]);

bootstrapApp.controller('controladorProducto', ['$scope', '$http', function($scope, $http){
  //use $http.get() to get the list of students 
  $http.get('php/producto.php').then(function(response){
    //send back the student data to the list.html view
    $scope.productos = response.data



  });
}]);

bootstrapApp.controller('tableController',function($scope){
  $scope.factura={items:[],};
  $scope.factura.items.push([{
    descripcion:"",
    cantidad:1,
    importe:0
    }]);
  $scope.agregarItem=function(){
    $scope.factura.items.push([{
    descripcion:"",
    cantidad:0,
    importe:0
    }]);
  }
  $scope.eliminarItem = function(m){
    $scope.factura.items.splice($scope.factura.items.indexOf(m),1);
  }
  

}); 


$(document).ready(function(){
  cargar_campos();
  $("#campo").change(function(){dependencia_lote();});  
  $("#lote").attr("disabled",true);
  
});

function cargar_campos()
{
  $.get("scripts/cargar-campos.php", function(resultado){
    if(resultado == false)
    {
      alert("Error");
    }
    else
    {
      $('#campo').append(resultado);      
    }
  }); 
}
function dependencia_lote()
{
  var code = $("#campo").val();
  $.get("scripts/dependencia-lote.php", { code: code },
    function(resultado)
    {
      if(resultado == false)
      {
        alert("Error");
      }
      else
      {
        $("#lote").attr("disabled",false);
        document.getElementById("lote").options.length=1;
        $('#lote').append(resultado);     
      }
    }

  );
}