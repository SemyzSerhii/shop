$(document).on('turbolinks:load', function() {
    var items = document.getElementsByClassName('rating')
    for (var i = 0; i < items.length; i++) {
        items[i].id = i
        var rating = document.getElementById(i).dataset.index
        var disable = 5 - rating
        for (var star = 0; star < 5; star++) {
            var el = document.createElement('li')
            el.setAttribute('class','fa fa-star')
            if (disable !== 0) {
                el.classList.add('disable')
                disable--
            }
            items[i].insertBefore(el, items[i].childNodes[0])
        }
    }
})
