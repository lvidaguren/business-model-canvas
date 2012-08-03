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
	
	$(".add_card").click(function() {
		var td = $(this).parent().parent();
		addCard(td);
		return false;
	});
	
	$("#board td").droppable({
		drop: function(event, ui) {
			var card = ui.draggable;
			var ul = $(this).children("ul");
			moveCard(card, ul, $(this), ui.helper.position().left, ui.helper.position().top);
		}
	});
	
	deleteCard();
});

function editableStickyNotes() {
	// Just to be REST but actualy we use the current_board method to get the current board
	$(".edit").editable("/boards/" + $("#board_key").val() + "/update", {onblur : 'submit'});
	
	$(".editable-title").editable("/cards/update", {onblur : 'submit'});
	
  $(".editable-content").editable("/cards/update", { 
      type      : 'textarea',
      onblur    : 'submit',
      tooltip   : 'Click to edit...'
  });
}

function addCard(td) {
	var page = $("#page").val();
	var ul = td.children("ul").append('<li><div class="delete"></div><div class="clearance"></div><h2 class="editable-title">Card Title</h2><p class="editable-content"></p></li>');
	
	ul.children().draggable({containment: "#board"});
	ul.children().css({position: "absolute", top: ul.parent().position.top, left: ul.parent().position.left});
	
	editableStickyNotes();
	deleteCard();
	
	var card = ul.children().last(); 
	var parameters;
	
	if(page == "board") {
		parameters = {card: {content: "", title: "Card Title", section: td.attr("id"), 
											   board_left: card.position().left, board_top: card.position().top}};	
	} else {
		parameters = {card: {content: "", title: "Card Title", section: td.attr("id"), 
											   section_left: card.position().left, section_top: card.position().top}};	
	}
																	
	$.post("/cards/create", parameters, function(data) {
		var colors = ['purple', 'green', 'yellow', 'red'];
		var colorsHex = ['#CCCCFF', '#CCFFCC', '#FFFFCC', '#FFCCFF'];
		var cardColors = '<div class="card-colors">';
		
		for(var i = 0; i < colors.length; i++) {
			cardColors += '<a href=\"#\" class=\"color-box ' + colors[i] + '" onclick=\"changeCardColor(' + data + ', \'' + colors[i] + '\', \'' + colorsHex[i] + '\'); return false;\"></a>'
		}
		
		cardColors += '</div>';
		
		card.attr("id", data); //setting the card id
		card.children("h2").attr("id", "card_title_" + data);
		card.children("p").attr("id", "card_content_" + data);
		card.append(cardColors);
	});
																			
																			
}


																				

function moveCard(card, cardParent, droppable_area, newLeft, newTop) {
	var page = $("#page").val();
	
	var parameters;
	
	if(page == "board") {
		parameters = {id: card.attr("id"), card: {section: cardParent.parent().attr("id"), board_left: newLeft, board_top: newTop}};	
	} else {
		parameters = {id: card.attr("id"), card: {section: cardParent.parent().attr("id"), section_left: newLeft, section_top: newTop}};	
	}
	
	$.post("/cards/update", parameters);
																
	if($(card).parent() != droppable_area.children("ul")){
		cardParent.append(card);
		cardParent.children().draggable({containment: "#board"});
		$(card).parent().children("#" + card.id).remove();
		editableStickyNotes();
	}
}

function deleteCard() {
	$(".delete").click(function() {
		var li = $(this).parent();
		$.ajax({
	    url: "/cards/" + li.attr("id"),
	    type: "DELETE",
	    success: function(result) {
	    	li.remove();
	    }
		});
	});
}

function changeCardColor(cardID, colorName, colorRGB) {
	$.post('/cards/update', {id: cardID, card: {color: colorName}});
	$('#' + cardID).css({backgroundColor: colorRGB})
}
