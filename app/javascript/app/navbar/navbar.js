let app = angular.module('asin_scraper')

app.directive('navbar', [
  () => {
    return {
      link: (scope, element, attributes) => {
        console.log("hello")
      },
      template: "<h1>Yoo</h1>"
    }
  }
])
