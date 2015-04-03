$(document).ready(function() {

	$(".login-button").click(function(){
		$(".box").modal();
	});

	$(".search-button").click(function(evt){
		evt.preventDefault();
		$(".search-results").empty();
		$.ajax({type: "post", url: '/query', data: { query: $(".search-box").val()}, dataType: "JSON"} )
		.done(function(response){
			for (i = 0; i < response.length; i++) {
				// console.log(response)
			$(".search-results").append("<tr><td>"+response[i].date+"</td> <td>"+response[i].shipper+"</td> <td>"+response[i].item+"</td> <td>"+response[i].weight+"</td></tr>")
			};
		});
	});

});
