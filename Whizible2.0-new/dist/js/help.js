window.addEventListener('DOMContentLoaded', () => {

    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            const id = entry.target.getAttribute('id');
            if (entry.intersectionRatio > 0) {
                document.querySelector(`nav li a[href="#${id}"]`).parentElement.classList.add('active');
            } else {
                document.querySelector(`nav li a[href="#${id}"]`).parentElement.classList.remove('active');
            }
        });
    });

    // Track all sections that have an `id` applied
    document.querySelectorAll('section[id]').forEach((section) => {
        observer.observe(section);
    });

});

$(document).ready(function () {

    //toggle the component with class accordion_body
    $(".accordion_head").click(function () {
        if ($('.accordion_body').is(':visible')) {
            $(".accordion_body").slideUp(300);
            $(".plusminus").text('+');
        }
        if ($(this).next(".accordion_body").is(':visible')) {
            $(this).next(".accordion_body").slideUp(300);
            $(this).children(".plusminus").text('+');
        } else {
            $(this).next(".accordion_body").slideDown(300);
            $(this).children(".plusminus").text('-');
        }
    });

    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            $('#scrollToPageTop').fadeIn('slow');
        } else {
            $('#scrollToPageTop').fadeOut('slow');
        }
    });
    $('#scrollToPageTop').click(function () {
        $("html, body").animate({
            scrollTop: 0
        }, 500);
        return false;
    });

});

function readMore(city) {
 let dots = document.querySelector(`.moreLess[data-city="${city}"] .dots`);
 let moreText = document.querySelector(`.moreLess[data-city="${city}"] .more`); 
 let btnText = document.querySelector(`.moreLess[data-city="${city}"] .myBtn`);

 if (dots.style.display === "none") {
	 dots.style.display = "inline";
	 btnText.textContent = "More";
	 moreText.style.display = "none";
 } else {
	 dots.style.display = "none";
	 btnText.textContent = "Less"; 
	 moreText.style.display = "inline";
 }
}