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
	
	$(".add_card").click(function(){
		var td = $(this).parent().parent();
		var ul = td.children("ul").append('<li id=' + new Date().getTime() + '><h2 class="edit">Title #2</h2><p class="editable-textile">Text Content #2</p></li>');
		ul.children().draggable({containment: "#board"});
		ul.children().css({position: "absolute", top: ul.parent().position.top, left: ul.parent().position.left});
		editableStickyNotes();
		return false;
	});
	
	$( "td" ).droppable({
		drop: function(event, ui) {
			var card = ui.draggable;
			var ul = $(this).children("ul");
			
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

