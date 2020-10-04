window.onload = function() {
  console.log('start');
  document.getElementsByTagName('body')[0].classList.add('loading');
  document.getElementById('content').classList.add('loading');
  getYearUpdater(getUrlParameter('year')).then(() => {

    var elements = document.getElementsByClassName('loading');
    for (let element of elements) {
      element.classList.remove("loading");
      console.log(element);
    }
    var elements = document.getElementsByClassName('loading');
    for (let element of elements) {
      element.classList.remove("loading");
      console.log(element);
    }
    var elements = document.getElementsByClassName('loading');
    for (let element of elements) {
      element.classList.remove("loading");
      console.log(element);
    }
    history.replaceState(null, '', 'docket')
    window.location.assign("/docket");
  })
};


const getYearUpdater = async (year) => {
  const response = await fetch('api/year/' + year);
  const json = await response.text();
}

// https://stackoverflow.com/questions/19491336/how-to-get-url-parameter-using-jquery-or-plain-javascript
var getUrlParameter = function getUrlParameter(sParam) {
  var sPageURL = window.location.search.substring(1),
      sURLVariables = sPageURL.split('&'),
      sParameterName,
      i;

  for (i = 0; i < sURLVariables.length; i++) {
      sParameterName = sURLVariables[i].split('=');

      if (sParameterName[0] === sParam) {
          return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
      }
  }
};