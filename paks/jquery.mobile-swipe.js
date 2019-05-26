/* 
/paks/jquery.mobile-swipe.js
*/ 

$.fn.extend({
    createBtn: function () {
        var elmWidth = $("li", $(this)).width(),
            listType = $(this).listview("option", "inset") ? true : false,
            btnWidth = elmWidth < 300 && listType ? "35%" : elmWidth > 300 && !listType ? "25%" : "20%";
        $("li", $(this)).each(function () {
            var text = $(this).html();
            $(this).html($("<div/>", {
                class: "wrapper"
            }).append($("<div/>", {
                class: "go"
            }).text("Save").width(btnWidth)).append($("<div/>", {
                class: "item"
            }).text(text)).append($("<div/>", {
                class: "del"
            }).text("Delete").width(btnWidth)).css({
                left: "-" + btnWidth
            }).on("swipeleft swiperight vclick tap", function (e) {

                $(this).revealBtn(e, btnWidth);
            }) /**/ );
        });
    },
    revealBtn: function (e, x) {
        var check = this.check(x),
            swipe = e.type;
        if (check == "closed") {
            swipe == "swiperight" ? this.open(e, x, "left") : swipe == "swipeleft" ? this.open(e, x, "right") : setTimeout(function () {
                this.close(e);
            }, 0);
            e.stopImmediatePropagation();
        }
        if (check == "right" || check == "left") {
            swipe == "swiperight" ? this.open(e, "left") : swipe == "swipeleft" ? this.open(e, x, "right") : setTimeout(function () {
                this.close(e);
            }, 0);
            e.stopImmediatePropagation();
        }
        if (check !== "closed" && e.isImmediatePropagationStopped() && (swipe == "vclick" || swipe == "tap")) {
            this.close(e);
        }
    },
    close: function (e) {
        var check = this.check();
        this.css({
            transform: "translateX(0)"
        });
    },
    open: function (e, x, dir) {
        var posX = dir == "left" ? x : "-" + x;
        $(this).css({
            transform: "translateX(" + posX + ")"
        });
    },
    check: function (x) {
        var matrix = this.css("transform").split(" "),
            posY = parseInt(matrix[matrix.length - 2], 10),
            btnW = (this.width() * parseInt(x) / 100) / 1.1;
        return isNaN(posY) ? "closed" : posY >= btnW ? "left" : posY <= "-" + btnW ? "right" : "closed";
    }
});

$(document).on("pagecreate", function () {
    $("ul").createBtn();
});
