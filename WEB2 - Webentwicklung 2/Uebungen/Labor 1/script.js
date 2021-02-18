console.log('Hello world');

function square(number) {
    console.log(number * number);
}

function verzoegern() {
    setTimeout(function() {
        square(5);
    }, 3000)
}

verzoegern();