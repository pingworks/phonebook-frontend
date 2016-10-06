// it would be nice to have bower handle all this for us ...
//= require './config.js'
//= require './vendor/lodash/dist/lodash.js'
//= require './vendor/async/lib/async.js'
//= require './vendor/active-support/active-support.js'
//= require './vendor/angular/angular.js'
//= require './vendor/angular-route/angular-route.js'
//= require './vendor/angular-resource/angular-resource.js'
//= require './vendor/ngactiveresource/dist/ng-active-resource.js'

// The angular app:
var phonebook = angular.module('phonebook', ['ngRoute', 'ngResource', 'ActiveResource']);

phonebook.config(function($httpProvider) {
  //Enable cross domain calls
  $httpProvider.defaults.useXDomain = true;

  //Remove the header used to identify ajax call  that would prevent CORS from working
  delete $httpProvider.defaults.headers.common['X-Requested-With'];
});

// service that talks to the backend:
phonebook.factory('Contact', ['ActiveResource', function(ActiveResource){
  function Contact(data){
    this.number('id');
    this.string('name');
    this.string('phone');

    this.validates({
      name: { presence: true },
      phone: { presence: true }
    });
  }

  Contact.inherits(ActiveResource.Base);
  Contact.api.set(backend_url).format('json');

  return Contact;
}])


// contactsController handles front end behaviour
phonebook.controller('contactsController', ['$scope', '$window', 'Contact',
  function($scope, $window, Contact){

    $scope.contacts = [];

    $scope.loadContacts = function(){
      Contact.all().then(function(response) {
        $scope.contacts = response;
      });
    };

    $scope.addContact = function(){
      $scope.newContact.validate();
      $scope.newContact.$save().then(function(response){
        $scope.setupNewContact();
        $scope.newContact.clearErrors();
        $scope.contacts.push(response);
      });
    };

    $scope.remove = function(index){
      var contact = $scope.contacts.splice(index, 1)[0];
      contact.$delete();
    };

    $scope.setupNewContact = function(){
      $scope.newContact = Contact.new();
    };

    $scope.setupNewContact();
    $scope.loadContacts();
}]);




phonebook.directive('inlineEditable', function(){
  return {
    restrict: 'A',
    scope: {
      model: "=inlineEditableModel",
      modelAttribute: "=inlineEditableAttribute"
    },
    link: function(scope, element){
      scope.editing = false;

      element.bind('click', function(){
        if(!scope.editing){
          scope.$apply(edit);
        }
      });

      element.find('input').bind('blur', function(){
        if(scope.editing){
          scope.$apply(cancel);
        }
      });

      function edit(){
        scope.originalContact = angular.copy(scope.model);
        setTimeout(function(){ element.children()[1].focus();}, 10);
        scope.editing = true;
      };

      function cancel(){
        scope.model = scope.originalContact;
        scope.originalContact = null;
        scope.editing = false;
      };

      function save(){
        scope.model.$save().then(function(response){
          scope.model = response;
        });

        scope.originalContact = null;
        scope.editing = false;
      };

      angular.element(element.find('input')[0]).bind('keydown', function(event){
        switch(event.keyCode){
          case 27:
            // ESC cancel edit mode
            scope.$apply(cancel);
            break;
          case 9, 13:
            // TAB, ENTER => save changes
            scope.$apply(save);
            break;
        }
      });

    },
    template: '<span ng-bind="modelAttribute" ng-show="!editing"></span><input type="text" ng-model="modelAttribute" ng-show="editing">'
  };
});


phonebook.directive('confirmationNeeded', function () {
  return {
    priority: 1,
    terminal: true,
    link: function (scope, element, attr) {
      var msg = attr.confirmationNeeded || "Are you sure?";
      var clickAction = attr.ngClick;

      element.bind('click', function () {
        if(window.confirm(msg)){
          scope.$eval(clickAction)
        }
      });
    }
  };
});
