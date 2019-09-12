radioYes = document.getElementById("answer_yes")
radioNo = document.getElementById("answer_no")

radioYes.addEventListener('click', function(){

    document.getElementById('consumption').style.display = "block"
    document.getElementById('estimation').style.display = "none"

});


radioNo.addEventListener('click', function(){

    document.getElementById('estimation').style.display = "block"
    document.getElementById('consumption').style.display = "none"

});

});
