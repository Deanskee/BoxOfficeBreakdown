var apikey = "6mzfwbzt4ev3k9ey6jwxykdq";
var baseUrl = "http://api.rottentomatoes.com/api/public/v1.0";
// http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=6mzfwbzt4ev3k9ey6jwxykdq

// construct the uri with our apikey
var moviesUpcomingUrl = baseUrl + '/lists/movies/upcoming.json?apikey=' + apikey;
var moviesBoxOfficeUrl = baseUrl + '/lists/movies/box_office.json?apikey=' + apikey;
var query = "movies";

$(document).ready(function() {

  // send off the query
  $.ajax({
    url: moviesUpcomingUrl + '&q=' + encodeURI(query),
    dataType: "jsonp",
    success: searchCallback
  });
    $.ajax({
    url: moviesBoxOfficeUrl + '&q=' + encodeURI(query),
    dataType: "jsonp",
    success: searchCallback
  });
});

// callback for when we get back the results


function searchCallback(data) {
	console.log(data)
 // $('#test').append('Found ' + data.total + ' results for ' + query);
 var movies = data.movies;
 $.each(movies, function(index, movie) {
   $('#movietitle').append('<li>' + movie.title + '</li>');
   $('#dates').append('<li>' + movie.release_dates.theater + '</li>');
   
 });
}