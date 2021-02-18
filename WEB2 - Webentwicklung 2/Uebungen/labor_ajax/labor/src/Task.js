"use strict";

function Task(title) {
  this.done = false;
  this.title = title || "";
}

Task.prototype.render = function() {
    var $markup;
    var $done = $('<input>', {
        name: 'done',
        type: 'checkbox',
        checked: this.done
    });

    var $title = $('<input>', {
        name: 'title',
        type: 'text'
    }).val(this.title);

    return $('<li>').append([$done, $title]);

};

