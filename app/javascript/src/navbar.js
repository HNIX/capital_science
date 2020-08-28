var navbarToggle = document.getElementById('navbarToggle'),
    navbar       = document.getElementById('navbar');
var  menuOpen = document.getElementById('menuOpen');
var  menuClose = document.getElementById('menuClose');



navbarToggle.addEventListener('click' , function(){

    if (navbar.classList.contains('hidden')) {
        navbar.classList.remove('hidden');
        navbar.classList.add('fadeIn');  
        menuOpen.classList.add('hidden'); 
        menuOpen.classList.remove('block');
        menuClose.classList.add('block');
        menuClose.classList.remove('hidden');
    }else{
        var _classRemover =  function () {
            navbar.classList.remove('fadeIn');   
            navbar.classList.add('fadeOut');
            console.log('removed');
            
            
        };  
        
        var animate = async function(){
            await _classRemover();
            console.log('animated');
            
            setTimeout(function(){
                navbar.classList.add('hidden');
                navbar.classList.remove('fadeOut');
                menuOpen.classList.remove('hidden'); 
                menuOpen.classList.add('block');
                menuClose.classList.remove('block');
                menuClose.classList.add('hidden');
            }, 450);            
        };

        animate();        
    };
    
});