// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
// Loads all Bootstrap javascripts
//= require bootstrap


$(document).ready(function() {
	editableStickyNotes();
	
	$( ".resizable" ).resizable({
		animate: true
	});
	
	$(".embedded-resizable").resizable({
		animate: true,
		alsoResize: ".board-outline"
	});
	
	$("#board ul li").draggable({containment: "#board"});
	
	$(".add_card").click(function(){
		var td = $(this).parent().parent();
		var ul = td.children("ul").append('<li><h2 class="edit">Card Title</h2><p class="editable-textile"></p></li>');
		
		ul.children().draggable({containment: "#board"});
		ul.children().css({position: "absolute", top: ul.parent().position.top, left: ul.parent().position.left});
		
		editableStickyNotes();
		
		var card = ul.children().last(); 
		var board_id = $("#board_id").val();
		$.post("/cards/create", {card: {content: "", title: "Card Title", section: td.attr("id"), 
																		left: card.position().left, top: card.position().top, board_id: board_id}}, function(data) {
																			card.attr("id", data); // setting the card it
																		});
		
		return false;
	});
	
	$("td").droppable({
		drop: function(event, ui) {
			var card = ui.draggable;
			var ul = $(this).children("ul");
			
			$.post("/cards/update", {id: card.attr("id"), card: {section: ul.parent().attr("id"), left: ui.helper.position().left, 
																													top: ui.helper.position().top}});
																		
			if($(card).parent() != $(this).children("ul")){
				ul.append(card);
				ul.children().draggable({containment: "#board"});
				$(card).parent().children("#" + card.id).remove();
				editableStickyNotes();
			}
		}
	});
	
});

function editableStickyNotes() {
	$('.edit').editable('/home/save');
	
  $(".editable-textile").editable("/home/save", { 
  		loadurl   : "/home/load",
      type      : 'textarea',
      onblur    : 'submit',
      tooltip   : 'Click to edit...'
  });
}

