$(function(){
  $("form.delete").submit(function(event) {
    event.preventDefault();
    event.stopPropagation();

    var ok = confirm("Are you sure?");
    if (ok) {
       // this.submit();   //this means the event triggered object
       // without submitting to backend, we can use ajax

       var form = $(this);
       var request = $.ajax({ 
          url: form.attr("action"),
          method: form.attr("method")
        });

       request.done(function(data,textStatus,jqXHR) { 
         if (jqXHR.status == 204){    //204 for deleting the todo 
          form.parent("li").remove();
        } else if (jqXHR.status == 200) {   //200 for deleting the list, they need different actions after deleting
           document.location = data;
        }
        });
    }

  });

});